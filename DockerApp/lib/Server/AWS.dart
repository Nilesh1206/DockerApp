import 'package:DockerApp/FrontEnd.dart';
import 'package:DockerApp/Server/BareMetal.dart';
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
import 'package:DockerApp/DockerLaunch.dart';



class AWSEC2 extends StatefulWidget {
  @override
  _AWSEC2State createState() => _AWSEC2State();
}

class _AWSEC2State extends State<AWSEC2> {
  

  bool isloading4 = false;

  @override
  Widget build(BuildContext context) {
    var LoginBody = Center(
        child: Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.asset(
              "images/aws.jpg",
              height: 250,
              width: 250,
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
                      "AWS",
                      style: TextStyle(
                          color: Colors.yellow.shade800,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "EC2",
                      style: TextStyle(
                          color: Colors.blue.shade900,
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
                      "EC2 Credentials",
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
                  labelText: "Public IP",
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
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 17),
                  width: 310,
                  height: 60,
                  child: TextField(
                    enabled: false,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: Commands.filename == null
                          ? "Select AWS Key Pair"
                          : "${Commands.filename}",
                      labelStyle: TextStyle(color: Colors.grey.shade600),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade600)),
                      prefixIcon: Icon(
                        Icons.vpn_key,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.folder_open),
                  onPressed: () async {
                    
                  },
                )
              ],
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
                  labelText: "Passphrase",
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
                    setState(() {
                     ConnectedServer();
                      Commands.newWid = ConnectedServer();
                    });
                                       
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

               Navigator.pop(context);
              
            },
          ),

          backgroundColor: Colors.white,
        ),
        body: LoginBody,
      ),
    );
  }
}