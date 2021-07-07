import 'package:bmnav/bmnav.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:DockerApp/DockerLaunch.dart';
import 'package:DockerApp/FrontEnd.dart';
//import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

import 'Network.dart';

class Volume extends StatefulWidget {
  @override
  _VolumeState createState() => _VolumeState();
}

class _VolumeState extends State<Volume> {
  _onSelect(PageEnum value) {
    switch (value) {
      case PageEnum.volume:
        Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
          NetListRet();
          return VolumeList();
        }));
        break;
      default:
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (BuildContext context) => VolumeList()));
        break;
    }
  }

  VolumeCreate() async {
    if (Commands.validation == "passed") {
      if (Commands.netname != null) {
        Commands.result = await serverCredentials.client.connect();
        if (Commands.result == "session_connected") {
          Commands.result = await serverCredentials.client
              .execute("docker volume create ${Commands.netname}");
          print(Commands.result);
        }
        if (Commands.result == "") {
          AppToast("Cannot create volume");
        } else {
          AppToast("Volume created");
        }
      } else {
        AppToast("No input provided");
      }
    } else {
      AppToast("Server not connected");
    }
  }

  @override
  Widget build(BuildContext context) {
    //FlutterStatusbarcolor.setStatusBarColor(Colors.blue);
    //FlutterStatusbarcolor.setNavigationBarColor(Colors.blue);
    var body = SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    height: 200,
                    width: 200,
                    child: Icon(
                      Icons.storage,
                      size: 150,
                      color: Colors.lightBlue,
                    )

                    /*Image.asset(
                        'images/net5.jpg',
                      ),*/
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
                            "Create Volume",
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
                                  child: Text("Volume   : "),
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
                                        hintText: "Name",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)))),
                                    onChanged: (value) =>
                                        {Commands.netname = value},
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
                                child: Text("Create"),
                                onPressed: () async {
                                  VolumeCreate();
                                  await VolumeListRet();
                                },
                              ),
                            ),
                          )
                        ],
                      )
                    ]))
              ],
            ),
          ),
        ],
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Docker Volumes"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => {Navigator.pop(context)}),
          actions: <Widget>[
            PopupMenuButton<PageEnum>(
              icon: Icon(Icons.storage),
              //icon: Icon(Icons.desktop_windows),
              onSelected: _onSelect,
              itemBuilder: (context) => <PopupMenuEntry<PageEnum>>[
                PopupMenuItem<PageEnum>(
                  value: PageEnum.containers,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.storage,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "List Volumes",
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        bottomNavigationBar: BottomNav(
          iconStyle: IconStyle(onSelectSize: 30),
          index: 2,
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
            }
          },
          items: [
            BottomNavItem(Icons.cloud, label: 'Networks'),
            BottomNavItem(Icons.home, label: 'Home'),
            BottomNavItem(Icons.storage, label: 'Volumes')
          ],
        ),

        /*BottomNavigationBar(
          selectedItemColor: Colors.white,
          selectedIconTheme: IconThemeData(color: Colors.lightBlue, size: 30),
          selectedFontSize: 15,
          onTap: (index) {
            if (index == 0) {
              Navigator.push(context, MaterialPageRoute(builder: (context1) {
                return Network();
              }));
            }
            if (index == 2) {
              if (context != volumeContextCapture.volContext) {
                Navigator.push(context, MaterialPageRoute(builder: (context1) {
                  return Volume();
                }));
              }
            }
          },
          backgroundColor: Colors.blue,
          currentIndex: 2,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.cloud, color: Colors.white),
              title: Text(
                'Networks',
                style: TextStyle(color: Colors.white),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              title: Text(
                'Home',
                style: TextStyle(color: Colors.white),
              ),
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.storage,
                  color: Colors.white,
                ),
                title: Text(
                  'Volumes',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),*/
        body: body,
      ),
    );
  }
}

//List Networks Class
class VolumeList extends StatefulWidget {
  @override
  _VolumeListState createState() => _VolumeListState();
}

class _VolumeListState extends State<VolumeList> {
  static VolumeDelete(net) async {
    if (Commands.validation == "passed") {
      Commands.result = await serverCredentials.client.connect();
      if (Commands.result == "session_connected") {
        if (net != null) {
          List<String> network = net.split("");
          network = network.toList();
          network.removeLast();
          print(network.join());

          Commands.result = await serverCredentials.client
              .execute("docker volume rm ${network.join()}");
        }
        if (Commands.result == "") {
          AppToast("Cannot Delete Volume");
        } else {
          AppToast("Volume Removed");
        }
      } else {
        AppToast("Unable to connect");
      }
    } else {
      AppToast("Server not connected");
    }
  }

