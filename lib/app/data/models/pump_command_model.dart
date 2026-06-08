import 'package:cloud_firestore/cloud_firestore.dart';

class PumpCommandModel {
  final String action;
  final int duration;
  final DateTime sentAt;
  final bool executed;

  PumpCommandModel({
    required this.action,
    required this.duration,
    required this.sentAt,
    this.executed = false,
  });

  factory PumpCommandModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PumpCommandModel(
      action: data['action'] ?? 'off',
      duration: data['duration'] ?? 0,
      sentAt: (data['sentAt'] as Timestamp).toDate(),
      executed: data['executed'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'action': action,
      'duration': duration,
      'sentAt': Timestamp.fromDate(sentAt),
      'executed': executed,
    };
  }
}
