import 'package:DockerApp/Server/Network.dart';
import 'package:DockerApp/Server/Volumes.dart';
import 'package:bmnav/bmnav.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ssh/ssh.dart';
import 'package:DockerApp/DockerLaunch.dart';
import 'package:DockerApp/FrontEnd.dart';

import 'package:passwordfield/passwordfield.dart';

class Commit extends StatefulWidget {
  @override
  _CommitState createState() => _CommitState();
}

class contextCapture {
  static var context;
}

Future navigateToSubPage(context) async {
  Navigator.pop(context);
}

DockerPush() async {
  //Commands.pushresult = await serverCredentials.client.connect();
  if (Commands.tag != null) {
    Commands.pushresult = await serverCredentials.client.execute(
        "docker tag ${Commands.newImage}:${Commands.tag} ${Commands.uname}/${Commands.newImage}:${Commands.tag};docker push ${Commands.uname}/${Commands.newImage}:${Commands.tag}");
  }
  if (Commands.pushresult != "") {
    AppToast("Imaged Pushed");
  } else {
    AppToast("Push failed");
  }
}

class _CommitState extends State<Commit> {
  @override
  Widget build(BuildContext context) {
    DockerCommit() async {
      print("Docker Press");

      if (Commands.validation == "passed") {
        Commands.result = await serverCredentials.client.connect();
        print("PULL RESULT = ${Commands.result}");
        if (Commands.image != null || Commands.newImage != null) {
          if (Commands.tag != null) {
            Commands.result = await serverCredentials.client.execute(
                "docker commit ${Commands.name} ${Commands.newImage}:${Commands.tag}");
          } else {
            Commands.result = await serverCredentials.client
                .execute("docker commit ${Commands.name} ${Commands.newImage}");
          }

          LinearProgressIndicator();

          print("PULL RESULT 01= ${Commands.result}");
          if (Commands.result == "") {
            AppToast("Failed to commit ${Commands.name}");
          } else {
            print("PULL RESULT = ${Commands.result}");
            AppToast("Commiting");
          }
          print("PULL RESULT 02= ${Commands.result}");
        } else {
          AppToast("No input provided");
        }
      } else {
        AppToast("Server not Connected");
      }
    }

    DockerLogin() async {
      if (Commands.validation == "passed") {
        Commands.pushresult = await serverCredentials.client.connect();

        if (Commands.uname != null && Commands.passwd != null) {
          Commands.pushresult = await serverCredentials.client.execute(
              "docker login -u ${Commands.uname} -p ${Commands.passwd}");

          print(Commands.pushresult);

          if (Commands.pushresult == "") {
            AppToast("Login failed");
          } else {
            AppToast("Logged in Successfully");
            setState(() {
              Commands.pushValidation = "passed";
            });
          }
        } else {
          AppToast("No input provided");
        }
      } else {
        AppToast("Server not connected");
      }
    }

    if (Commands.pushValidation == "passed") {
      Commands.pushWidget = Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        margin: EdgeInsets.only(top: 30, left: 25, right: 25, bottom: 70),
        child: Container(
          margin: EdgeInsets.all(0),
          height: 50,
          width: 180,
          child: FloatingActionButton(
            heroTag: "Push",
            isExtended: true,
            backgroundColor: Colors.white,
            child: Text(
              "Push To Repository",
              style: TextStyle(color: Colors.black),
            ),
            onPressed: DockerPush,
          ),
        ),
      );
    }