  static VolumeInspect(netname) async {
    if (Commands.validation == "passed") {
      Commands.result = await serverCredentials.client.connect();
      if (Commands.result == "session_connected") {
        if (netname != null) {
          List<String> volume = netname.split("");
          volume = volume.toList();
          volume.removeLast();
          print(volume.join());

          Commands.result = await serverCredentials.client
              .execute("docker volume inspect ${volume.join()}");
          Commands.netInspect = Commands.result;
        }
        if (Commands.result == "") {
          AppToast("Unknown Volume");
        } else {
          AppToast("Inspecting Volume");
        }
      } else {
        AppToast("Cannot inspect Volume");
      }
    } else {
      AppToast("Server not connected");
    }
  }

  static Display() {
    if (Commands.validation == "passed") {
      int count = Commands.volumename.length;
      //print("LENGTH INIT = ${Commands.demo.length}");
      return ListView(
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          //separatorBuilder: (context, index) => Divider(),
          shrinkWrap: true,
          children: <Widget>[
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                //ShrinkWrappingViewport: true,
                itemCount: count,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      width: 350,
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                width: 300,
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(left: 10, top: 10),
                                child: Text(
                                  '${Commands.volumename[index]}',
                                  style: TextStyle(
                                      color: Colors.lightBlue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                              ),
                              Container(
                                alignment: Alignment.topRight,
                                margin: EdgeInsets.only(top: 10, right: 10),
                                child: Transform.scale(
                                    scale: 1.3,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.grey.shade500,
                                      ),
                                      onPressed: () async {
                                        VolumeDelete(
                                            "${Commands.volumename[index]}");
                                        await NetListRet();
                                      },
                                    )),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(left: 10, top: 10),
                                child: Text(
                                  "Driver  :  ",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Text(
                                  "${Commands.volumedriver[index]}",
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(left: 10, top: 10, bottom: 20),
                            alignment: Alignment.topLeft,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              child: Container(
                                margin: EdgeInsets.all(0),
                                height: 25,
                                width: 130,
                                child: FloatingActionButton(
                                  heroTag: index,
                                  isExtended: true,
                                  backgroundColor: Colors.lightBlue,
                                  child: Text("Inspect"),
                                  onPressed: () async {
                                    await VolumeInspect(
                                        "${Commands.volumename[index]}");
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return MaterialApp(
                                        theme: ThemeData.dark(),
                                        debugShowCheckedModeBanner: false,
                                        home: Scaffold(
                                            appBar: AppBar(
                                              backgroundColor: Colors.blue,
                                              title: Text("Volume Inspect"),
                                              leading: IconButton(
                                                  icon: Icon(Icons.arrow_back),
                                                  onPressed: () =>
                                                      {Navigator.pop(context)}),
                                            ),
                                            body: SingleChildScrollView(
                                              child: Text(Commands.result),
                                            )),
                                      );
                                    }));
                                  },
                                ),
                              ),
                            ),
                          )
                        ],
                      ));
                })
          ]);
    } else {
      AppToast("Server not connected");
      return Container();
    }
  }

  static var statelist = Display();

  @override
  void initState() {
    super.initState();
    VolumeListRet();
  }

  bool loading = false;

  @override
  Widget build(BuildContext context) {
   // FlutterStatusbarcolor.setStatusBarColor(Colors.blue);
    //FlutterStatusbarcolor.setNavigationBarColor(Colors.blue);

    ScaffoldBodyState() {
      return Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/a3.png"), fit: BoxFit.cover)),
        child: SingleChildScrollView(
            child: Stack(children: <Widget>[
          Center(
              child: Column(children: <Widget>[
            Container(
                alignment: Alignment.center,
                height: 200,
                width: 200,
                child: Icon(Icons.storage, color: Colors.lightBlue, size: 150)),
            Container(
              height: 40,
              width: 350,
              decoration: BoxDecoration(
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.circular(20)),
              margin: EdgeInsets.only(top: 1),
              child: Center(
                child: Text(
                  "Available Volumes",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            statelist
          ]))
        ])),
      );
    }

    var listVolumes = ScaffoldBodyState();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Available Volumes"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => {Navigator.pop(context)}),
          actions: <Widget>[
            IconButton(
                icon: loading
                    ? Transform.scale(
                        scale: 0.6,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        ),
                      )
                    : Icon(
                        Icons.refresh,
                        size: 30,
                      ),
                onPressed: () async {
                  setState(() {
                    loading = true;
                  });
                  await VolumeListRet();
                  setState(() {
                    statelist = Display();
                    listVolumes = ScaffoldBodyState();
                  });
                  setState(() {
                    loading = false;
                  });
                })
          ],
        ),
        body: listVolumes,
      ),
    );
  }
}
