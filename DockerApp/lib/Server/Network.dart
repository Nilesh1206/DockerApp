import 'package:bmnav/bmnav.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:DockerApp/DockerLaunch.dart';
import 'package:DockerApp/FrontEnd.dart';
//import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

import 'Volumes.dart';

class Network extends StatefulWidget {
  @override
  _NetworkState createState() => _NetworkState();
}

class _NetworkState extends State<Network> {
  _onSelect(PageEnum value) {
    switch (value) {
      case PageEnum.lsnet:
        Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
          NetListRet();
          return NetworkList();
        }));
        break;
      case PageEnum.connect:
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (BuildContext context) => NetworkList()));
        break;
      default:
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (BuildContext context) => NetworkList()));
        break;
    }
  }

  NetworkCreate() async {
    if (Commands.validation == "passed") {
      if (Commands.netname != null) {
        Commands.result = await serverCredentials.client.connect();
        if (Commands.result == "session_connected") {
          Commands.result = await serverCredentials.client
              .execute("docker network create ${Commands.netname}");
          print(Commands.result);
        }
        if (Commands.result == "") {
          AppToast("Cannot create network");
        } else {
          AppToast("Network created");
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
                    child: Transform.scale(
                      scale: 1.8,
                      child: Image.asset(
                        'images/net5.jpg',
                      ),
                    )),
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
                            "Create Network",
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
                                    "Network   : ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
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
                                        hintStyle: TextStyle(
                                            color: Colors.grey, fontSize: 13),
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
                                  await NetListRet();
                                  NetworkCreate();
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
        bottomNavigationBar: BottomNav(
          iconStyle: IconStyle(onSelectSize: 30),
          index: 0,
          labelStyle: LabelStyle(showOnSelect: true),
          onTap: (index) {
            if (index == 0) {
              setState(() {
                Commands.currentindex = 0;
              });
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

        /*BottomNavigationBar(
          selectedItemColor: Colors.white,
          selectedIconTheme: IconThemeData(color: Colors.lightBlue, size: 30),
          selectedFontSize: 15,
          onTap: (index) {
            if (index == 0) {
              if (context != netContextCapture.netContext) {
                Navigator.push(context, MaterialPageRoute(builder: (context1) {
                  return Network();
                }));
              }
            }
            if (index == 2) {
              Navigator.push(context, MaterialPageRoute(builder: (context1) {
                return Volume();
              }));
            }
          },
          backgroundColor: Colors.blue,
          currentIndex: 0,
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
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Docker Networks"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => {Navigator.pop(context)}),
          actions: <Widget>[
            PopupMenuButton<PageEnum>(
              icon: Icon(Icons.device_hub),
              //icon: Icon(Icons.desktop_windows),
              onSelected: _onSelect,
              itemBuilder: (context) => <PopupMenuEntry<PageEnum>>[
                PopupMenuItem<PageEnum>(
                  value: PageEnum.containers,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.network_cell,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "List Network",
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        body: body,
      ),
    );
  }
}

//List Networks Class
class NetworkList extends StatefulWidget {
  @override
  _NetworkListState createState() => _NetworkListState();
}

class _NetworkListState extends State<NetworkList> {
  static NetworkDelete(net) async {
    if (Commands.validation == "passed") {
      Commands.result = await serverCredentials.client.connect();
      if (Commands.result == "session_connected") {
        if (net != "bridge" || net != "host" || net != "none") {
          List<String> network = net.split("");
          network = network.toList();
          network.removeLast();
          print(network.join());

          Commands.result = await serverCredentials.client
              .execute("docker network rm ${network.join()}");
        }
        if (Commands.result == "") {
          AppToast("Cannot Delete Network");
        } else {
          AppToast("Network Removed");
        }
      } else {
        AppToast("Cannot Delete Pre-defined Networks");
      }
    } else {
      AppToast("Server not connected");
    }
  }

  static NetworkInspect(netname) async {
    if (Commands.validation == "passed") {
      Commands.result = await serverCredentials.client.connect();
      if (Commands.result == "session_connected") {
        if (netname != null) {
          List<String> network = netname.split("");
          network = network.toList();
          network.removeLast();
          print(network.join());

          Commands.result = await serverCredentials.client
              .execute("docker network inspect ${network.join()}");
          Commands.netInspect = Commands.result;
        }
        if (Commands.result == "") {
          AppToast("Unknown Network");
        } else {
          AppToast("Inspecting Network");
        }
      } else {
        AppToast("Cannot inspect Network");
      }
    } else {
      AppToast("Server not connected");
    }
  }

  static Display() {
    if (Commands.validation == "passed") {
      int count = Commands.netls.length - 1;
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
                      height: 225,
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
                                  '${Commands.netls[index]}',
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
                                        NetworkDelete(
                                            "${Commands.netls[index]}");
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
                                  "Network ID  :  ",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Text(
                                  "${Commands.netls2[index]}",
                                ),
                              ),
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
                                  "${Commands.netls3[index]}",
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(left: 10, top: 10),
                                child: Text(
                                  "Scope  :  ",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Text(
                                  "${Commands.netls4[index]}",
                                ),
                              )
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10, top: 10),
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
                                  child: Wrap(
                                    children: <Widget>[
                                      Text("Inspect"),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Icon(
                                        Icons.search,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                  onPressed: () async {
                                    await NetworkInspect(
                                        "${Commands.netls[index]}");
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return MaterialApp(
                                        theme: ThemeData.dark(),
                                        debugShowCheckedModeBanner: false,
                                        home: Scaffold(
                                            appBar: AppBar(
                                              backgroundColor: Colors.blue,
                                              title: Text("Network Inspect"),
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
    NetListRet();
  }

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    //FlutterStatusbarcolor.setStatusBarColor(Colors.blue);
    //FlutterStatusbarcolor.setNavigationBarColor(Colors.blue);

    ScaffoldBodyState() {
      return Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/f2.png"), fit: BoxFit.cover)),
        child: SingleChildScrollView(
            child: Stack(children: <Widget>[
          Center(
              child: Column(children: <Widget>[
            Container(
                alignment: Alignment.center,
                height: 200,
                width: 200,
                child: Transform.scale(
                  scale: 1.8,
                  child: Image.asset(
                    'images/net5.jpg',
                  ),
                )),
            Container(
              height: 40,
              width: 350,
              decoration: BoxDecoration(
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.circular(20)),
              margin: EdgeInsets.only(top: 1),
              child: Center(
                child: Text(
                  "Available Networks",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            statelist
          ]))
        ])),
      );
    }

    var listNetworks = ScaffoldBodyState();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Available Networks"),
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
                  await NetListRet();
                  setState(() {
                    statelist = Display();
                    listNetworks = ScaffoldBodyState();
                  });
                  setState(() {
                    loading = false;
                  });
                })
          ],
        ),
        body: listNetworks,
      ),
    );
  }
}
