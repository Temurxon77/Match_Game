import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kids_game/main.dart';
import 'package:kids_game/utils/constants.dart';
import 'package:kids_game/utils/helperFunctions.dart';
import 'package:kids_game/widgets/imageWidget.dart';

class MainPage extends StatelessWidget {
  MainPage() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
        Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage(menuImg[1]),fit: BoxFit.cover)),
        ),
      Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
            ColorFiltered(
              colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.6), BlendMode.modulate),
              child: CircleAvatar(backgroundImage: AssetImage(menuImg[10]),radius: 120,backgroundColor: Colors.white.withOpacity(0.5))),
            //ImageWidget(child: SizedBox(),height: double.infinity,width: double.infinity,imageAsset: menuImg[1]),
            // Container(
            //   decoration: BoxDecoration(
            //   //color: const Color(0xff7c94b6),
            //   image: new DecorationImage(
            //     image: AssetImage(menuImg[10]),
            //     fit: BoxFit.cover,
            //     colorFilter:  ColorFilter.mode(Color.fromARGB(200, 159, 191, 230).withOpacity(0.6),BlendMode.srcATop)))),
            SizedBox(height: 35),
            ImageWidget(child: SizedBox(),imageAsset: menuImg[2],height: 180,width: MediaQuery.of(context).size.width*0.8),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () => pushDirect(context: context, redirect: HomePage()),
              child: SizedBox(
                height: 125,
                width: 125,
                child: Image.asset(menuImg[11],height: 125,width: 125))
            )
          ]
        )
      ]
      )
    );
  }
}