import 'package:DockerApp/FrontEnd.dart';
import 'package:DockerApp/ui/Commit.dart';
import 'package:DockerApp/ui/DeletePage.dart';
import 'package:DockerApp/ui/DockerBuild.dart';
import 'package:DockerApp/ui/ExecPage.dart';
import 'package:DockerApp/ui/PullPage.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:bmnav/bmnav.dart';
import 'package:custom_splash/custom_splash.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:file/file.dart';
//import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_icons/flutter_icons.dart';
//import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:passwordfield/passwordfield.dart';
import 'package:DockerApp/DockerLaunch.dart';
import 'package:DockerApp/ui/DockerCopy.dart';
import 'package:DockerApp/ui/LaunchPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:DockerApp/ui/DockerImages.dart';
import 'package:DockerApp/ui/DockerFileWrite.dart';

class BareMetal extends StatefulWidget {
  @override
  _BareMetalState createState() => _BareMetalState();
}
String _backgroundImage;
  String _setImage() {
    String _mTitle = "${ServerInfo.name.substring(7,ServerInfo.name.length-3)}";

    if (_mTitle == "Red Hat Enterprise Linux") {
      _backgroundImage = "images/redhat.jpg";
    } else if (_mTitle == "Ubuntu") {
      _backgroundImage = "assets/ubuntu.jpg";
    }
    else if (_mTitle == "Amazon Linux") {
      _backgroundImage = "images/aws.jpg";
    }
    else if(_mTitle ==""){
      _backgroundImage = 'images/dock.png';
    }
    print("_mTitle: $_mTitle");
    print("_backgroundImage: $_backgroundImage");
    return _backgroundImage; // here it returns your _backgroundImage value
  }
// ignore: non_constant_identifier_names
ConnectedServer() {
  return Container(
    width: 370,
    padding: EdgeInsets.only(left: 5, top: 10),
    margin: EdgeInsets.fromLTRB(14, 20, 14, 20),
    decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.only(
          topLeft: Radius.elliptical(20, 20),
          bottomLeft: Radius.elliptical(20, 20),
          topRight: Radius.elliptical(20, 20),
          bottomRight: Radius.elliptical(20, 20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10.0,
          ),
        ]),
    child: Column(
      children: [
        Card(
          elevation: 5,
          color: Colors.blue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Container(
            height: 30,
            width: 250,
            child: Center(
                child: Text(
              'Connected Server',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            )),
          ),
        ),
        Row(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Text(
                                        " Name: ",
                                        style: TextStyle(
                                            color: Colors.lightBlue,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: 10, bottom: 0, left: 10),
                                      child: Text(
                                        ServerInfo.name.substring(7,ServerInfo.name.length-3),
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Text(
                                        " Version: ",
                                        style: TextStyle(
                                            color: Colors.lightBlue,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: 10, bottom: 0, left: 10),
                                      child: Text(
                                        ServerInfo.ver1.substring(10, ServerInfo.ver1.length-3 ),
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Text(
                                        " ID: ",
                                        style: TextStyle(
                                            color: Colors.lightBlue,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: 10,
                                          bottom: 0,
                                          left: 40,
                                          right: 0),
                                      child: Text(
                                        ServerInfo.id0.substring(5,ServerInfo.id0.length-3 ),
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    )
                                  ],
                                ),
                                
                                Row(
                                                        children: <Widget>[
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 10),
                                                            child: Text(
                                                              " Id_Like: ",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .lightBlue,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 10,
                                                                    bottom: 0,
                                                                    left: 10),
                                                            child: Text(
                                                              ServerInfo.id1.substring(10,ServerInfo.id1.length-3),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                Row(                    
                                                        children: <Widget>[
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 10),
                                                            child: Text(
                                                              " Docker Version: ",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .lightBlue,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,fontSize: 20),
                                                            ),
                                                          ),
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 10,
                                                                    bottom: 0,
                                                                    left: 10),
                                                            child:  Text(
                Commands.docker != ""
                    ? Commands.stat.substring(16, Commands.stat.length - 22)
                    : "Docker not installed",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                                                            )                                   
                                                          
                                                          )
                                                        ],
                                                      ),
        Container(
          height: 120,
          width: 150,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: new AssetImage(_setImage()),
            ),
          ),
        ),
      ],
    ),
  );
}

bool isloading4 = false;
class contextCapture {
  static var context;
}

Future navigateToSubPage(context) async {
  Navigator.pop(context);
}

class _BareMetalState extends State<BareMetal> {
  
  @override
  Widget build(BuildContext context) {
    var newWid = Container();
    var LoginBody = Center(
        child: Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.asset(
              "images/123.png",
              height: 200,
              width: 200,
              //color: Colors.blue.shade700,
            ),
            Container(
              margin: EdgeInsets.only(top: 0, bottom: 15),
              height: 80,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Docker",
                      style: TextStyle(
                          color: Colors.blue.shade700,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Host ",
                      style: TextStyle(
                          color: Colors.grey.shade800,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 5,
              child: Container(
                  height: 40,
                  width: 350,
                  decoration: BoxDecoration(color: Colors.blue.shade700),
                  child: Center(
                    child: Text(
                      "Server Credentials",
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              height: 60,
              width: 380,
              child: TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Host IP",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.laptop_chromebook),
                ),
                onChanged: (value) =>
                    {serverCredentials.ip = value, print(serverCredentials.ip)},
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 60,
              width: 380,
              child: TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Username",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                onChanged: (value) => {
                  serverCredentials.username = value,
                  print(serverCredentials.username)
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 380,
              height: 60,
              child: TextField(
                obscureText: true,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                onChanged: (value) => {
                  serverCredentials.password = value,
                  print(serverCredentials.password)
                },
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              margin: EdgeInsets.all(25),
              child: Container(
                margin: EdgeInsets.all(0),
                height: 50,
                width: 180,
                child: FloatingActionButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  isExtended: true,
                  backgroundColor: Colors.blue.shade700,
                  child: isloading4
                      ? Transform.scale(
                          scale: 0.6,
                          child: CircularProgressIndicator(
                              backgroundColor: Colors.white))
                      : Text("Connect"),
                  onPressed: () async {
                    setState(() {
                      isloading4 = true;
                    });
                    await Connect();
                    await ServerBody();
                    await Status();
                    setState(()  {
                     newWid= ConnectedServer();
                      Commands.newWid =  ConnectedServer();
                    });
                    await ConnectedServer();
                   setState(() {
                      isloading4 = false;
                    });

                     
                    
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          //title: Text("Server"),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.blue.shade700,
            ),
            onPressed: () async {
              setState(() {
                Commands.isaws = false;
              });

              await navigateToSubPage(context);
              
            },
          ),

          backgroundColor: Colors.white,
        ),
        body: LoginBody,
      ),
    );
  }
}