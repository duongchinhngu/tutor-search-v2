import 'dart:io';

import 'package:flutter/material.dart';


//
File avatartUpdate;
//socialId image
File socialIdImage;
//list of certificationImg
List<File> certificationImages = [
  File(
      'assets\images\education-concept-vector-illustration-in-flat-style-online-education-school-university-creative-ideas.jpg')
];

//
TextEditingController nameController = TextEditingController();
TextEditingController genderController = TextEditingController();
TextEditingController birthdayController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController phoneController = TextEditingController();
TextEditingController addressController = TextEditingController();
TextEditingController educationLevelController = TextEditingController();
TextEditingController universityController = TextEditingController();

void resetTextController() {
  nameController.clear();
  genderController.clear();
  birthdayController.clear();
  emailController.clear();
  phoneController.clear();
  addressController.clear();
  educationLevelController.clear();
  universityController.clear();
  avatartUpdate = null;
//socialId image
  socialIdImage = null;
//list of certificationImg
  certificationImages = [
    File(
        'assets\images\education-concept-vector-illustration-in-flat-style-online-education-school-university-creative-ideas.jpg')
  ];
}
