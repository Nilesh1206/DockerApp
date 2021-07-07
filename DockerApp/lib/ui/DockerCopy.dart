import 'package:DockerApp/Server/Network.dart';
import 'package:DockerApp/Server/Volumes.dart';
import 'package:bmnav/bmnav.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:DockerApp/DockerLaunch.dart';
import 'package:DockerApp/FrontEnd.dart';
//import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class Dockercp extends StatefulWidget {
  @override
  _DockercpState createState() => _DockercpState();
}

class _DockercpState extends State<Dockercp> {
  bool isloading1 = false;
  String dir = " ";
  int l = 1, y = 0;

  List<String> container;
  List<String> container2 = ["/"];

  DockerCopy() async {
    if (Commands.validation == "passed") {
      Commands.result = await serverCredentials.client.connect();
      //if (result== 'Session connected'){
      if (container2 != null &&
          Commands.contName != null &&
          Commands.loc2 != null) {
        var nolast = Commands.contName.split("").toList();
        nolast.removeLast();
        var newName = nolast.join();
        print("NOLAST = ${newName.length}");

        Commands.result = await serverCredentials.client.execute(
            "docker cp ${container2.join()} ${newName}:${Commands.loc2}");
        print("CP COMMAND = ${Commands.result}");

        // }

        if (Commands.result == "") {
          AppToast("Copy Successful");
        } else {
          AppToast("Cannot copy inside the container");
        }
      } else {
        AppToast("No input Provided");
      }
    } else {
      print("RESULT = ${Commands.result}");
      AppToast("Server not connected");
    }
  }

  var result2;

  Fun() async {
    if (container2.length == 0) {
      container2.add("/");
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

        container = dir.split("");
        print("SPLIT = $container");
        container.removeLast();
        print("LAST = ${container.length}");

        if (container.join() != container2.join()) {
          String p = "/";
          if (y == 0) {
            y = 1;
          } else {
            if (container2.length > 1) {
              container2.add(p);
            }
          }
          container2.add(container.join());

          result2 =
              await serverCredentials.client.execute("ls ${container2.join()}");
          Commands.dir = await result2.split('\n').toList();
        }
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
    Ret("active");
  }

  @override
  Widget build(BuildContext context) {
    //FlutterStatusbarcolor.setStatusBarColor(Colors.blue);
    //FlutterStatusbarcolor.setNavigationBarColor(Colors.blue);
    var items = [''];
    GetContainers() async {
      await Ret("active");
    }

    setState(() {
      GetContainers();
      items = Commands.demo;
    });

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
                      margin: EdgeInsets.only(bottom: 0),
                      alignment: Alignment.center,
                      height: 200,
                      width: 200,
                      child: Image.asset('images/dock.png'),
                    ),
                    Container(
                        margin:
                            EdgeInsets.only(left: 13, right: 13, bottom: 250),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("images/b3.png"),
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
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 40,
                              width: 350,
                              decoration: BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius: BorderRadius.circular(20)),
                              margin: EdgeInsets.only(top: 10),
                              child: Center(
                                child: Text(
                                  "Docker Copy",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            Column(children: <Widget>[
                              Container(
                                height: 40,
                                width: 350,
                                margin: EdgeInsets.only(top: 20, left: 20),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: 85,
                                      child: Text("Base Location   : ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
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
                                          margin: EdgeInsets.only(
                                              left: 0, right: 10),
                                          child: DropdownSearch(
                                            maxHeight: 280,
                                            showSearchBox: true,
                                            searchBoxDecoration:
                                                InputDecoration(
                                              hintText: "Search",
                                              hintStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 13),
                                              suffixIcon: Icon(Icons.search),
                                            ),
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
                                  border:
                                      Border.all(color: Colors.grey.shade700),
                                  color: Colors.grey.shade400,
                                ),
                                margin: EdgeInsets.only(
                                    left: 140, right: 3, top: 20),
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
                                      child: Text("Container  : ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
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
                                            Commands.contName = value;
                                            print(
                                                "OPHERE01 = ${Commands.contName}");

                                            //print("ABCD = ${items}");
                                          });
                                        },
                                        selectedItem: Commands.contName,
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
                                      child: Text("Location  : ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    Container(
                                      height: 35,
                                      width: 180,
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
                                            hintText:
                                                "Location inside container",
                                            hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 13),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)))),
                                        onChanged: (value) =>
                                            {Commands.loc2 = value},
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
                                    child: Text("Copy"),
                                    onPressed: DockerCopy,
                                  ),
                                ),
                              )
                            ])
                          ],
                        ))
                  ],
                ),
              ),
            ],
          ),
        ));
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
          title: Text("Docker Copy"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => {Navigator.pop(context)}),
        ),
        body: body,
      ),
    );
  }
}
