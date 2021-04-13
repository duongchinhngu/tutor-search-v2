import 'package:flutter/material.dart';
import 'package:tutor_search_system/commons/notifications/notification_methods.dart';

class FullScreenImage extends StatefulWidget {
  final Widget imageWidget;

  const FullScreenImage({Key key, @required this.imageWidget})
      : super(key: key);

  @override
  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  @override
  void initState() {
    registerOnFirebase();
    getMessage(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black.withOpacity(.2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Container(
          height: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black.withOpacity(.5)
          ),
          child: Center(
            child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
        ),
      ),
      body: Center(child: widget.imageWidget),
    );
  }
}
