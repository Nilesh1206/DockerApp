import 'package:DockerApp/Server/Network.dart';
import 'package:DockerApp/Server/Volumes.dart';
import 'package:bmnav/bmnav.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

import '../DockerLaunch.dart';
import '../FrontEnd.dart';

class WriteFile extends StatefulWidget {
  @override
  _WriteFileState createState() => _WriteFileState();
}

TextEditingController control = TextEditingController();

class MyTextController extends TextEditingController {
  @override
  TextSpan buildTextSpan({TextStyle style, bool withComposing}) {
    List<InlineSpan> children = [];

    if (text.contains(' ')) {
      children.add(TextSpan(
          style: TextStyle(color: Colors.lightBlue),
          text: text.substring(0, text.indexOf(' '))));

      children.add(TextSpan(text: text.substring(text.indexOf(" "))));

      print(text.indexOf(text.substring(text.indexOf(' '))));
    } else {
      children
          .add(TextSpan(style: TextStyle(color: Colors.lightBlue), text: text));
    }
    return TextSpan(style: style, children: children);
  }
}

class _WriteFileState extends State<WriteFile> {
  int max = 1;
  @override
  Widget build(BuildContext context) {
   // FlutterStatusbarcolor.setStatusBarColor(Colors.blue);
    //FlutterStatusbarcolor.setNavigationBarColor(Colors.blue);
    ScrollController controller = ScrollController();
    var body = SingleChildScrollView(
      child: Center(
        child: Column(
          children: <Widget>[
            Container(
                height: 600,
                margin: EdgeInsets.all(27),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 5)),
                width: 380,
                child: DraggableScrollbar.rrect(
                    backgroundColor: Colors.lightBlue,
                    labelTextBuilder: (offset) => Text("${offset.floor()}"),
                    controller: controller,
                    child: ListView(
                      controller: controller,
                      children: <Widget>[
                        TextField(
                          controller: MyTextController(),
                          keyboardType: TextInputType.multiline,
                          style: TextStyle(color: Colors.black),
                          maxLines: null,
                          minLines: 30,
                          decoration: InputDecoration(
                              focusColor: Colors.black,
                              hoverColor: Colors.black,
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Write DockerFile Here",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.zero))),
                          onChanged: (value) {
                            print(value);
                          },
                        ),
                      ],
                    ))),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              margin: EdgeInsets.only(top: 0, left: 25, right: 25, bottom: 0),
              child: Container(
                margin: EdgeInsets.all(0),
                height: 50,
                width: 180,
                child: FloatingActionButton(
                    isExtended: true,
                    backgroundColor: Colors.lightBlue,
                    child: Text("Save"),
                    onPressed: null),
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
          backgroundColor: Colors.lightBlue,
          title: Text("Executing Container"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => {Navigator.pop(context)}),
        ),
        body: body,
      ),
    );
  }
}
