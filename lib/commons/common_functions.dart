import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'global_variables.dart' as globals;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

//convert timeofday type to string value
String convertTimeOfDayToString(TimeOfDay time) {
  return globals.timeFormatter
      .format(new DateTime(1990, 1, 1, time.hour, time.minute, 0));
}

//convert timeOfDay type to string
// has format : yyyy-MM-ddThh:mm
// the same format as backend format
String convertTimeOfDayToAPIFormatString(TimeOfDay time) {
  return globals.defaultDatetime +
      'T' +
      globals.timeFormatter
          .format(new DateTime(1990, 1, 1, time.hour, time.minute, 0));
}

//convert DateTime type to string value
String convertDayTimeToString(DateTime date) {
  return globals.dateFormatter.format(date);
}

//post file on Firbase storage and return URL
Future<String> uploadFileOnFirebaseStorage(File file) async {
  firebase_storage.Reference ref =
      firebase_storage.FirebaseStorage.instance.ref().child(file.path);
  firebase_storage.TaskSnapshot uploadTask = await ref.putFile(file);
  return await uploadTask.ref.getDownloadURL();
}

//select image from storage
Future<File> getImageFromGallery() async {
  // ignore: deprecated_member_use
  return await ImagePicker.pickImage(source: ImageSource.gallery);
}

//select image from taking picture
Future<File> getImageFromCamera() async {
  // ignore: deprecated_member_use
  return await ImagePicker.pickImage(source: ImageSource.camera);
}
