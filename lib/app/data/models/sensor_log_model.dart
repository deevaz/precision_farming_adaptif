import 'package:cloud_firestore/cloud_firestore.dart';

class SensorLogModel {
  final String logId;
  final double nitrogen;
  final double phosphor;
  final double kalium;
  final double suhu;
  final double ec;
  final double kelembapanTanah;
  final double kelembapanUdara;
  final DateTime recordedAt;

  SensorLogModel({
    required this.logId,
    required this.nitrogen,
    required this.phosphor,
    required this.kalium,
    required this.suhu,
    required this.ec,
    required this.kelembapanTanah,
    required this.kelembapanUdara,
    required this.recordedAt,
  });

  factory SensorLogModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return SensorLogModel(
      logId: doc.id,
      nitrogen: (data['nitrogen'] ?? 0).toDouble(),
      phosphor: (data['phosphor'] ?? 0).toDouble(),
      kalium: (data['kalium'] ?? 0).toDouble(),
      suhu: (data['suhu'] ?? 0).toDouble(),
      ec: (data['ec'] ?? 0).toDouble(),
      kelembapanTanah: (data['kelembapanTanah'] ?? 0).toDouble(),
      kelembapanUdara: (data['kelembapanUdara'] ?? 0).toDouble(),
      recordedAt: (data['recordedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nitrogen': nitrogen,
      'phosphor': phosphor,
      'kalium': kalium,
      'suhu': suhu,
      'ec': ec,
      'kelembapanTanah': kelembapanTanah,
      'kelembapanUdara': kelembapanUdara,
      'recordedAt': Timestamp.fromDate(recordedAt),
    };
  }
}
