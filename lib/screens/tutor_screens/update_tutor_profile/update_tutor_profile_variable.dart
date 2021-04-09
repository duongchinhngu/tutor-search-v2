import 'package:flutter/material.dart';

//validator for all input field
GlobalKey<FormState> updateTutorFormkey = GlobalKey<FormState>();

//
String avatarUpdateUrl = '';
//
String socialIdUrl = '';
//
//list of certificationImg
List<String> certificationImages = [];

//
TextEditingController nameController = TextEditingController();
TextEditingController genderController = TextEditingController();
TextEditingController birthdayController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController phoneController = TextEditingController();
TextEditingController addressController = TextEditingController();
TextEditingController educationLevelController = TextEditingController();
TextEditingController universityController = TextEditingController();
TextEditingController descriptionController = TextEditingController();

void resetTextController() {
  nameController.clear();
  genderController.clear();
  birthdayController.clear();
  emailController.clear();
  phoneController.clear();
  addressController.clear();
  educationLevelController.clear();
  universityController.clear();

//socialId image

//list of certificationImg
  certificationImages = [];
}
