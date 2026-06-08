import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class NoteModel {
  final String noteId;
  final String content;
  final DateTime createdAt;

  NoteModel({
    required this.noteId,
    required this.content,
    required this.createdAt,
  });

  String get formattedDate {
    final localDate = createdAt.toLocal();

    return DateFormat('dd MMMM yyyy, HH:mm', 'id_ID').format(localDate);
  }

  String get formattedFullDateTime {
    final localDate = createdAt.toLocal();

    return DateFormat('dd MMMM yyyy, HH:mm', 'id_ID').format(localDate);
  }

  String get formattedTime => DateFormat('HH:mm').format(createdAt.toLocal());

  factory NoteModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return NoteModel(
      noteId: doc.id,
      content: data['content'] ?? '',

      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'content': content,

      'createdAt': Timestamp.fromDate(createdAt.toUtc()),
    };
  }
}
