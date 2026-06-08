import 'package:cloud_firestore/cloud_firestore.dart';

class PumpLogModel {
  final String logId;
  final String status;
  final int durationMin;
  final DateTime startedAt;

  PumpLogModel({
    required this.logId,
    required this.status,
    required this.durationMin,
    required this.startedAt,
  });

  factory PumpLogModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PumpLogModel(
      logId: doc.id,
      status: data['status'] ?? 'nonaktif',
      durationMin: data['durationMin'] ?? 0,
      startedAt: (data['startedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'durationMin': durationMin,
      'startedAt': Timestamp.fromDate(startedAt),
    };
  }
}
