import 'package:flutter/material.dart';
import './Model/Data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<Data>> getAllData() async {
    var api = "https://jsonplaceholder.typicode.com/photos";

    var data = await http.get(api);

    var jsonData = jsonDecode(data.body);

    List<Data> listOf = [];

    for (var i in jsonData) {
      Data data = new Data(i["id"], i["title"], i["url"], i["thumbnailUrl"]);
      listOf.add(data);
    }

    return listOf;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Weather App"),
        backgroundColor: Colors.deepOrange,
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.search),
              onPressed: () => debugPrint("search")),
          new IconButton(
              icon: new Icon(Icons.add), onPressed: () => debugPrint("add"))
        ],
      ),
      drawer: new Drawer(
          child: new ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: new Text("Hasan Karlı"),
            accountEmail: new Text("karlihasann@gmail.com"),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          new ListTile(
            title: new Text("First Page"),
            leading: new Icon(
              Icons.search,
              color: Colors.yellow,
            ),
            onTap: () => Navigator.of(context).pop(),
          ),
          new ListTile(
            title: new Text("Second Page"),
            leading: new Icon(Icons.add, color: Colors.red),
            onTap: () => Navigator.of(context).pop(),
          ),
          new ListTile(
            title: new Text("Third Page"),
            leading: new Icon(Icons.title, color: Colors.purple),
            onTap: () => Navigator.of(context).pop(),
          ),
          new ListTile(
            title: new Text("Fourth Page"),
            leading: new Icon(Icons.list, color: Colors.green),
            onTap: () => Navigator.of(context).pop(),
          ),
          new Divider(
            height: 5.0,
          ),
          new ListTile(
            title: new Text("Close"),
            leading: new Icon(Icons.close, color: Colors.red),
            onTap: () => Navigator.of(context).pop(),
          ),
        ],
      )),
    );
  }
}
