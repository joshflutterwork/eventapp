import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebaseStorage;

class FirebaseDB {
  firebaseStorage.FirebaseStorage storage =
      firebaseStorage.FirebaseStorage.instance;
  Stream<QuerySnapshot> eventStream() {
    return FirebaseFirestore.instance.collection('event').snapshots();
  }

  Future<String> getDownloadUrl(String mediaUrl) async {
    firebaseStorage.Reference ref = storage.ref(mediaUrl);

    try {
      return await ref
          .getDownloadURL()
          .then((value) => value.toString())
          .catchError((e) {
        return e.message.toString();
      });
    } catch (e) {
      return e.message.toString();
    }
  }

  Future uploadFileToStorage(File file, String name) async {
    try {
      firebaseStorage.Reference firebaseStorageRef =
          storage.ref().child('eventpicture/$name');
      firebaseStorage.UploadTask uploadTask = firebaseStorageRef.putFile(file);
      uploadTask.whenComplete(() => {print('complete')});
    } catch (e) {
      print(e);
    }
  }

  addEvent(Map<String, dynamic> data) {
    CollectionReference newMessage =
        FirebaseFirestore.instance.collection('event');

    return newMessage
        .add(data)
        .then((value) => print("Message Added"))
        .catchError((error) => print("error"));
  }
}

class FirebaseBloc {
  Stream<QuerySnapshot> streamChat;
  Stream<String> streamFile;
  String chat;
  Repository _repository = Repository();

  final downloadUrl = BehaviorSubject<String>();
  // final chatFetcher = BehaviorSubject<Stream<QuerySnapshot>>();

  Stream<String> get streamDownloadUrl => downloadUrl.stream;

  getDownloadUrl(String messageText) async {
    try {
      downloadUrl.sink.add(null);
      chat = await _repository.getDownloadUrl(messageText);
      downloadUrl.sink.add(chat);
    } catch (e) {
      downloadUrl.sink.addError(e.toString());
    }
  }

  dispose() {
    if (downloadUrl.isClosed != false) downloadUrl.close();
  }
}

class Repository {
  FirebaseDB firebase = FirebaseDB();
  Future getDownloadUrl(String message) => firebase.getDownloadUrl(message);
}
