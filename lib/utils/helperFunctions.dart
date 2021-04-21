import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> pushDirect({@required BuildContext context,@required Widget redirect}) async {
  try{
    Navigator.push(context,CupertinoPageRoute(builder: (context) => redirect)).catchError((err)=>
      throw FlutterError("Cannot push new Screen... $err")
    );
  }catch(err){
    print(err);
  }
}