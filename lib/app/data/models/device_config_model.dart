import 'package:cloud_firestore/cloud_firestore.dart';

class DeviceConfigModel {
  final double targetEC;
  final String growthPhase;
  final int pumpDurationMin;
  final int pumpDebitMLperS;
  final DateTime? updatedAt;
  final String operatingMode;

  DeviceConfigModel({
    this.targetEC = 1.6,
    this.growthPhase = 'Vegetatif',
    this.pumpDurationMin = 15,
    this.pumpDebitMLperS = 20,
    this.updatedAt,
    this.operatingMode = 'manual',
  });

  factory DeviceConfigModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return DeviceConfigModel(
      targetEC: (data['targetEC'] ?? 1.6).toDouble(),
      growthPhase: data['growthPhase'] ?? 'Vegetatif',
      pumpDurationMin: data['pumpDurationMin'] ?? 15,
      pumpDebitMLperS: data['pumpDebitMLperS'] ?? 20,
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate(),
      operatingMode: data['operatingMode'] ?? 'manual',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'targetEC': targetEC,
      'growthPhase': growthPhase,
      'pumpDurationMin': pumpDurationMin,
      'pumpDebitMLperS': pumpDebitMLperS,
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
      'operatingMode': operatingMode,
    };
  }
}
