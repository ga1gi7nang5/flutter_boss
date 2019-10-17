import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class GalleryPage extends StatelessWidget {
  final List url;
  final String heroTag;

  GalleryPage({Key key, @required this.url, @required this.heroTag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },//点击
      child:Scaffold(
        backgroundColor: Colors.black,
        appBar: new AppBar(
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: SizedBox(
            child: Carousel(
              boxFit: BoxFit.contain,
              autoplay: false,
              animationCurve: Curves.fastOutSlowIn,
              animationDuration: Duration(milliseconds: 1000),
              dotSize: 6.0,
              dotSpacing: 14.0,
              dotIncreaseSize: 1.02,
              dotColor: Colors.grey,
              dotIncreasedColor: Colors.white,
              dotBgColor: Colors.transparent,
              dotPosition: DotPosition.bottomCenter,
              dotVerticalPadding: 50.0,
              showIndicator: true,
              indicatorBgPadding: 7.0,
              images: __createImgList(url),
            ),
          ),
        )
      ),
    );
  }
}

List __createImgList(List list) {
  List images = [];
  for (int i = 0; i < list.length; i++) {
    images.add(NetworkImage(list[i]));
  }
  return images;
}