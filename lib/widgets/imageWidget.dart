import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final Widget child;
  final String imageAsset;
  final double height;
  final double width;
  final double scaleFactor;

  const ImageWidget({Key key, @required this.child,this.imageAsset,this.height,this.width,this.scaleFactor = 1.0}) : super(key: key);
  @override
  Widget build(BuildContext context){
    return Container(
      height: this.height,
      width: this.width,
      child: this.child,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(this.imageAsset),fit: BoxFit.fill,scale: this.scaleFactor
        )
      )
    );
  }
}