import 'package:DockerApp/Server/Network.dart';
import 'package:DockerApp/Server/Volumes.dart';
import 'package:bmnav/bmnav.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:DockerApp/DockerLaunch.dart';
//import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

import 'package:passwordfield/passwordfield.dart';
import '../FrontEnd.dart';
import 'DockerCopy.dart';
import 'Commit.dart';

class DockerFile extends StatefulWidget {
  @override
  _DockerFileState createState() => _DockerFileState();
}

class _DockerFileState extends State<DockerFile> {
  bool isloading1 = false;
  String dir = " ";
  int l = 1, y = 0;

  List<String> container;
  List<String> container2 = ["/"];

  DockerScript() async {
    setState(() {
      isloading1 = true;
    });
    if (Commands.validation == "passed") {
      Commands.result = await serverCredentials.client.connect();

      if (Commands.result == "session_connected") {
        if (container2 != null &&
            Commands.tag != null &&
            Commands.image != null) {
          container2.removeLast();
          print("THE FINAL = ${container2.join()}");

          print(
              "docker build -t ${Commands.image}:${Commands.tag} ${container2.join()}");

          Commands.result = await serverCredentials.client.execute(
              "docker build -t ${Commands.image}:${Commands.tag} ${container2.join()}");
          AppToast("Building ....");
        }

        if (Commands.result == "") {
          AppToast("Build Failed");
        } else {
          AppToast("Build Successful");
        }
      } else {
        AppToast("No input Provided");
      }
    } else {
      print("RESULT = ${Commands.result}");
      AppToast("Server not connected");
    }

    print("DONE");
    setState(() {
      isloading1 = false;
    });
  }

  var result2;

  Fun() async {
    if (container2.length == 0) {
      container2.add("/");
    }
    if (container2.last == "Dockerfile") {
      container2.removeLast();
    }
    result2 = await serverCredentials.client.execute("ls ${container2.join()}");
    setState(() {
      Commands.dir = result2.split('\n').toList();
    });
  }

  void Path() async {
    setState(() {
      isloading1 = true;
    });

    print('path function called');

    if (Commands.validation == "passed") {
      if (dir == " ") {
        l--;
      }

      if (l > 2) {
        //container = dir.split("");
        if (dir != container2.join()) {
          print(dir.length);
          print(container2.join().length);
          print("SOLVED!!!!");
        }
        container = dir.split("");
        container.removeLast();

        String p = "/";
        if (y == 0) {
          y = 1;
        } else {
          if (container2.length > 1) {
            container2.add(p);
          }
        }
        if (container2.last == "Dockerfile") {
          container2.removeLast();
        }

        print("RIGHT = $container2");
        container2.add(container.join());

        result2 =
            await serverCredentials.client.execute("ls ${container2.join()}");
        Commands.dir = await result2.split('\n').toList();
        print("tttt");
      } else if (l == 0) {
        print('ffff');
        result2 = await serverCredentials.client.execute("ls /$dir");
        Commands.dir = await result2.split('\n').toList();
        l = 3;
      }

      print("DIR = ");
      for (var i in Commands.dir) {
        print(i);
      }
    } else {
      AppToast("Server not connected");
    }
    //print(Commands.demo1);
    setState(() {
      isloading1 = false;
    });
  }

  @override
  void initState() {
    super.initState();
    Path();
  }

  @override
  Widget build(BuildContext context) {
    //FlutterStatusbarcolor.setStatusBarColor(Colors.blue);
    //FlutterStatusbarcolor.setNavigationBarColor(Colors.blue);
    if (Commands.pushValidation == "passed") {
      Commands.pushWidget = Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        margin: EdgeInsets.only(top: 5, left: 25, right: 25, bottom: 70),
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

    var body = Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/b4.png"), fit: BoxFit.cover)),
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
                    margin: EdgeInsets.only(left: 13, right: 13, bottom: 250),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("images/b3.png"),
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
                            "DockerFile Build",
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
                                  width: 85,
                                  child: Text(
                                    "Dockerfile Location   : ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    IconButton(
                                        icon: Icon(Icons.arrow_back),
                                        onPressed: () {
                                          setState(() {
                                            container2.removeLast();
                                            container2.removeLast();

                                            Fun();
                                          });
                                        }),
                                    Container(
                                      height: 35,
                                      width: 160,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      margin:
                                          EdgeInsets.only(left: 0, right: 10),
                                      child: DropdownSearch(
                                        popupBackgroundColor: Colors.white,
                                        mode: Mode.MENU,
                                        showSelectedItem: true,
                                        items: Commands.dir,
                                        onChanged: (value) {
                                          setState(() {
                                            dir = value;

                                            Path();
                                            print(
                                                "ABCD = ${container2.join()}");
                                          });
                                        },
                                        selectedItem: container2.join(),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 200,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade700),
                              color: Colors.grey.shade400,
                            ),
                            margin:
                                EdgeInsets.only(left: 140, right: 3, top: 20),
                            child: Text(
                              "  " + "${container2.join()}",
                              style: TextStyle(
                                color: Colors.black,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                          Container(
                            height: 40,
                            width: 350,
                            margin: EdgeInsets.only(
                              top: 20,
                              left: 20,
                            ),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 85,
                                  child: Text("Image  : ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ),
                                Container(
                                  height: 35,
                                  width: 180,
                                  decoration: BoxDecoration(
                                      color: Colors.lightBlue,
                                      borderRadius: BorderRadius.circular(10)),
                                  margin: EdgeInsets.only(left: 20, right: 10),
                                  child: TextField(
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: "lowercase",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
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
                            margin: EdgeInsets.only(
                              top: 20,
                              left: 20,
                            ),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 85,
                                  child: Text("Tag  : ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ),
                                Container(
                                  height: 35,
                                  width: 180,
                                  decoration: BoxDecoration(
                                      color: Colors.lightBlue,
                                      borderRadius: BorderRadius.circular(10)),
                                  margin: EdgeInsets.only(left: 20, right: 10),
                                  child: TextField(
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: "Version",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
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
                            margin: EdgeInsets.all(25),
                            child: Container(
                              margin: EdgeInsets.all(0),
                              height: 50,
                              width: 180,
                              child: FloatingActionButton(
                                isExtended: true,
                                backgroundColor: Colors.lightBlue,
                                child: isloading1
                                    ? CircularProgressIndicator(
                                        backgroundColor: Colors.white,
                                      )
                                    : Text(
                                        "Build",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                onPressed: DockerScript,
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
      )),
    );
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
          title: Text("DockerFile Build"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => {Navigator.pop(context)}),
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
                                          Navigator.pop(context);
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
