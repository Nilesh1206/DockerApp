import 'package:DockerApp/Server/AWS.dart';
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
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
//import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:passwordfield/passwordfield.dart';
import 'package:ssh/ssh.dart';
import 'DockerLaunch.dart';
import 'package:DockerApp/ui/DockerCopy.dart';
import 'package:DockerApp/ui/LaunchPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:DockerApp/ui/DockerImages.dart';
import 'package:DockerApp/ui/DockerFileWrite.dart';
import 'Server/Network.dart';
import 'Server/Volumes.dart';
import 'package:DockerApp/ui/DeletePage.dart';

int _currentindex = 1;

enum PageEnum {
  containers,
  images,
  active,
  all,
  lsnet,
  connect,
  volume,
}

class MyApp extends StatefulWidget {
  final String title;
  MyApp({Key key, this.title}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

// ignore: camel_case_types
class contextCapture {
  static var context;
}



Future navigateToSubPage(context) async {
  Navigator.pop(context);
}

class _MyAppState extends State<MyApp> {
  // ignore: missing_return
 
      
  _onSelect(PageEnum value) {
    switch (value) {
      case PageEnum.containers:
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (BuildContext context) => ContainerDelete()));
        break;
      case PageEnum.images:
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (BuildContext context) => DockerImages()));
        break;
      default:
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (BuildContext context) => DockerImages()));
        break;
    }
  }
 
  @override
  Widget build(BuildContext context) {
    setState(() {
      Commands.currentindex = 1;
    });
    print("CURRENT INDEX = ${Commands.currentindex}");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
          length: 2,
          
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 0),
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("images/dock2.png"))),
                  ),
                  SizedBox(
                    width: 0,
                  ),
                 // Text('DockerApp'),
                ],
              ),
              backgroundColor: Colors.blue.shade500,
              bottom: TabBar(
                  indicatorColor: Colors.white,
                  labelColor: Colors.white,
                  tabs: [
                    Tab(
                      icon: Icon(Icons.home),
                      text: "Login",
                    ),
                    Tab(
                      icon: Icon(Icons.device_hub),
                      text: " Docker Hub",
                    ),
                  ]),
              actions: <Widget>[
                
                IconButton( 
                        icon:  Icon(Icons.file_download),
                         onPressed: () {
                           if (Commands.docker==null){
                          showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    elevation: 9,
                                    
                                    title: Row(
          children:[
            Image.asset('images/dock.png',
              width: 50, height: 50, fit: BoxFit.contain,),
             
            Text('  Docker Installation')
            ]
          ),
          
        content: Text('Install Docker "The Right way \n to launch your container."\n \n Are You Sure Want To Install?'),
        
        actions: <Widget>[
          FlatButton(
            child: Text("INSTALL"),
            onPressed: () async{
               DockerInstall();
               
               Status();
              
                
              ConnectedServer();
              
              
            },
          ),
 
           FlatButton(
            child: Text("CANCEL"),
            onPressed: () {
              
              Navigator.of(context).pop();
            },
          ),
        ],
      
                                  );
                                });}
                          if(Commands.docker!=null){
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    elevation: 9,
                                    
                                    title: Row(
          children:[
            Image.asset('images/dock.png',
              width: 50, height: 50, fit: BoxFit.contain,),
             
            Text('  Docker Version')
            ]
          ),
          
        content: Text('Docker is already installed \n in your system with version \n \n ${Commands.stat.substring(16,Commands.stat.length-22)}'),
        
        actions: <Widget>[
           FlatButton(
            child: Text("CANCEL"),
            onPressed: () {
              
              Navigator.of(context).pop();
            },
          ),
        ],
      
                                  );
                                });
                          }
                        }),
                    
                PopupMenuButton<PageEnum>(
                  //icon: Icon(Icons.desktop_windows),
                  onSelected: _onSelect,
                  itemBuilder: (context) => <PopupMenuEntry<PageEnum>>[
                    PopupMenuItem<PageEnum>(
                      value: PageEnum.containers,
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.laptop,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Active Containers",
                          )
                        ],
                      ),
                    ),
                    PopupMenuItem<PageEnum>(
                      value: PageEnum.images,
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.laptop,
                            color: Colors.grey.shade900,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Available Images",
                          )
                        ],
                      ),
                    ),
                  ],
                ),
               /* IconButton(
              icon: isloading2
                  ? Transform.scale(
                      scale: 0.4,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      ))
                  : Icon(
                      Icons.refresh,
                      size: 30,
                    ),
              onPressed: () async {
                setState(() {
                  isloading2 = true;
                });
                await Ret(state);
                setState(() {
                  print(result1);
                  Commands.stateChanger = ConnectedServer();
                  
                });
                setState(() {
                  isloading2 = false;
                });
              },
            ),*/
              ],
            ),
            body: Container(
              child: TabBarView(children: [
                MyHomePage(),
                DCHub(),
              ]),
            ),
            bottomNavigationBar: BottomNav(
              iconStyle: IconStyle(onSelectSize: 30),
              index: 1,
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
            drawer: Drawer(
              elevation: 10,
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    child: Image(
                      image: AssetImage('images/docker.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  ListTile(
                      leading: Icon(Icons.dock),
                      title: Text('Launch Container'),
                      onTap: () {
                        setState(() {
                          contextCapture.context = context;
                        });
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ContainerLaunch();
                        }));
                      }),
                  ListTile(
                    leading: Icon(Icons.file_download),
                    title: Text('Pull Container Image'),
                    onTap: () {
                      setState(() {
                        contextCapture.context = context;
                      });
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ImagePull();
                      }));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.call_to_action),
                    title: Text('Execute Command'),
                    onTap: () {
                      setState(() {
                        contextCapture.context = context;
                      });
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Execute();
                      }));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.content_copy),
                    title: Text('Docker Copy'),
                    onTap: () {
                      setState(() {
                        contextCapture.context = context;
                      });
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Dockercp();
                      }));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.library_books),
                    title: Text('Build Dockerfile'),
                    onTap: () {
                      setState(() {
                        contextCapture.context = context;
                      });
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return DockerFile(); //DockerFile();
                      }));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.book),
                    title: Text('Write Dockerfile'),
                    onTap: () {
                      setState(() {
                        contextCapture.context = context;
                      });
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return WriteFile(); //DockerFile();
                      }));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.copyright),
                    title: Text('Docker Commit'),
                    onTap: () {
                      setState(() {
                        contextCapture.context = context;
                      });
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Commit();
                      }));
                    },
                  ),
                  
                  Container(
                  
                    margin: EdgeInsetsDirectional.only(top: 0,bottom: 10),
                    child: Align(
                      alignment: FractionalOffset.bottomCenter,
                   child: Container( 
                       //alignment: Alignment.bottomCenter,
                       //color: Colors.lightBlue,
                       child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          
                          Divider(height: 60,),
                        Ink(
                        color: Colors.lightBlue,
                      child: ListTile(
                    
                     
                    leading: Icon(Icons.exit_to_app,color: Colors.white,),
                    title:  Text('Server Logout',style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold),),

                    onTap: ()async {
                      
                      await ServerLogout();
                      print('hiii');
                                          },
                                        ),)]
                                        )
                                        )
                                        )
                                        )
                                      ],
                                    ),
                                  ),
                                  drawerEnableOpenDragGesture: true,
                                )),
                          );
                        }
                      }
                      
                      
    

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _backgroundImage;
  String _setImage() {
    String _mTitle = "${ServerInfo.name.substring(7,31)}";

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
  _MyHomePageState() {
    //FlutterStatusbarcolor.setStatusBarColor(Colors.blue);
    //FlutterStatusbarcolor.setNavigationBarColor(Colors.blue);
  }
  var newWid = Container();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //FlutterStatusbarcolor.setStatusBarColor(Colors.blue);
    //FlutterStatusbarcolor.setNavigationBarColor(Colors.blue);
    MyHomePage();
    newWid = Commands.newWid;
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      contextCapture.context = context;
      //FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
      //FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
    });

    var LoginBody = SingleChildScrollView(
      child: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Center(
            child: Column(
              children: <Widget>[
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  margin: EdgeInsets.only(top: 35),
                  elevation: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade800, width: 1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.elliptical(10, 10),
                        bottomLeft: Radius.elliptical(10, 10),
                        topRight: Radius.elliptical(10, 10),
                        bottomRight: Radius.elliptical(10, 10),
                      ),
                    ),
                    width: 300,
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          "images/aws.jpg",
                          height: 120,
                          width: 120,
                        ),
                        Container(
                          child: Text(
                            "Amazon EC2 Instance",
                            style: TextStyle(
                                color: Colors.blue.shade900,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Center(
                            child: Text(
                              "Connect to any running AWS EC2 instance",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Center(
                            child: Wrap(
                              children: <Widget>[
                                Text(
                                  "Requirements : ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Public IP, Username, Key Pair, Passphrase",
                                  style: TextStyle(
                                      color: Colors.blue.shade800,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          alignment: Alignment.center,
                          child: Card(
                            child: Container(
                              margin: EdgeInsets.all(0),
                              height: 25,
                              width: 130,
                              child: FloatingActionButton(
                                heroTag: 1,
                                isExtended: true,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(0))),
                                backgroundColor: Colors.lightBlue,
                                child: Text("Select"),
                                onPressed: () {
                                  setState(() {
                                    Commands.isaws = true;
                                  });
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return AWSEC2();
                                  }));
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        )
                      ],
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  elevation: 8,
                  margin: EdgeInsets.only(top: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade800, width: 1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.elliptical(10, 10),
                        bottomLeft: Radius.elliptical(10, 10),
                        topRight: Radius.elliptical(10, 10),
                        bottomRight: Radius.elliptical(10, 10),
                      ),
                    ),
                    width: 300,
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.laptop_chromebook,
                          size: 140,
                          color: Colors.grey.shade700,
                        ),
                        Container(
                          child: Text(
                            "Bare metal",
                            style: TextStyle(
                                color: Colors.blue.shade900,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Center(
                            child: Text(
                              "Connect to any running Base Operating System or Virtual machine",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 10),
                          margin: EdgeInsets.only(top: 12),
                          child: Text(
                            "Requirements : ",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "Host IP, Username, Password",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.blue.shade800,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          alignment: Alignment.center,
                          child: Card(
                            child: Container(
                              margin: EdgeInsets.all(0),
                              height: 25,
                              width: 130,
                              child: FloatingActionButton(
                                heroTag: 2,
                                isExtended: true,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(0))),
                                backgroundColor: Colors.lightBlue,
                                child: Text("Select"),
                                onPressed: () {
                                  setState(() {
                                    Commands.isaws = false;
                                  });
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return BareMetal();
                                  }));
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("images/f2.png"), fit: BoxFit.cover),
      ),
      child: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 0),
            child: Icon(
              Icons.laptop_windows,
              size: 170,
              color: Colors.grey.shade700,
            ),
          ),
          Card(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            margin: EdgeInsets.only(top: 0, left: 30, right: 20, bottom: 20),
            child: Container(
              margin: EdgeInsets.all(0),
              height: 30,
              width: 180,
              child: FloatingActionButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                isExtended: true,
                backgroundColor: Colors.blue,
                child: Text("Server Login"),
                onPressed: () {
                  

                  Navigator.push(context, MaterialPageRoute(builder: (context) {
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
                              
                      
                             await  navigateToSubPage(context);

                            setState(() {
                    newWid = ConnectedServer();
                    Commands.newWid=ConnectedServer();
                  });
                            },
                          ),

                          backgroundColor: Colors.white,
                        ),
                        body: LoginBody,
                      ),
                    );
                  }));

                  /*setState(() {
                    newWid = Commands.newWid;
                  });*/
                  setState(() {
                    newWid = ConnectedServer();
                    Commands.newWid=ConnectedServer();
                  });
                },
              ),
            ),
          ),
          newWid
        ],
      )),
    );
  }
}

