import 'package:cloud_firestore/cloud_firestore.dart';

class DeviceRegistryModel {
  final String deviceId;
  final String userId;
  final String status;
  final DateTime? lastSeen;

  DeviceRegistryModel({
    required this.deviceId,
    this.userId = '',
    this.status = 'offline',
    this.lastSeen,
  });

  factory DeviceRegistryModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return DeviceRegistryModel(
      deviceId: doc.id,
      userId: data['userId'] ?? '',
      status: data['status'] ?? 'offline',
      lastSeen: (data['lastSeen'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'status': status,
      'lastSeen': lastSeen != null ? Timestamp.fromDate(lastSeen!) : null,
    };
  }
}
