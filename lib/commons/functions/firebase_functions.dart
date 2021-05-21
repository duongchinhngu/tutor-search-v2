import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';

//post file on Firbase storage and return URL
Future<String> uploadFileOnFirebaseStorage(File file) async {
  firebase_storage.StorageReference ref =
      firebase_storage.FirebaseStorage.instance.ref().child(file.path);
  firebase_storage.StorageUploadTask uploadTask = await ref.putFile(file);
  firebase_storage.StorageTaskSnapshot storageTaskSnapshot =
      await uploadTask.onComplete;
  return await await FirebaseStorage.instance
      .ref()
      .child(file.path)
      .getDownloadURL();
}
