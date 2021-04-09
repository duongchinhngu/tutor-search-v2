import 'package:flutter/material.dart';

class FullScreenImage extends StatelessWidget {
  final Widget imageWidget;

  const FullScreenImage({Key key, @required this.imageWidget})
      : super(key: key);
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
      body: Center(child: imageWidget),
    );
  }
}
