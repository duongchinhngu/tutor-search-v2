import 'package:flutter/material.dart';

class FullScreenImage extends StatelessWidget {
  final Widget imageWidget;

  const FullScreenImage({Key key, @required this.imageWidget})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(.2),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Container(
        child: Hero(tag: 'imageHero', child: imageWidget),
      ),
    );
  }
}
