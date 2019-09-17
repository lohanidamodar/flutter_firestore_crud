import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firestore_crud/data/model/note.dart';

class FirestoreService {
  static final FirestoreService _firestoreService =
      FirestoreService._internal();
  Firestore _db = Firestore.instance;

  FirestoreService._internal();

  factory FirestoreService() {
    return _firestoreService;
  }

  Stream<List<Note>> getNotes() {
    return _db.collection('notes').snapshots().map(
          (snapshot) => snapshot.documents.map(
            (doc) => Note.fromMap(doc.data, doc.documentID),
          ).toList(),
        );
  }

  Future<void> addNote(Note note) {
    return _db.collection('notes').add(note.toMap());
  }

  Future<void> deleteNote(String id) {
    return _db.collection('notes').document(id).delete();
  }

  Future<void> updateNote(Note note) {
    return _db.collection('notes').document(note.id).updateData(note.toMap());
  }

}
