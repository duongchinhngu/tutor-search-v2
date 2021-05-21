import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OTPTest extends StatefulWidget {
  final String verificationId;

  const OTPTest({Key key, this.verificationId}) : super(key: key);
  @override
  _OTPTestState createState() => _OTPTestState();
}

class _OTPTestState extends State<OTPTest> {
  @override
  void initState() {
    super.initState();
    _listenOtp();
  }

  void _listenOtp() async {
    await SmsAutoFill().listenForCode;
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  final _phoneController = TextEditingController();

  final _codeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AlertDialog(
      title: Text("Give the code"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // //
          // TextField(
          //   controller: _codeController,
          // ),
          //
          PinFieldAutoFill(
            onCodeChanged: (val) {
              print('value of otp code: ' + val);
            },
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: Text("Confirm"),
          textColor: Colors.white,
          color: Colors.blue,
          onPressed: () async {
            final code = _codeController.text.trim();
            AuthCredential credential = PhoneAuthProvider.getCredential(
                verificationId: widget.verificationId, smsCode: code);

            AuthResult result = await _auth.signInWithCredential(credential);

            FirebaseUser user = result.user;

            if (user != null) {
              // Navigator.push(context, MaterialPageRoute(
              //     builder: (context) => HScreen(user: user,)
              // ));
              print('thi sis sucessfeyll OTP code');
            } else {
              print("Error");
            }
          },
        )
      ],
    ));
  }
}
