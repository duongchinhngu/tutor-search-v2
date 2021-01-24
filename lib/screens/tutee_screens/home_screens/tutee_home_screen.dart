import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tutor_search_system/commons/colors.dart';

class TuteeHomeScreen extends StatefulWidget {
  @override
  _TuteeHomeScreenState createState() => _TuteeHomeScreenState();
}

class _TuteeHomeScreenState extends State<TuteeHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("EasyEdu"),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 2 / 4,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  )),
              width: 60,
              height: 300,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: Container(
                      width: 200,
                      height: 150,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            width: 200,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(13, 15, 13, 0),
                              child: Text(
                                "IT - Java Web Base",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: textWhiteColor,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Center(
                              child: Container(
                                width: 95,
                                height: 95,
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    shape: BoxShape.circle,
                                    color: Colors.white),
                                child: FlutterLogo(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/starsmall.png'),
                      Image.asset('assets/images/starsmall.png'),
                      Image.asset('assets/images/starsmall.png'),
                      Image.asset('assets/images/starsmall.png'),
                      Image.asset('assets/images/starsmall.png'),
                    ],
                  ),
                  Container(
                    child: Text(
                      "Nguyen Trung Huy",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(color: Colors.grey, width: 0.5)),
                      ),
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 10),
                                child:
                                    Image.asset('assets/images/studyicon.png'),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child:
                                    Image.asset('assets/images/clockicon.png'),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Image.asset(
                                    'assets/images/distanceicon.png'),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child:
                                    Image.asset('assets/images/pricetag.png'),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 10),
                                child: Text(
                                  'Study Online',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Text(
                                  '18:00 - 20:00',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Text(
                                  '200m',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Text(
                                  '2.100.000',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  )),
              width: 60,
              height: 300,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: Container(
                      width: 200,
                      height: 150,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            width: 200,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(13, 15, 13, 0),
                              child: Text(
                                "IT - Java Web Base",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: textWhiteColor,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Center(
                              child: Container(
                                width: 95,
                                height: 95,
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    shape: BoxShape.circle,
                                    color: Colors.white),
                                child: FlutterLogo(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/starsmall.png'),
                      Image.asset('assets/images/starsmall.png'),
                      Image.asset('assets/images/starsmall.png'),
                      Image.asset('assets/images/starsmall.png'),
                      Image.asset('assets/images/starsmall.png'),
                    ],
                  ),
                  Container(
                    child: Text(
                      "Nguyen Trung Huy",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(color: Colors.grey, width: 0.5)),
                      ),
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 10),
                                child:
                                    Image.asset('assets/images/studyicon.png'),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child:
                                    Image.asset('assets/images/clockicon.png'),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Image.asset(
                                    'assets/images/distanceicon.png'),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child:
                                    Image.asset('assets/images/pricetag.png'),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 10),
                                child: Text(
                                  'Study Online',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Text(
                                  '18:00 - 20:00',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Text(
                                  '200m',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Text(
                                  '2.100.000',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  )),
              width: 60,
              height: 300,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: Container(
                      width: 200,
                      height: 150,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            width: 200,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(13, 15, 13, 0),
                              child: Text(
                                "IT - Java Web Base",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: textWhiteColor,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Center(
                              child: Container(
                                width: 95,
                                height: 95,
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    shape: BoxShape.circle,
                                    color: Colors.white),
                                child: FlutterLogo(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/starsmall.png'),
                      Image.asset('assets/images/starsmall.png'),
                      Image.asset('assets/images/starsmall.png'),
                      Image.asset('assets/images/starsmall.png'),
                      Image.asset('assets/images/starsmall.png'),
                    ],
                  ),
                  Container(
                    child: Text(
                      "Nguyen Trung Huy",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(color: Colors.grey, width: 0.5)),
                      ),
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 10),
                                child:
                                    Image.asset('assets/images/studyicon.png'),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child:
                                    Image.asset('assets/images/clockicon.png'),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Image.asset(
                                    'assets/images/distanceicon.png'),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child:
                                    Image.asset('assets/images/pricetag.png'),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 10),
                                child: Text(
                                  'Study Online',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Text(
                                  '18:00 - 20:00',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Text(
                                  '200m',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Text(
                                  '2.100.000',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  )),
              width: 60,
              height: 300,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: Container(
                      width: 200,
                      height: 150,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            width: 200,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(13, 15, 13, 0),
                              child: Text(
                                "IT - Java Web Base",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: textWhiteColor,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Center(
                              child: Container(
                                width: 95,
                                height: 95,
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    shape: BoxShape.circle,
                                    color: Colors.white),
                                child: FlutterLogo(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/starsmall.png'),
                      Image.asset('assets/images/starsmall.png'),
                      Image.asset('assets/images/starsmall.png'),
                      Image.asset('assets/images/starsmall.png'),
                      Image.asset('assets/images/starsmall.png'),
                    ],
                  ),
                  Container(
                    child: Text(
                      "Nguyen Trung Huy",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(color: Colors.grey, width: 0.5)),
                      ),
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 10),
                                child:
                                    Image.asset('assets/images/studyicon.png'),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child:
                                    Image.asset('assets/images/clockicon.png'),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Image.asset(
                                    'assets/images/distanceicon.png'),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child:
                                    Image.asset('assets/images/pricetag.png'),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 10),
                                child: Text(
                                  'Study Online',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Text(
                                  '18:00 - 20:00',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Text(
                                  '200m',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Text(
                                  '2.100.000',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  )),
              width: 60,
              height: 300,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: Container(
                      width: 200,
                      height: 150,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            width: 200,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(13, 15, 13, 0),
                              child: Text(
                                "IT - Java Web Base",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: textWhiteColor,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Center(
                              child: Container(
                                width: 95,
                                height: 95,
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    shape: BoxShape.circle,
                                    color: Colors.white),
                                child: FlutterLogo(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/starsmall.png'),
                      Image.asset('assets/images/starsmall.png'),
                      Image.asset('assets/images/starsmall.png'),
                      Image.asset('assets/images/starsmall.png'),
                      Image.asset('assets/images/starsmall.png'),
                    ],
                  ),
                  Container(
                    child: Text(
                      "Nguyen Trung Huy",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(color: Colors.grey, width: 0.5)),
                      ),
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 10),
                                child:
                                    Image.asset('assets/images/studyicon.png'),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child:
                                    Image.asset('assets/images/clockicon.png'),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Image.asset(
                                    'assets/images/distanceicon.png'),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child:
                                    Image.asset('assets/images/pricetag.png'),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 10),
                                child: Text(
                                  'Study Online',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Text(
                                  '18:00 - 20:00',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Text(
                                  '200m',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Text(
                                  '2.100.000',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  )),
              width: 60,
              height: 300,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: Container(
                      width: 200,
                      height: 150,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            width: 200,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(13, 15, 13, 0),
                              child: Text(
                                "IT - Java Web Base",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: textWhiteColor,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Center(
                              child: Container(
                                width: 95,
                                height: 95,
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    shape: BoxShape.circle,
                                    color: Colors.white),
                                child: FlutterLogo(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/starsmall.png'),
                      Image.asset('assets/images/starsmall.png'),
                      Image.asset('assets/images/starsmall.png'),
                      Image.asset('assets/images/starsmall.png'),
                      Image.asset('assets/images/starsmall.png'),
                    ],
                  ),
                  Container(
                    child: Text(
                      "Nguyen Trung Huy",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(color: Colors.grey, width: 0.5)),
                      ),
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 10),
                                child:
                                    Image.asset('assets/images/studyicon.png'),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child:
                                    Image.asset('assets/images/clockicon.png'),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Image.asset(
                                    'assets/images/distanceicon.png'),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child:
                                    Image.asset('assets/images/pricetag.png'),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 10),
                                child: Text(
                                  'Study Online',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Text(
                                  '18:00 - 20:00',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Text(
                                  '200m',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Text(
                                  '2.100.000',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  )),
              width: 60,
              height: 300,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: Container(
                      width: 200,
                      height: 150,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            width: 200,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(13, 15, 13, 0),
                              child: Text(
                                "IT - Java Web Base",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: textWhiteColor,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Center(
                              child: Container(
                                width: 95,
                                height: 95,
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    shape: BoxShape.circle,
                                    color: Colors.white),
                                child: FlutterLogo(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/starsmall.png'),
                      Image.asset('assets/images/starsmall.png'),
                      Image.asset('assets/images/starsmall.png'),
                      Image.asset('assets/images/starsmall.png'),
                      Image.asset('assets/images/starsmall.png'),
                    ],
                  ),
                  Container(
                    child: Text(
                      "Nguyen Trung Huy",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(color: Colors.grey, width: 0.5)),
                      ),
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 10),
                                child:
                                    Image.asset('assets/images/studyicon.png'),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child:
                                    Image.asset('assets/images/clockicon.png'),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Image.asset(
                                    'assets/images/distanceicon.png'),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child:
                                    Image.asset('assets/images/pricetag.png'),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 10),
                                child: Text(
                                  'Study Online',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Text(
                                  '18:00 - 20:00',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Text(
                                  '200m',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Text(
                                  '2.100.000',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  )),
              width: 60,
              height: 300,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: Container(
                      width: 200,
                      height: 150,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            width: 200,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(13, 15, 13, 0),
                              child: Text(
                                "IT - Java Web Base",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: textWhiteColor,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Center(
                              child: Container(
                                width: 95,
                                height: 95,
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    shape: BoxShape.circle,
                                    color: Colors.white),
                                child: FlutterLogo(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/starsmall.png'),
                      Image.asset('assets/images/starsmall.png'),
                      Image.asset('assets/images/starsmall.png'),
                      Image.asset('assets/images/starsmall.png'),
                      Image.asset('assets/images/starsmall.png'),
                    ],
                  ),
                  Container(
                    child: Text(
                      "Nguyen Trung Huy",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(color: Colors.grey, width: 0.5)),
                      ),
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 10),
                                child:
                                    Image.asset('assets/images/studyicon.png'),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child:
                                    Image.asset('assets/images/clockicon.png'),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Image.asset(
                                    'assets/images/distanceicon.png'),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child:
                                    Image.asset('assets/images/pricetag.png'),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 10),
                                child: Text(
                                  'Study Online',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Text(
                                  '18:00 - 20:00',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Text(
                                  '200m',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Text(
                                  '2.100.000',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  )),
              width: 60,
              height: 300,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: Container(
                      width: 200,
                      height: 150,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            width: 200,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(13, 15, 13, 0),
                              child: Text(
                                "IT - Java Web Base",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: textWhiteColor,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Center(
                              child: Container(
                                width: 95,
                                height: 95,
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    shape: BoxShape.circle,
                                    color: Colors.white),
                                child: FlutterLogo(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/starsmall.png'),
                      Image.asset('assets/images/starsmall.png'),
                      Image.asset('assets/images/starsmall.png'),
                      Image.asset('assets/images/starsmall.png'),
                      Image.asset('assets/images/starsmall.png'),
                    ],
                  ),
                  Container(
                    child: Text(
                      "Nguyen Trung Huy",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(color: Colors.grey, width: 0.5)),
                      ),
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 10),
                                child:
                                    Image.asset('assets/images/studyicon.png'),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child:
                                    Image.asset('assets/images/clockicon.png'),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Image.asset(
                                    'assets/images/distanceicon.png'),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child:
                                    Image.asset('assets/images/pricetag.png'),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 10),
                                child: Text(
                                  'Study Online',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Text(
                                  '18:00 - 20:00',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Text(
                                  '200m',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Text(
                                  '2.100.000',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  )),
              width: 60,
              height: 300,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: Container(
                      width: 200,
                      height: 150,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            width: 200,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(13, 15, 13, 0),
                              child: Text(
                                "IT - Java Web Base",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: textWhiteColor,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Center(
                              child: Container(
                                width: 95,
                                height: 95,
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    shape: BoxShape.circle,
                                    color: Colors.white),
                                child: FlutterLogo(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/starsmall.png'),
                      Image.asset('assets/images/starsmall.png'),
                      Image.asset('assets/images/starsmall.png'),
                      Image.asset('assets/images/starsmall.png'),
                      Image.asset('assets/images/starsmall.png'),
                    ],
                  ),
                  Container(
                    child: Text(
                      "Nguyen Trung Huy",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(color: Colors.grey, width: 0.5)),
                      ),
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 10),
                                child:
                                    Image.asset('assets/images/studyicon.png'),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child:
                                    Image.asset('assets/images/clockicon.png'),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Image.asset(
                                    'assets/images/distanceicon.png'),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child:
                                    Image.asset('assets/images/pricetag.png'),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 10),
                                child: Text(
                                  'Study Online',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Text(
                                  '18:00 - 20:00',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Text(
                                  '200m',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Text(
                                  '2.100.000',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData get newMethod => CupertinoIcons.add_circled_solid;
}
