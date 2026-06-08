import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:kelola_tani/app/data/models/note_model.dart';
import 'package:kelola_tani/app/services/firestore_service.dart';
import 'package:kelola_tani/app/services/snackbar_service.dart';

class NotesController extends GetxController {
  final FirestoreService _firestore = FirestoreService();

  final notesList = <NoteModel>[].obs;

  final isLoading = false.obs;
  final isLoadMore = false.obs;
  final isLastPage = false.obs;

  DocumentSnapshot? _lastDocument;
  final int _limit = 10;

  String deviceId = Get.arguments?['deviceId'] ?? 'KTANI-A1B2C3D4E5F6';
  final String uid = '02QnFCV4Woh7VAqar9oMY0us4W03';

  String deviceName = Get.arguments?['deviceName'] ?? 'Perangkat';

  @override
  void onInit() {
    super.onInit();
    fetchNotes();
  }

  Future<void> fetchNotes() async {
    try {
      isLoading.value = true;
      isLastPage.value = false;
      _lastDocument = null;

      final snapshot = await _firestore.getNotesPaged(
        uid,
        deviceId,
        limit: _limit,
      );

      if (snapshot.docs.isNotEmpty) {
        _lastDocument = snapshot.docs.last;
        notesList.assignAll(
          snapshot.docs.map((doc) => NoteModel.fromFirestore(doc)).toList(),
        );

        if (snapshot.docs.length < _limit) isLastPage.value = true;
      } else {
        notesList.clear();
        isLastPage.value = true;
      }
    } catch (e) {
      SnackbarService.error('Error', 'Gagal memuat catatan');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMoreNotes() async {
    if (isLoadMore.value || isLastPage.value) return;

    try {
      isLoadMore.value = true;

      final snapshot = await _firestore.getNotesPaged(
        uid,
        deviceId,
        lastDocument: _lastDocument,
        limit: _limit,
      );

      if (snapshot.docs.isNotEmpty) {
        _lastDocument = snapshot.docs.last;
        final newNotes = snapshot.docs
            .map((doc) => NoteModel.fromFirestore(doc))
            .toList();
        notesList.addAll(newNotes);

        if (snapshot.docs.length < _limit) isLastPage.value = true;
      } else {
        isLastPage.value = true;
      }
    } catch (e) {
      print("Error Load More: $e");
    } finally {
      isLoadMore.value = false;
    }
  }

  Future<void> addNote(DateTime time, String content) async {
    try {
      final newNote = NoteModel(noteId: '', content: content, createdAt: time);

      await _firestore.addNote(uid, deviceId, newNote);
      fetchNotes();
      SnackbarService.success('Berhasil', 'Catatan ditambahkan');
    } catch (e) {
      SnackbarService.error('Gagal', 'Gagal menambah catatan');
    }
  }

  Future<void> editNote(
    NoteModel note,
    DateTime newTime,
    String newContent,
  ) async {
    try {
      final updatedNote = NoteModel(
        noteId: note.noteId,
        content: newContent,
        createdAt: newTime,
      );

      await _firestore.updateNote(uid, deviceId, updatedNote);

      int index = notesList.indexWhere(
        (element) => element.noteId == note.noteId,
      );
      if (index != -1) {
        notesList[index] = updatedNote;
      }

      SnackbarService.success('Berhasil', 'Catatan diperbarui');
    } catch (e) {
      SnackbarService.error('Gagal', 'Gagal memperbarui catatan');
    }
  }

  Future<void> deleteNote(String noteId) async {
    try {
      await _firestore.deleteNote(uid, deviceId, noteId);
      notesList.removeWhere((element) => element.noteId == noteId);
      SnackbarService.success('Berhasil', 'Catatan dihapus');
    } catch (e) {
      SnackbarService.error('Gagal', 'Gagal menghapus catatan');
    }
  }
}
