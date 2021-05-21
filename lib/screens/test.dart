import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:tutor_search_system/screens/otp_test.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  void initState() {
    super.initState();
    _listenOtp();
  }

  void _listenOtp() async {
    await SmsAutoFill().listenForCode;
  }

  final _phoneController = TextEditingController();

  final _codeController = TextEditingController();

  Future<bool> loginUser(String phone, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          Navigator.of(context).pop();

          AuthResult result = await _auth.signInWithCredential(credential);

          FirebaseUser user = result.user;

          if (user != null) {
            // Navigator.push(context, MaterialPageRoute(
            //   builder: (context) => HomeScreen(user: user,)
            // ));
            print('thi sis sucessfeyll OTP code');
          } else {
            print("Error");
          }

          //This callback would gets called when verification is done auto maticlly
        },
        verificationFailed: (AuthException exception) {
          print(exception.message);
        },
        codeSent: (String verificationId, [int forceResendingToken]) async {
          final code = _codeController.text.trim();
          AuthCredential credential = PhoneAuthProvider.getCredential(
              verificationId: verificationId, smsCode: code);

          AuthResult result = await _auth.signInWithCredential(credential);

          FirebaseUser user = result.user;

          if (user != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OTPTest(
                  verificationId: verificationId,
                ),
              ),
            );
            print('thi sis sucessfeyll OTP code');
          } else {
            print("Error");
          }

          // showDialog(
          //     context: context,
          //     barrierDismissible: false,
          //     builder: (context) {
          //       return AlertDialog(
          //         title: GestureDetector(
          //           onTap: () {},
          //           child: Text("Give the code"),
          //         ),
          //         content: Column(
          //           mainAxisSize: MainAxisSize.min,
          //           children: <Widget>[
          //             // //
          //             // TextField(
          //             //   controller: _codeController,
          //             // ),
          //             //
          //             PinFieldAutoFill(
          //               onCodeChanged: (val) {
          //                 print('value of otp code: ' + val);
          //               },
          //             ),
          //           ],
          //         ),
          //         actions: <Widget>[
          //           FlatButton(
          //             child: Text("Confirm"),
          //             textColor: Colors.white,
          //             color: Colors.blue,
          //             onPressed: () async {
          //               final code = _codeController.text.trim();
          //               AuthCredential credential =
          //                   PhoneAuthProvider.getCredential(
          //                       verificationId: verificationId, smsCode: code);

          //               AuthResult result =
          //                   await _auth.signInWithCredential(credential);

          //               FirebaseUser user = result.user;

          //               if (user != null) {
          //                 // Navigator.push(context, MaterialPageRoute(
          //                 //     builder: (context) => HScreen(user: user,)
          //                 // ));
          //                 print('thi sis sucessfeyll OTP code');
          //               } else {
          //                 print("Error");
          //               }
          //             },
          //           )
          //         ],
          //       );
          // });
        },
        codeAutoRetrievalTimeout: null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(32),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Login",
                style: TextStyle(
                    color: Colors.lightBlue,
                    fontSize: 36,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[200])),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[300])),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: "Mobile Number"),
                controller: _phoneController,
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                width: double.infinity,
                child: FlatButton(
                  child: Text("LOGIN"),
                  textColor: Colors.white,
                  padding: EdgeInsets.all(16),
                  onPressed: () {
                    final phone = _phoneController.text.trim();

                    loginUser(phone, context);
                  },
                  color: Colors.blue,
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