    var body = Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/c3.png"), fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      height: 200,
                      width: 200,
                      child: Image.asset('images/dock.png'),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 13, right: 13),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("images/card1.png"),
                                fit: BoxFit.cover),
                            border: Border.all(
                                color: Colors.grey.shade800, width: 1),
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
                                "Image Commit",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Container(
                                width: 350,
                                margin: EdgeInsets.only(top: 20, left: 20),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: 85,
                                      child: Text(
                                        "Container   : ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      height: 35,
                                      width: 180,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      margin:
                                          EdgeInsets.only(left: 20, right: 10),
                                      child: DropdownSearch(
                                        popupBackgroundColor: Colors.white,
                                        mode: Mode.MENU,
                                        showSelectedItem: true,
                                        items: Commands.getCont,
                                        onChanged: (value) {
                                          setState(() {
                                            //dir = value;
                                            Commands.name = value;

                                            //print("ABCD = ${items}");
                                          });
                                        },
                                        selectedItem: Commands.name,
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
                                      child: Text("Image  : ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    Container(
                                      height: 35,
                                      width: 200,
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
                                            hintText: "Image",
                                            hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 13),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)))),
                                        onChanged: (value) =>
                                            {Commands.newImage = value},
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
                                      child: Text("Tag  : ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    Container(
                                      height: 35,
                                      width: 200,
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
                                                color: Colors.grey,
                                                fontSize: 13),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)))),
                                        onChanged: (value) =>
                                            {Commands.tag = value},
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                margin: EdgeInsets.only(
                                    top: 25, left: 25, right: 25, bottom: 20),
                                child: Container(
                                  margin: EdgeInsets.all(0),
                                  height: 50,
                                  width: 180,
                                  child: FloatingActionButton(
                                    isExtended: true,
                                    backgroundColor: Colors.lightBlue,
                                    child: Text("Commit"),
                                    onPressed: DockerCommit,
                                  ),
                                ),
                              ),
                              Commands.pushWidget
                            ],
                          )
                        ]))
                  ],
                ),
              ),
            ],
          ),
        ));
    int counter = 1;
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
          title: Text("Commit Image"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => {navigateToSubPage(context)}),
          actions: <Widget>[
            FloatingActionButton(
                heroTag: counter,
                elevation: 0,
                child: Image.asset(
                  "images/dock2.png",
                  height: 35,
                  width: 35,
                ),
                onPressed: () {
                  setState(() {
                    counter++;
                  });
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.blue,
                          content: Stack(
                            overflow: Overflow.visible,
                            children: <Widget>[
                              Positioned(
                                right: -33.0,
                                top: -35.0,
                                child: InkResponse(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: CircleAvatar(
                                    child: IconButton(
                                        icon: Icon(
                                          Icons.close,
                                          color: Colors.lightBlue,
                                        ),
                                        onPressed: () {
                                          navigateToSubPage(context);
                                        }),
                                    backgroundColor: Colors.white,
                                  ),
                                ),
                              ),
                              Form(
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Container(
                                        child: Image(
                                            image:
                                                AssetImage("images/hub.png")),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Container(
                                            width: 350,
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  child: Text(
                                                    "Docker Login",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Container(
                                                    height: 35,
                                                    //width: 250,
                                                    decoration: BoxDecoration(
                                                        color: Colors.blue,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    margin: EdgeInsets.only(
                                                        left: 0,
                                                        right: 10,
                                                        top: 25),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Text(
                                                          "Username: ",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Container(
                                                          height: 35,
                                                          width: 120,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.blue,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 0,
                                                                  right: 0),
                                                          child: TextField(
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                            decoration: InputDecoration(
                                                                filled: true,
                                                                fillColor: Colors
                                                                    .white,
                                                                hintText:
                                                                    "DockerHub User",
                                                                hintStyle: TextStyle(
                                                                    color: Colors
                                                                        .grey),
                                                                border: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(10)))),
                                                            onChanged:
                                                                (value) => {
                                                              Commands.uname =
                                                                  value
                                                            },
                                                          ),
                                                        )
                                                      ],
                                                    )),
                                                Container(
                                                    height: 35,
                                                    //width: 250,
                                                    decoration: BoxDecoration(
                                                        color: Colors.blue,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    margin: EdgeInsets.only(
                                                        left: 0,
                                                        right: 10,
                                                        top: 25),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Text(
                                                          "Password: ",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Container(
                                                            height: 35,
                                                            width: 125,
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 0,
                                                                    right: 0),
                                                            child:
                                                                PasswordField(
                                                              suffixIcon: Icon(
                                                                  Icons.lock),
                                                              hasFloatingPlaceholder:
                                                                  true,
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    width: 1,
                                                                    color: Colors
                                                                        .grey
                                                                        .shade700),
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10)),
                                                              ),
                                                              focusedBorder: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              10)),
                                                                  borderSide:
                                                                      BorderSide(
                                                                          width:
                                                                              2,
                                                                          color:
                                                                              Colors.lightBlue)),
                                                              errorMessage:
                                                                  'Wrong Password',
                                                              backgroundColor:
                                                                  Colors.white,
                                                              backgroundBorderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              onSubmit:
                                                                  (value) => {
                                                                Commands.passwd =
                                                                    value
                                                              },
                                                            ))
                                                      ],
                                                    )),
                                                Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                  margin: EdgeInsets.all(25),
                                                  child: Container(
                                                    margin: EdgeInsets.all(0),
                                                    height: 50,
                                                    width: 180,
                                                    child: FloatingActionButton(
                                                      heroTag: "HUB Login",
                                                      isExtended: true,
                                                      backgroundColor:
                                                          Colors.white,
                                                      child: Text(
                                                        "Login",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      onPressed: DockerLogin,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),

                                            //color: Colors.lightBlue,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                })
          ],
        ),
        body: body,
      ),
    );
  }
}
