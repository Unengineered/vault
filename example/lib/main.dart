import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vault/vault.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final saveController = TextEditingController();
  final saveValueController = TextEditingController();
  final getController = TextEditingController();
  final streamController = TextEditingController();
  String getValue = "";
  String streamValue = "";
  final vault = Vault();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vault"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Get", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, ), textAlign: TextAlign.left),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "key"
              ),
              controller: getController,
            ),
          ),
          Text('value: $getValue'),
          TextButton(onPressed: ()async{
            final value = await vault.get(getController.text);
            setState(() {
              getValue = value.toString();
            });
          }, child: Text("Get")),
          Divider(),
          Text("Stream", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, ), textAlign: TextAlign.left),
          StreamBuilder(
            stream: vault.listen(streamValue),
            builder: (context, snapshot){
            return Text("value: ${snapshot.data.toString()}");
          }),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: TextField(
              decoration: InputDecoration(
                  hintText: "key"
              ),
              controller: streamController,
            ),
          ),
          TextButton(onPressed: (){
            setState(() {
              streamValue = streamController.text;
              streamController.clear();
            });
          }, child: Text("Stream")),
          Divider(),
          Text("Save", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, ), textAlign: TextAlign.left),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: TextField(
              decoration: InputDecoration(
                  hintText: "key"
              ),
              controller: saveController,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: TextField(
              decoration: InputDecoration(
                  hintText: "value"
              ),
              controller: saveValueController,
            ),
          ),
          TextButton(onPressed: (){
            vault.save(saveController.text, saveValueController.text);
            saveValueController.clear();
            saveController.clear();
          }, child: Text("Save"))
        ],
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
