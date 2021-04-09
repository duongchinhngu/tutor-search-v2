import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/functions/common_functions.dart';
import 'package:tutor_search_system/commons/functions/firebase_functions.dart';
import 'package:tutor_search_system/commons/global_variables.dart';
import 'package:tutor_search_system/commons/styles.dart';
import 'package:tutor_search_system/cubits/image_cubit.dart';
import 'package:tutor_search_system/models/tutor.dart';
import 'package:tutor_search_system/repositories/image_repository.dart';
import 'package:tutor_search_system/screens/common_ui/common_buttons.dart';
import 'package:tutor_search_system/screens/common_ui/error_screen.dart';
import 'package:tutor_search_system/screens/common_ui/full_screen_image.dart';
import 'package:tutor_search_system/screens/common_ui/no_data_screen.dart';
import 'package:tutor_search_system/screens/common_ui/waiting_indicator.dart';
import 'package:tutor_search_system/screens/tutor_screens/update_tutor_profile/update_tutor_profile_variable.dart';
import 'package:tutor_search_system/states/image_state.dart';

class UpdateTutorProfileScreen extends StatefulWidget {
  final Tutor tutor;

  const UpdateTutorProfileScreen({Key key, @required this.tutor})
      : super(key: key);
  @override
  _UpdateTutorProfileScreenState createState() =>
      _UpdateTutorProfileScreenState();
}

class _UpdateTutorProfileScreenState extends State<UpdateTutorProfileScreen> {
  //init controllers
  void initTextController() {
    nameController.text = widget.tutor.fullname;
    genderController.text = widget.tutor.gender;
    birthdayController.text = widget.tutor.birthday;
    emailController.text = widget.tutor.email;
    phoneController.text = widget.tutor.phone;
    addressController.text = widget.tutor.address;
    educationLevelController.text = widget.tutor.educationLevel;
    universityController.text = widget.tutor.school;
  }

  void initImage() {
    avatarUpdateUrl = widget.tutor.avatarImageLink;
    socialIdUrl = widget.tutor.socialIdUrl;
    //
    // List<String> imgs = ImageRepository()
    //     .fetchImageByEmail(http.Client(), widget.tutor.email, 'certification')
    //     .toString()
    //     .replaceFirst(']', '')
    //     .replaceFirst('[', '')
    //     .split(', ');

    // //
    // certificationImages.insertAll(1, imgs);
  }

