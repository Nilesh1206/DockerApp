import 'package:DockerApp/Server/Network.dart';
import 'package:DockerApp/Server/Volumes.dart';
import 'package:bmnav/bmnav.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ssh/ssh.dart';
import 'package:DockerApp/DockerLaunch.dart';
import 'package:DockerApp/FrontEnd.dart';

class ImagePull extends StatefulWidget {
  @override
  _ImagePullState createState() => _ImagePullState();
}

bool loading = false;

class _ImagePullState extends State<ImagePull> {
  @override
  Widget build(BuildContext context) {
    //FlutterStatusbarcolor.setStatusBarColor(Colors.blue);
    //FlutterStatusbarcolor.setNavigationBarColor(Colors.blue);
    DockerImagePull() async {
      setState(() {
        loading = true;
      });
      print("Docker Press");

      if (Commands.validation == "passed") {
        Commands.result = await serverCredentials.client.connect();
        print("PULL RESULT = ${Commands.result}");
        if (Commands.image != null || Commands.version != null) {
          Commands.result = await serverCredentials.client
              .execute("docker pull ${Commands.image}:${Commands.version}");

          LinearProgressIndicator();

          print("PULL RESULT 01= ${Commands.result}");
          if (Commands.result == "") {
            AppToast("Failed to Pull ${Commands.image}");
          } else {
            print("PULL RESULT = ${Commands.result}");
            AppToast("Pulling Image");
          }
          print("PULL RESULT 02= ${Commands.result}");
        } else {
          AppToast("No input provided");
        }
      } else {
        AppToast("Server not Connected");
      }
      setState(() {
        loading = false;
      });
    }

    //FlutterStatusbarcolor.setStatusBarColor(Colors.blue);
    //FlutterStatusbarcolor.setNavigationBarColor(Colors.blue);
    var body = Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/a2.png"), fit: BoxFit.cover)),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(25),
                    alignment: Alignment.center,
                    height: 140,
                    width: 140,
                    child: Image.asset('images/dock2.png'),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 13, right: 13),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("images/card1.png"),
                              fit: BoxFit.cover),
                          border:
                              Border.all(color: Colors.grey.shade800, width: 1),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.elliptical(15, 15),
                            bottomLeft: Radius.elliptical(15, 15),
                            topRight: Radius.elliptical(15, 15),
                            bottomRight: Radius.elliptical(15, 15),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 15.0,
                            ),
                          ]),
                      child: Column(children: <Widget>[
                        Container(
                          height: 40,
                          width: 350,
                          decoration: BoxDecoration(
                              color: Colors.lightBlue,
                              borderRadius: BorderRadius.circular(20)),
                          margin: EdgeInsets.only(top: 15),
                          child: Center(
                            child: Text(
                              "Docker Images",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                              height: 40,
                              width: 350,
                              margin: EdgeInsets.only(top: 20, left: 20),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 70,
                                    child: Text(
                                      "Image   : ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    height: 35,
                                    width: 210,
                                    decoration: BoxDecoration(
                                        color: Colors.lightBlue,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin:
                                        EdgeInsets.only(left: 20, right: 10),
                                    child: TextField(
                                      style: TextStyle(color: Colors.black),
                                      decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          hintText: "Image Name",
                                          hintStyle: TextStyle(
                                              color: Colors.grey, fontSize: 13),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)))),
                                      onChanged: (value) =>
                                          {Commands.image = value},
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 40,
                              width: 350,
                              margin: EdgeInsets.only(top: 20, left: 20),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 70,
                                    child: Text(
                                      "Version  : ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    height: 35,
                                    width: 210,
                                    decoration: BoxDecoration(
                                        color: Colors.lightBlue,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin:
                                        EdgeInsets.only(left: 20, right: 10),
                                    child: TextField(
                                      style: TextStyle(color: Colors.black),
                                      decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          hintText: "Tag",
                                          hintStyle: TextStyle(
                                              color: Colors.grey, fontSize: 13),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)))),
                                      onChanged: (value) =>
                                          {Commands.version = value},
                                    ),
                                  ),
                                ],
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
                                  isExtended: true,
                                  backgroundColor: Colors.lightBlue,
                                  child: loading
                                      ? CircularProgressIndicator(
                                          backgroundColor: Colors.white,
                                        )
                                      : Text("Pull"),
                                  onPressed: DockerImagePull,
                                ),
                              ),
                            ),
                          ],
                        )
                      ]))
                ],
              ),
            ),
          ],
        ),
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: BottomNav(
          iconStyle: IconStyle(onSelectSize: 30),
          index: Commands.currentindex,
          labelStyle: LabelStyle(showOnSelect: true),
          onTap: (index) {
            if (index == 0) {
              setState(() {
                Commands.currentindex = 0;
              });
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Network();
              }));
            }
            if (index == 1) {
              setState(() {
                Commands.currentindex = 1;
              });
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MyApp();
              }));
            }
            if (index == 2) {
              setState(() {
                Commands.currentindex = 2;
              });
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Volume();
              }));
            }
          },
          items: [
            BottomNavItem(Icons.cloud, label: 'Networks'),
            BottomNavItem(Icons.home, label: 'Home'),
            BottomNavItem(Icons.storage, label: 'Volumes')
          ],
        ),
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Pull Image"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => {Navigator.pop(context)}),
        ),
        body: body,
      ),
    );
  }
}
