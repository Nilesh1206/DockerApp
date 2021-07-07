import 'package:DockerApp/Server/Network.dart';
import 'package:DockerApp/Server/Volumes.dart';
import 'package:bmnav/bmnav.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:DockerApp/DockerLaunch.dart';
import 'package:DockerApp/FrontEnd.dart';
//import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class ContainerLaunch extends StatefulWidget {
  @override
  _ContainerLaunchState createState() => _ContainerLaunchState();
}

bool launchLoading = false;
TextEditingController _value;
String environment = "";
var i;

class _ContainerLaunchState extends State<ContainerLaunch> {
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    VolumeListRet();
    Retrive();
  }
    bool isChecked = false;
    bool isValue = false;
  @override
  Widget build(BuildContext context) {
    //FlutterStatusbarcolor.setStatusBarColor(Colors.blue.shade600);
    //FlutterStatusbarcolor.setNavigationBarColor(Colors.blue);
    print("COMMANDS.ENV = ${Commands.env}");

    for (i = 0; i < Commands.env.length; i++) {
      print(Commands.env[i]);
      environment = environment + " -e " + Commands.env[i];
      print("ENVIRONMENT = $environment");
    }

    DynamicAdd() {
      Commands.TextfieldDynamic.add(new DynamicText());
      print(Commands.TextfieldDynamic.length);
      setState(() {
        ContainerLaunch();
      });
    }

    DynamicRemove() {
      Commands.TextfieldDynamic.removeLast();
      if (Commands.env.length > 0) {
        Commands.env.removeLast();
      }
      print(Commands.TextfieldDynamic.length);
      setState(() {
        ContainerLaunch();
      });
    }

    StartContainer() async {
      setState(() {
        launchLoading = true;
      });
      if (Commands.validation == "passed") {
        Commands.result = await serverCredentials.client.connect();

        if (Commands.name != null && Commands.image != null) {
          print("************PASSED 1");
          if (Commands.port != null) {
            if (Commands.env.length != 0) {
              print("ENV STRING = $environment");
              if (Commands.selectedVol != null) {
                Commands.result = await serverCredentials.client.execute(
                    "docker run -dit --name ${Commands.name} -p ${Commands.port} -v ${Commands.selectedVol} $environment ${Commands.image}");
              } else {
                Commands.result = await serverCredentials.client.execute(
                    "docker run -dit --name ${Commands.name} -p ${Commands.port}  $environment ${Commands.image}");
              }
            } else {
              if (Commands.selectedVol == null) {
                Commands.result = await serverCredentials.client.execute(
                    "docker run -dit --name ${Commands.name} -p ${Commands.port} ${Commands.image}");
              } else {
                Commands.result = await serverCredentials.client.execute(
                    "docker run -dit --name ${Commands.name} -p ${Commands.port} -v ${Commands.selectedVol} ${Commands.image}");
              }
            }
          } else {
            print("**********PASSED PORT");
            if (Commands.env.length != 0) {
              print("ENV STRING = $environment");
              if (Commands.selectedVol == null) {
                Commands.result = await serverCredentials.client.execute(
                    "docker run -dit --name ${Commands.name} $environment ${Commands.image}");
              } else {
                Commands.result = await serverCredentials.client.execute(
                    "docker run -dit --name ${Commands.name} -v ${Commands.selectedVol} $environment ${Commands.image}");
              }
            } else {
              print("**********PASSED ENV");
              if (Commands.selectedVol == null) {
                print("**********PASSED VOlume");
                print("###CONT NAME = ${Commands.name}#####");
                print("###CONT Image = ${Commands.image}#####");
                Commands.result = await serverCredentials.client.execute(
                    "docker run -dit --name ${Commands.name} ${Commands.image}");
                print("RESULT HERE");
                print(Commands.result);
              } else {
                Commands.result = await serverCredentials.client.execute(
                    "docker run -dit --name ${Commands.name} -v ${Commands.selectedVol} ${Commands.image}");
              }
            }
          }
          print(Commands.result);
          if (Commands.result == "") {
            AppToast("${Commands.name} : Failed to launch the container");
          } else {
            print("RESULT = ${Commands.result}");
            AppToast("Container Launched");
            print("RESULT = ${Commands.result}");
          }
        } else {
          AppToast("No input provided");
        }
      } else {
        print("RESULT = ${Commands.result}");
        AppToast("Server not connected");
      }
      setState(() {
        launchLoading = false;
      });
    }

    

    var body = Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/a2.png"), fit: BoxFit.cover)),
        child: SingleChildScrollView(
            child: Column(children: <Widget>[
          Container(
            margin: EdgeInsets.all(25),
            alignment: Alignment.center,
            height: 140,
            width: 150,
            child: Image.asset(
              'images/dock2.png',
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            margin: EdgeInsets.only(left: 13, right: 13),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/card1.png"), fit: BoxFit.cover),
                border: Border.all(color: Colors.grey.shade800, width: 1),
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
                  margin: EdgeInsets.only(top: 15),
                  child: Center(
                    child: Text(
                      "Docker Container",
                      style: TextStyle(color: Colors.white),
                    ),
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
                          " Name   : ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        height: 35,
                        width: 210,
                        decoration: BoxDecoration(
                            color: Colors.lightBlue,
                            borderRadius: BorderRadius.circular(10)),
                        margin: EdgeInsets.only(left: 20, right: 10),
                        child: TextField(
                          autocorrect: false,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Container",
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 13),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                          onChanged: (value) => {Commands.name = value},
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
                        child: Text(" Image  : ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        height: 35,
                        width: 210,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        margin: EdgeInsets.only(left: 20, right: 10),
                        child: DropdownSearch(
                          popupBackgroundColor: Colors.white,
                          mode: Mode.MENU,
                          showSelectedItem: true,
                          items: Commands.demo1,
                          onChanged: (value) {
                            setState(() {
                              var newValue = value.split("");
                              newValue.removeLast();

                              print(
                                  "###VALUE LENGTH = ${newValue.join().length}#####");
                              //dir = value;
                              Commands.image = newValue.join();
                              print("OPHERE01 = ${Commands.image}");

                              //print("ABCD = ${items}");
                            });
                          },
                          selectedItem: Commands.image,
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
                        child: Text(" Ports    : ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        height: 35,
                        width: 210,
                        decoration: BoxDecoration(
                            color: Colors.lightBlue,
                            borderRadius: BorderRadius.circular(10)),
                        margin: EdgeInsets.only(left: 20, right: 10),
                        child: TextField(
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Ports",
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 13),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                          onChanged: (value) => {Commands.port = value},
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
                        child: Text("Volumes: ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        height: 35,
                        width: 210,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        margin: EdgeInsets.only(left: 20, right: 10),
                        child: DropdownSearch(
                          popupBackgroundColor: Colors.white,
                          mode: Mode.MENU,
                          showSelectedItem: false,
                          items: Commands.volumename,
                          onChanged: (value) {
                            Commands.selectedVol = value;
                            setState(() {
                              VolumeListRet();
                            });
                          },
                          selectedItem: Commands.selectedVol,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top: 20, left: 35),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 70,
                        child: Text("   Env      : ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Column(
                        children: Commands.TextfieldDynamic,
                      ),
                      Column(
                        children: <Widget>[
                          IconButton(
                            iconSize: 30,
                            icon: Icon(
                              Icons.add_circle,
                              color: Colors.lightBlue,
                            ),
                            onPressed: DynamicAdd,
                          ),
                          Commands.TextfieldDynamic.length >= 1
                              ? IconButton(
                                  iconSize: 30,
                                  icon: Icon(
                                    Icons.remove_circle,
                                    color: Colors.lightBlue,
                                  ),
                                  onPressed: DynamicRemove,
                                )
                              : SizedBox(),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                    height: 40,
                    width: 350,
                    margin: EdgeInsets.only(top: 20, left: 20),
                    child: Center(
                        child: Row(
                      children: <Widget>[
                        
                        Checkbox(
                          value: isChecked,
                          onChanged: (bool value) => {
                                setState(() {
                                  isChecked = value; 
                                }),
                                print(isChecked)   
                          },
                        ),
                        Text("Always Restart"),
                        Checkbox(
                          value: isValue, 
                        onChanged: (bool value )=>{
                          setState((){
                            isValue =value;
                          }),
                          print(isValue)
                        },),
                        Text('Always Delete')
                      ],
                    ))),
              ],
            ),
          ),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            margin: EdgeInsets.all(25),
            child: Container(
              margin: EdgeInsets.all(0),
              height: 50,
              width: 180,
              child: FloatingActionButton(
                isExtended: true,
                backgroundColor: Colors.lightBlue,
                child: launchLoading
                    ? CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      )
                    : Text("Launch"),
                onPressed: StartContainer,
              ),
            ),
          )
        ])));

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
          backgroundColor: Colors.blue.shade600,
          title: Text(
            "Launch Container",
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () => {Navigator.pop(context)}),
        ),
        body: body,
      ),
    );
  }
}

class DynamicText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 200,
      decoration: BoxDecoration(
          color: Colors.lightBlue, borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.only(left: 20, right: 0, top: 10),
      child: TextField(
        controller: _value,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: "Environment Variables",
            hintStyle: TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))),
        autocorrect: false,
        enableInteractiveSelection: true,
        enableSuggestions: true,
        onSubmitted: (String value) => {Commands.env.add(value)},
        //onChanged: (String value) => {Commands.env.add(value)},
      ),
    );
  }
}
