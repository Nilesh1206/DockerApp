import 'package:custom_splash/custom_splash.dart';
import 'package:flutter/material.dart';
import 'FrontEnd.dart';
//import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

void main() => runApp(DockerApp());

class DockerApp extends StatelessWidget {
  final appTitle = 'Docker';

  @override
  Widget build(BuildContext context) {
    //FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    //FlutterStatusbarcolor.setNavigationBarColor(Colors.white);
    //RepoHub();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: appTitle,
        //home: MyHomePage(title: appTitle),
        home: CustomSplash(
            duration: 1000,
            backGroundColor: Colors.white,
            customFunction: () {
              CircularProgressIndicator();
              //FlutterStatusbarcolor.setStatusBarColor(Colors.blue);
              //FlutterStatusbarcolor.setNavigationBarColor(Colors.blue);
            },
            imagePath: 'images/dock.png',
            home: MyApp()));
  }
}
