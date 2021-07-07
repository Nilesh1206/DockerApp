import 'package:flutter/material.dart';

import 'package:DockerApp/DockerLaunch.dart';
import 'package:DockerApp/FrontEnd.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
//import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class DockerImages extends StatefulWidget {
  @override
  _DockerImagesState createState() => _DockerImagesState();
}

class _DockerImagesState extends State<DockerImages> {
  bool isloading = false;

  @override
  void initState() {
    super.initState();
    Retrive();
  }

  DeleteImage(cont) async {
    if (Commands.validation == "passed") {
      Commands.result = await serverCredentials.client.connect();
      if (Commands.result == "session_connected") {
        print("Connected");

        List<String> container = cont.split("");
        container = container.toList();
        container.removeLast();
        print("NOW = ${container.join()}");
        Commands.result = await serverCredentials.client
            .execute("docker rmi -f ${container.join()}");
      }
      if (Commands.result == "") {
        AppToast("Cannot Delete Image");
      } else {
        AppToast("Image Deleted");
      }
    } else {
      AppToast("Server not connected");
    }
  }

  Display() {
    if (Commands.validation == "passed") {
      int count = Commands.demo1.length - 1;
      //print("LENGTH INIT = ${Commands.demo.length}");
      return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          //ShrinkWrappingViewport: true,
          itemCount: count,
          itemBuilder: (BuildContext context, int index) {
            return Slidable(
             actionPane: SlidableDrawerActionPane(),
              child: ListTile(
              leading: Icon(
                Icons.laptop_windows,
                color: Colors.lightBlue,
              ),
              title: Text(
                '${Commands.demo1[index]}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              
             ),
             secondaryActions: <Widget>[
    IconSlideAction(
      caption: 'Inspect',
      color: Colors.black45,
      icon: Icons.more_horiz,
      onTap: () => null,
    ),
    IconSlideAction(
      caption: 'Delete',
      color: Colors.grey.shade700,
      icon: Icons.delete,
      onTap: () => {
        DeleteImage(Commands.demo1[index]),
                  setState(
                    () {
                      Retrive();
                    },
                  )
      },
    ),
  ], 
             );
          });
    } else {
      AppToast("Server not connected");
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    //FlutterStatusbarcolor.setStatusBarColor(Colors.blue);
    //FlutterStatusbarcolor.setNavigationBarColor(Colors.blue);
    var body = SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Column(children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: 200,
              width: 200,
              child: Image.asset('images/dock.png'),
            ),
            Container(
              height: 40,
              width: 350,
              decoration: BoxDecoration(
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.circular(20)),
              margin: EdgeInsets.only(top: 1),
              child: Center(
                child: Text(
                  "Available Images",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Display()
          ])
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Available Images"),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => {Navigator.pop(context)}),
      ),
      body: body,
    );
  }
}
