import 'package:flutter/material.dart';
import 'package:DockerApp/DockerLaunch.dart';


class DokInstall extends StatefulWidget {
  @override
  _DokInstallState createState() => _DokInstallState();
}

Future navigateToSubPage(context) async {
  Navigator.pop(context);
}
class _DokInstallState extends State<DokInstall> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = new TextEditingController();
        var items=['3:18.09.1-3.el7','18.06.3.ce-3.el7','17.12.1.ce-1.el7.centos'];
        
        //items.join('${Commands.name}');
          
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
                      "Installing Docker",
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
                            child: Text("Version   : "),
                          ),
                          Container(
                            height: 35,
                            width: 200,
                            decoration: BoxDecoration(
                                color: Colors.lightBlue,
                                borderRadius: BorderRadius.circular(10)),
                            margin: EdgeInsets.only(left: 20, right: 10),
                            child: TextField(
                              
                              style: TextStyle(color: Colors.black),
                              controller: _controller,
                              decoration: InputDecoration(
                                  filled: true,
                                  suffixIcon: PopupMenuButton<String>(
      icon: const Icon(Icons.arrow_drop_down),
      onSelected: (String value) {
        _controller.text = value;
      },
      itemBuilder: (BuildContext context) {
        return items
            .map<PopupMenuItem<String>>((String value) {
          return new PopupMenuItem(
              child: new Text(value), value: value);
        }).toList();
      },
    ),
                                  fillColor: Colors.white,
                                  hintText: "Docker version",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)))),
                              onChanged: (value) => {Commands.ver1 = value},
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
                          child: Text("Install"),
                          onPressed: ()  {
                            
                          },
                        ),
                      ),
                    )
                  ],
                )
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
          backgroundColor: Colors.lightBlue,
          title: Text("Executing Container"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => {
                navigateToSubPage(context)
                }),
        ),
        body: body,
      ),
    );
  }
}
