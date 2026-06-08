import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../data/models/device_model.dart';
import '../data/models/device_config_model.dart';
import '../data/models/device_registry_model.dart';
import '../data/models/pump_command_model.dart';
import '../data/models/sensor_log_model.dart';
import '../data/models/pump_log_model.dart';
import '../data/models/note_model.dart';
import '../data/models/user_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  static FirestoreService get to => Get.find<FirestoreService>();

  CollectionReference _userRef() => _db.collection('users');
  CollectionReference _registryRef() => _db.collection('devices');

  CollectionReference _deviceRef(String uid) =>
      _userRef().doc(uid).collection('devices');

  CollectionReference _sensorLogRef(String uid, String deviceId) =>
      _deviceRef(uid).doc(deviceId).collection('sensorLogs');

  CollectionReference _pumpLogRef(String uid, String deviceId) =>
      _deviceRef(uid).doc(deviceId).collection('pumpLogs');

  CollectionReference _noteRef(String uid, String deviceId) =>
      _deviceRef(uid).doc(deviceId).collection('notes');

  DocumentReference _configRef(String uid, String deviceId) =>
      _deviceRef(uid).doc(deviceId).collection('config').doc('settings');

  DocumentReference _commandRef(String uid, String deviceId) =>
      _deviceRef(uid).doc(deviceId).collection('command').doc('pump');

  Future<void> createUser(UserModel user) async {
    await _userRef().doc(user.uid).set(user.toMap());
  }

  Future<UserModel?> getUser(String uid) async {
    final doc = await _userRef().doc(uid).get();
    if (!doc.exists) return null;
    return UserModel.fromFirestore(doc);
  }

  Stream<SensorLogModel?> streamLatestSensorLog(String uid, String deviceId) {
    return _sensorLogRef(uid, deviceId)
        .orderBy('recordedAt', descending: true)
        .limit(1)
        .snapshots()
        .map((snapshot) {
          if (snapshot.docs.isEmpty) return null;
          return SensorLogModel.fromFirestore(snapshot.docs.first);
        });
  }

  Future<DeviceRegistryModel?> getDeviceRegistry(String deviceId) async {
    final doc = await _registryRef().doc(deviceId).get();
    if (!doc.exists) return null;
    return DeviceRegistryModel.fromFirestore(doc);
  }

  Future<bool> isDeviceValid(String deviceId) async {
    final doc = await _registryRef().doc(deviceId).get();
    return doc.exists;
  }

  Future<bool> isDeviceTaken(String deviceId) async {
    final doc = await _registryRef().doc(deviceId).get();
    if (!doc.exists) return false;
    final data = doc.data() as Map<String, dynamic>;
    return (data['userId'] ?? '').toString().isNotEmpty;
  }

  Future<void> triggerManualUpdate(String uid, String deviceId) async {
    await _commandRef(uid, deviceId).update({'requestUpdate': true});
  }

  Future<void> claimDevice(String uid, String deviceId, String name) async {
    await _registryRef().doc(deviceId).update({'userId': uid});

    await _deviceRef(
      uid,
    ).doc(deviceId).set({'name': name, 'status': 'offline', 'lastSeen': null});

    final defaultConfig = DeviceConfigModel(
      targetEC: 1.5,
      growthPhase: 'vegetatif',
      pumpDurationMin: 0,
      pumpDebitMLperS: 0,
      operatingMode: 'manual',
    );
    await updateConfig(uid, deviceId, defaultConfig);

    final defaultCommand = PumpCommandModel(
      action: 'off',
      duration: 0,
      executed: true,
      sentAt: DateTime.now(),
    );
    await sendPumpCommand(uid, deviceId, defaultCommand);

    final initialSensorLog = SensorLogModel(
      nitrogen: 0.0,
      phosphor: 0.0,
      kalium: 0.0,
      suhu: 0.0,
      ec: 0.0,
      kelembapanTanah: 0.0,
      kelembapanUdara: 0.0,
      logId: '',
      recordedAt: DateTime.now(),
    );
    await _sensorLogRef(uid, deviceId).add(initialSensorLog.toMap());

    final initialPumpLog = PumpLogModel(
      status: 'system_init',
      durationMin: 0,
      logId: '',
      startedAt: DateTime.now(),
    );
    await addPumpLog(uid, deviceId, initialPumpLog);

    final initialNote = NoteModel(
      content:
          'Device $name berhasil ditambahkan ke sistem pemantauan paprika.',
      noteId: '',
      createdAt: DateTime.now(),
    );
    await addNote(uid, deviceId, initialNote);
  }

  Future<QuerySnapshot> getNotesPaged(
    String uid,
    String deviceId, {
    DocumentSnapshot? lastDocument,
    int limit = 10,
  }) async {
    Query query = _noteRef(
      uid,
      deviceId,
    ).orderBy('createdAt', descending: true).limit(limit);

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    return await query.get();
  }

  Future<void> updateNote(String uid, String deviceId, NoteModel note) async {
    await _noteRef(uid, deviceId).doc(note.noteId).update(note.toMap());
  }

  Stream<List<DeviceModel>> streamDevices(String uid) {
    return _deviceRef(uid).snapshots().map(
      (snapshot) =>
          snapshot.docs.map((doc) => DeviceModel.fromFirestore(doc)).toList(),
    );
  }

  Future<void> addDevice(String uid, DeviceModel device) async {
    await _deviceRef(uid).doc(device.deviceId).set(device.toMap());
  }

  Future<bool> isDeviceExists(String uid, String deviceId) async {
    final doc = await _deviceRef(uid).doc(deviceId).get();
    return doc.exists;
  }

  Future<void> updateDeviceStatus(
    String uid,
    String deviceId,
    String status,
  ) async {
    await _deviceRef(uid).doc(deviceId).update({
      'status': status,
      'lastSeen': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteDevice(String uid, String deviceId) async {
    await _registryRef().doc(deviceId).update({
      'userId': '',
      'status': 'offline',
    });
    await _deviceRef(uid).doc(deviceId).delete();
  }

  Stream<DeviceConfigModel?> streamConfig(String uid, String deviceId) {
    return _configRef(uid, deviceId).snapshots().map((doc) {
      if (!doc.exists) return null;
      return DeviceConfigModel.fromFirestore(doc);
    });
  }

  Future<void> updateConfig(
    String uid,
    String deviceId,
    DeviceConfigModel config,
  ) async {
    await _configRef(
      uid,
      deviceId,
    ).set(config.toMap(), SetOptions(merge: true));
  }

  Future<void> updateOperatingMode(
    String uid,
    String deviceId,
    String mode,
  ) async {
    await _configRef(
      uid,
      deviceId,
    ).set({'operatingMode': mode}, SetOptions(merge: true));
  }

  Stream<PumpCommandModel?> streamPumpCommand(String uid, String deviceId) {
    return _commandRef(uid, deviceId).snapshots().map((doc) {
      if (!doc.exists) return null;
      return PumpCommandModel.fromFirestore(doc);
    });
  }

  Future<void> sendPumpCommand(
    String uid,
    String deviceId,
    PumpCommandModel command,
  ) async {
    await _commandRef(uid, deviceId).set(command.toMap());
  }

  Stream<List<SensorLogModel>> streamSensorLogs(
    String uid,
    String deviceId,
    DateTime date,
  ) {
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(const Duration(days: 1));

    return _sensorLogRef(uid, deviceId)
        .where(
          'recordedAt',
          isGreaterThanOrEqualTo: Timestamp.fromDate(start),
          isLessThan: Timestamp.fromDate(end),
        )
        .orderBy('recordedAt')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => SensorLogModel.fromFirestore(doc))
              .toList(),
        );
  }

  Stream<List<SensorLogModel>> streamSensorLogsByRange(
    String uid,
    String deviceId,
    DateTime start,
    DateTime end,
  ) {
    return _sensorLogRef(uid, deviceId)
        .where('recordedAt', isGreaterThanOrEqualTo: Timestamp.fromDate(start))
        .where('recordedAt', isLessThanOrEqualTo: Timestamp.fromDate(end))
        .orderBy('recordedAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => SensorLogModel.fromFirestore(doc))
              .toList(),
        );
  }

  Stream<List<PumpLogModel>> streamPumpLogs(String uid, String deviceId) {
    return _pumpLogRef(uid, deviceId)
        .orderBy('startedAt', descending: true)
        .limit(10)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => PumpLogModel.fromFirestore(doc))
              .toList(),
        );
  }

  Future<void> addPumpLog(String uid, String deviceId, PumpLogModel log) async {
    await _pumpLogRef(uid, deviceId).add(log.toMap());
  }

  Stream<List<NoteModel>> streamNotes(String uid, String deviceId) {
    return _noteRef(uid, deviceId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => NoteModel.fromFirestore(doc)).toList(),
        );
  }

  Future<void> addNote(String uid, String deviceId, NoteModel note) async {
    await _noteRef(uid, deviceId).add(note.toMap());
  }

  Future<void> deleteNote(String uid, String deviceId, String noteId) async {
    await _noteRef(uid, deviceId).doc(noteId).delete();
  }

  Stream<DeviceModel?> streamSingleDevice(String uid, String deviceId) {
    return _deviceRef(uid).doc(deviceId).snapshots().map((doc) {
      if (!doc.exists) return null;
      return DeviceModel.fromFirestore(doc);
    });
  }
}
