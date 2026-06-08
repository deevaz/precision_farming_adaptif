import 'package:cloud_firestore/cloud_firestore.dart';

class DeviceModel {
  final String deviceId;
  final String userId;
  final String name;
  final String status;
  final DateTime? lastSeen;

  DeviceModel({
    required this.deviceId,
    required this.userId,
    required this.name,
    this.status = 'offline',
    this.lastSeen,
  });

  bool get isOnline {
    if (lastSeen == null) return false;

    final threshold = Duration(minutes: 2);
    final difference = DateTime.now().difference(lastSeen!);

    return difference < threshold;
  }

  factory DeviceModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return DeviceModel(
      deviceId: doc.id,
      userId: data['userId'] ?? '',
      name: data['name'] ?? '',
      status: data['status'] ?? 'offline',
      lastSeen: (data['lastSeen'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'name': name,
      'status': status,
      'lastSeen': lastSeen != null ? Timestamp.fromDate(lastSeen!) : null,
    };
  }
}
