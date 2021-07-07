import 'package:DockerApp/Server/Network.dart';
import 'package:DockerApp/Server/Volumes.dart';
import 'package:bmnav/bmnav.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:DockerApp/DockerLaunch.dart';
import 'package:DockerApp/FrontEnd.dart';
//import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class Execute extends StatefulWidget {
  @override
  _ExecuteState createState() => _ExecuteState();
}

class _ExecuteState extends State<Execute> {
  TextEditingController _controller;

  

  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  void initState() {
    // TODO: implement initState
    super.initState();
    Ret("active");
     _controller = TextEditingController();
  }
  @override
 

  @override
  Widget build(BuildContext context) {
    //FlutterStatusbarcolor.setStatusBarColor(Colors.blue);
    //FlutterStatusbarcolor.setNavigationBarColor(Colors.blue);
    var items = [''];
    setState(() => {items.add('${Commands.name}')});
    //items.join('${Commands.name}');
    var body;
    ScrollController execScrollControl = ScrollController();
    ExecBody() {
      
            return Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/e1.png"), fit: BoxFit.cover)),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              height: 170,
                              width: 190,
                              child: Image.asset('images/123.png'),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 13, right: 13, top: 15),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("images/04.png"),
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
                                    margin: EdgeInsets.only(top: 15),
                                    child: Center(
                                      child: Text(
                                        "Execute Command",
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
                                            child: Text(
                                              "Container   : ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Container(
                                            height: 35,
                                            width: 190,
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
                                      margin: EdgeInsets.only(
                                        top: 20,
                                        left: 20,
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            width: 85,
                                            child: Text(
                                              "Command  : ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Container(
                                            height: 40,
                                            width: 195,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            margin:
                                                EdgeInsets.only(left: 20, right: 10),
                                            
                                            child: Row(
                                              children: [
                                                new Flexible(
                                                child:  new TextField(
                                                  //autofocus: true,
                                                  
                                                 // controller: _controller,
                                                  //textAlign: TextAlign.start,
                                                 // keyboardType:
                                                     // TextInputType.visiblePassword,
                                                  style: TextStyle(color: Colors.black),
                                                  decoration: InputDecoration(
                                                      hintText: "command",
                                                      hintStyle: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 13),
                                                     /* border: OutlineInputBorder(
                                                          borderRadius: BorderRadius.all(
                                                              Radius.circular(10)))*/
                                                              ),
                                                  onChanged: (value) =>
                                                      {Commands.command = value},
                                                ),)
                                              ],
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
                                          child: Text("Execute"),
                                          onPressed: () async {
                                            await ExecuteContainer(
                                                ("${Commands.name}"),
                                                ("${Commands.command}"));
      
                                            setState(() {
                                              Commands.execresult = Container(
                                                height: 200,
                                                width: 350,
                                                margin: EdgeInsets.only(
                                                    left: 13,
                                                    right: 13,
                                                    top: 15,
                                                    bottom: 25),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: Colors.black, width: 1),
                                                ),
                                                child: Center(
                                                  child: SingleChildScrollView(
                                                    child: Text(
                                                      "${Commands.execop}",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.blue.shade700),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            });
                                            setState(() {
                                              body = ExecBody();
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ]),
                                ],
                              ),
                            ),
                            Commands.execresult
                    ],
                  ),
                ),
              ],
            ),
          ));
    }

    body = ExecBody();

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
          title: Text("Execute Command"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => {Navigator.pop(context)}),
        ),
        body: body,
      ),
    );
  }
}