class DCHub extends StatefulWidget {
  final String title;
  DCHub({Key key, this.title}) : super(key: key);

  @override
  _DCHubState createState() => _DCHubState();
}

class _DCHubState extends State<DCHub> {
  @override
  Widget build(BuildContext context) {
    
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/d5.png"), fit: BoxFit.fill)),
      child: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(top: 75),
              margin: EdgeInsets.only(top: 0),
              child: Wrap(
                children: <Widget>[
                  Text(
                    "Docker",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 45,
                    ),
                  ),
                  Text(
                    "hub",
                    style: TextStyle(
                        color: Colors.lightBlue.shade200,
                        fontWeight: FontWeight.bold,
                        fontSize: 45),
                  ),
                ],
              )),
          Container(
            margin: EdgeInsets.only(left: 30, top: 15),
            width: MediaQuery.of(context).size.width - 25,
            child: Text(
              "Dockerhub is the world's easiest way to manage",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              softWrap: true,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 50),
            width: MediaQuery.of(context).size.width - 30,
            child: Text(
              "deliver your team's container applications",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              softWrap: true,
            ),
          ),
          SizedBox(height: 95),
          Container(
            width: 150,
            child: FloatingActionButton(
              elevation: 10,
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
              isExtended: true,
              onPressed: HubLaunch,
              child: Container(
                child: Text("Explore!"),
              ),
            ),
          )
        ],
      )),
    );
  }
}