  @override
  void initState() {
    //
    initTextController();
    //
    initImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: buildAppBar(context),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: mainColor,
        onPressed: () {
          //validate
          if (updateTutorFormkey.currentState.validate()) {
            updateTutorFormkey.currentState.save();
            //

          }
        },
        label: Text('Save Update'),
      ),
      body: Form(
        key: updateTutorFormkey,
        child: Container(
          child: ListView(
            children: [
              //avatar reset
              GestureDetector(
                onTap: () async {
                  // ignore: deprecated_member_use
                  var image =
                      await ImagePicker.pickImage(source: ImageSource.gallery);
                  String imageUrl = await uploadFileOnFirebaseStorage(image);
                  setState(() {
                    avatarUpdateUrl = imageUrl;
                  });
                },
                child: Container(
                  height: 200,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      //circle blue box behind the circle avatar
                      Container(
                        height: 175,
                        width: 175,
                        decoration: BoxDecoration(
                          // color: Colors.blue[500].withOpacity(0.35),
                          shape: BoxShape.circle,
                        ),
                      ),
                      //avartar
                      CircleAvatar(
                        foregroundColor: Colors.green,
                        radius: 80,
                        backgroundImage: NetworkImage(
                            //         // state.tutor.avatarImageLink,
                            avatarUpdateUrl),
                      ),
                      //edit avartar icon
                      Positioned(
                        bottom: 15,
                        right: 110,
                        child: Container(
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            shape: BoxShape.circle,
                          ),
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              // color: Colors.blue[500].withOpacity(0.35),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              color: textGreyColor,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              //fullname
              buildTutorInfo(
                  'Fullname',
                  Container(
                    height: 43,
                    child: TextFormField(
                      controller: nameController,
                      maxLength: 100,
                      textAlign: TextAlign.start,
                      onChanged: (context) {
                        //set name = value of this textFormfield on change
                        setState(() {
                          // course.name = courseNameController.text;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: '',
                        labelStyle: textStyle,
                        fillColor: Color(0xffF9F2F2),
                        filled: true,
                        focusedBorder: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: Colors.transparent, width: 0.0),
                        ),
                        hintText: 'What should we call you',
                        counterText: '',
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontSize: textFontSize,
                        ),
                      ),
                      validator: RequiredValidator(errorText: " is required"),
                    ),
                  ),
                  Icons.person_outline),
              _buildDivider(),
              //email
              buildTutorInfo(
                  'Email', Text('ngudcse130377@fpt.edu.vn'), Icons.email),
              _buildDivider(),
              //gender
              //
              buildTutorInfo(
                'Gender',
                InkWell(
                  onTap: () {
                    //
                    showBottomUpSelector(context, [GENDER_MALE, GENDER_FEMALE],
                        genderController);
                  },
                  child: Container(
                    height: 40,
                    width: 60,
                    margin: EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                      right: 100,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 1,
                          offset: Offset(1, 1),
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          genderController.text,
                          style: TextStyle(
                            fontSize: titleFontSize,
                            color: textGreyColor,
                          ),
                        ),
                        Icon(
                          Icons.edit,
                          size: 20,
                          color: mainColor,
                        )
                      ],
                    ),
                  ),
                ),
                Icons.gesture,
              ),
              _buildDivider(),
              //birthday
              buildTutorInfo(
                  'Birthday',
                  InkWell(
                    onTap: () {
                      // classSelector(context, widget.selectedSubject);
                    },
                    child: Container(
                      height: 40,
                      width: 60,
                      margin: EdgeInsets.only(
                        top: 5,
                        bottom: 5,
                        right: 100,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 1,
                            offset: Offset(1, 1),
                          ),
                        ],
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            birthdayController.text,
                            style: TextStyle(
                              fontSize: titleFontSize,
                              color: textGreyColor,
                            ),
                          ),
                          Icon(
                            Icons.edit,
                            size: 20,
                            color: mainColor,
                          )
                        ],
                      ),
                    ),
                  ),
                  Icons.cake),
              _buildDivider(),
              //phone
              buildTutorInfo(
                  'Phone',
                  Container(
                    height: 43,
                    child: TextFormField(
                      controller: phoneController,
                      maxLength: 100,
                      textAlign: TextAlign.start,
                      onChanged: (context) {
                        //set name = value of this textFormfield on change
                        setState(() {
                          // course.name = courseNameController.text;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: '',
                        labelStyle: textStyle,
                        fillColor: Color(0xffF9F2F2),
                        filled: true,
                        focusedBorder: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: Colors.transparent, width: 0.0),
                        ),
                        hintText: '',
                        counterText: '',
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontSize: textFontSize,
                        ),
                      ),
                      validator: RequiredValidator(errorText: "is required"),
                    ),
                  ),
                  Icons.phone_android_outlined),
              _buildDivider(),
              //address
              buildTutorInfo(
                  'Address',
                  Container(
                    height: 120,
                    child: TextFormField(
                      controller: addressController,
                      expands: true,
                      maxLength: 500,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      textAlign: TextAlign.start,
                      onChanged: (context) {
                        //set name = value of this textFormfield on change
                        setState(() {
                          // course.name = courseNameController.text;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: '',
                        labelStyle: textStyle,
                        fillColor: Color(0xffF9F2F2),
                        filled: true,
                        focusedBorder: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: Colors.transparent, width: 0.0),
                        ),
                        hintText: 'Where are you living',
                        counterText: '',
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontSize: textFontSize,
                        ),
                      ),
                      validator: RequiredValidator(errorText: " is required"),
                    ),
                  ),
                  Icons.home_outlined),
              _buildDivider(),
              //Education level
              buildTutorInfo(
                  'Education level',
                  InkWell(
                    onTap: () {
                      // classSelector(context, widget.selectedSubject);
                      showBottomUpSelector(
                        context,
                        ['Colledge', 'University', 'Student', 'Teacher'],
                        educationLevelController,
                      );
                    },
                    child: Container(
                      height: 40,
                      width: 60,
                      margin: EdgeInsets.only(
                        top: 5,
                        bottom: 5,
                        right: 100,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 1,
                            offset: Offset(1, 1),
                          ),
                        ],
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            educationLevelController.text,
                            style: TextStyle(
                              fontSize: titleFontSize,
                              color: textGreyColor,
                            ),
                          ),
                          Icon(
                            Icons.edit,
                            size: 20,
                            color: mainColor,
                          )
                        ],
                      ),
                    ),
                  ),
                  Icons.cast_for_education_outlined),
              _buildDivider(),
              //University
              buildTutorInfo(
                  'University',
                  Container(
                    height: 43,
                    child: TextFormField(
                      controller: universityController,
                      maxLength: 100,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        labelText: '',
                        labelStyle: textStyle,
                        fillColor: Color(0xffF9F2F2),
                        filled: true,
                        focusedBorder: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: Colors.transparent, width: 0.0),
                        ),
                        hintText: 'Where did you graduate from',
                        counterText: '',
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontSize: textFontSize,
                        ),
                      ),
                      validator: RequiredValidator(errorText: "is required"),
                    ),
                  ),
                  Icons.school_outlined),
              _buildDivider(),
              //social id image selector
              Container(
                height: 250,
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Social Id Image',
                      style: TextStyle(
                        color: mainColor,
                        fontSize: titleFontSize,
                      ),
                    ),
                    //social id image
                    Container(
                      height: 200,
                      width: 260,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.0,
                          color: mainColor.withOpacity(0.5),
                        ),
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.blue[50].withOpacity(.4),
                      ),
                      child: InkWell(
                        onTap: () async {
                          //select Photo from camera
                          var img = await getImageFromCamera();
                          //post lên firebase
                          String imageUrl =
                              await uploadFileOnFirebaseStorage(img);
                          //
                          if (img != null) {
                            setState(() {
                              socialIdUrl = imageUrl;
                            });
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: Stack(
                            children: [
                              //
                              Center(
                                  child: Image.network(
                                socialIdUrl,
                                fit: BoxFit.cover,
                              )),
                              //                                  //
                              Align(
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.photo_camera,
                                  color: Colors.grey,
                                  size: 50,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              _buildDivider(),
              //certification images
              Container(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Certification Image(s)',
                        style: TextStyle(
                          color: mainColor,
                          fontSize: titleFontSize,
                        ),
                      ),
                    ),
                    BlocProvider(
                      create: (BuildContext context) =>
                          ImageCubit(ImageRepository()),
                      child: BlocBuilder<ImageCubit, ImageState>(
                        builder: (BuildContext context, state) {
                          //
                          final imageCubit = context.watch<ImageCubit>();
                          imageCubit.getImageByEmail(
                              widget.tutor.email, 'certification');
                          //
                          if (state is ImageErrorState) {
                            return ErrorScreen();
                            // return Text(state.errorMessage);
                          } else if (state is InitialImageState) {
                            return buildLoadingIndicator();
                          } else if (state is ImageNoDataState) {
                            // return NoDataScreen();
                            return Center(
                              child: Text('No certification'),
                            );
                          } else if (state is ImageListLoadedState) {
                            //
                            certificationImages = state.images
                                .replaceFirst(']', '')
                                .replaceFirst('[', '')
                                .split(', ');
                            certificationImages.insert(0, '');
                            //
                            return Container(
                              width: 260,
                              alignment: Alignment.centerLeft,
                              child: Wrap(
                                runAlignment: WrapAlignment.spaceBetween,
                                runSpacing: 10,
                                spacing: 10,
                                children: List.generate(
                                  certificationImages.length,
                                  (index) {
                                    //element is the first image; it is for take photo by camera
                                    if (index == 0) {
                                      return InkWell(
                                        onTap: () async {
                                          //select Photo from camera
                                          var img = await getImageFromCamera();
                                          String imageUrl =
                                              await uploadFileOnFirebaseStorage(
                                                  img);
                                          if (img != null) {
                                            setState(() {
                                              certificationImages.add(imageUrl);
                                            });
                                          }
                                        },
                                        child: Container(
                                          height: 125,
                                          width: 125,
                                          alignment: Alignment.center,
                                          child: Icon(
                                            Icons.add_a_photo,
                                            color: mainColor.withOpacity(0.7),
                                          ),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.blue[50].withOpacity(.4),
                                            border: Border.all(
                                              width: 1.0,
                                              color: mainColor.withOpacity(0.5),
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      //view photo in fullscreen
                                      return Container(
                                        height: 125,
                                        width: 125,
                                        child: PopupMenuButton(
                                          child: Image.network(
                                            certificationImages[index],
                                            fit: BoxFit.cover,
                                          ),
                                          itemBuilder: (context) {
                                            return <PopupMenuItem>[
                                              PopupMenuItem(
                                                child: TextButton(
                                                  child: Text('Detail'),
                                                  onPressed: () {
                                                    //
                                                    Navigator.pop(context);
                                                    //
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            FullScreenImage(
                                                          imageWidget:
                                                              Image.network(
                                                            certificationImages[
                                                                index],
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                              PopupMenuItem(
                                                child: TextButton(
                                                  child: Text(
                                                    'Remove',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      color: Colors.red
                                                          .withOpacity(.8),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    setState(() {
                                                      certificationImages
                                                          .removeAt(index);
                                                    });
                                                  },
                                                ),
                                              )
                                            ];
                                          },
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              //
              SizedBox(
                height: 80,
              )
            ],
          ),
        ),
      ),
    );
  }

// this will be shown when press
  Future<dynamic> showBottomUpSelector(BuildContext context, List<String> list,
      TextEditingController controller) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return ListView.separated(
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Visibility(
                  visible: list[index] == controller.text,
                  child: Icon(
                    Icons.check,
                    color: mainColor,
                    size: 15,
                  ),
                ),
                title: Text(
                  list[index],
                  style: TextStyle(
                    color: list[index] == controller.text
                        ? mainColor
                        : textGreyColor,
                    fontSize: titleFontSize,
                  ),
                ),
                onTap: () {
                  //pop
                  Navigator.pop(context);
                  //set value
                  setState(() {
                    controller.text = list[index];
                  });
                },
              );
            },
          );
        });
  }

// app bar
  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      actions: [
        buildDefaultCloseButtonWithFucntion(context, () {
          //
          Navigator.of(context).pop();
          //
          resetTextController();
        })
      ],
      // leading: buildDefaultCloseButton(context),
      title: Text(
        'Update Profile',
        style: headerStyle,
      ),
      centerTitle: true,
    );
  }

//divider
  Divider _buildDivider() {
    return Divider(
      indent: 30,
      endIndent: 20,
    );
  }

//tutor info element
  Container buildTutorInfo(String title, Widget content, IconData icon) {
    return Container(
      child: ListTile(
          leading: Container(
            // margin: EdgeInsets.symmetric(
            //   horizontal: 20,
            // ),
            width: 43,
            height: 43,
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: mainColor,
            ),
          ),
          title: Text(
            title,
            style: TextStyle(fontSize: 13, color: Colors.grey[500]),
          ),
          subtitle: content),
    );
  }
}