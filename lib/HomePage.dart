import 'package:flutter/material.dart';
import 'DetailPage.dart';
import 'Model/Data.dart';
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
      body: new ListView(
        children: <Widget>[
          new Container(
            height: 250.0,
            margin: EdgeInsets.all(15.0),
            child: new FutureBuilder(
                future: getAllData(),
                builder: (BuildContext c, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Center(
                      child: new Text("Loading data"),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext c, int index) {
                          return Card(
                            elevation: 10.0,
                            child: new Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                new Image.network(
                                  snapshot.data[index].url,
                                  height: 150.0,
                                  width: 150.0,
                                  fit: BoxFit.cover,
                                ),
                                new SizedBox(
                                  height: 7.0,
                                ),
                                new Container(
                                    margin: EdgeInsets.all(6.0),
                                    height: 50.0,
                                    child: new Row(
                                      children: <Widget>[
                                        new Container(
                                            child: new CircleAvatar(
                                                backgroundColor:
                                                    Colors.lightBlueAccent,
                                                child: new Text(snapshot
                                                    .data[index].id
                                                    .toString()))),
                                        new SizedBox(
                                          width: 6.0,
                                        ),
                                        new Container(
                                          width: 80.0,
                                          child: Text(
                                            snapshot.data[index].title,
                                            maxLines: 1,
                                          ),
                                        )
                                      ],
                                    ))
                              ],
                            ),
                          );
                        });
                  }
                }),
          ),
          new SizedBox(
            height: 7.0,
          ),
          new Container(
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.all(10.0),
              child: new FutureBuilder(
                  future: getAllData(),
                  builder: (BuildContext c, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return Center(child: Text("Loading data"));
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext c, int index) {
                            return Card(
                              elevation: 7.0,
                              child: Container(
                                height: 80.0,
                                child: new Row(
                                  children: <Widget>[
                                    new Expanded(
                                      flex: 1,
                                      child: new Image.network(
                                        snapshot.data[index].url,
                                        height: 100.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 6.0,
                                    ),
                                    new Expanded(
                                        flex: 2,
                                        child: InkWell(
                                            child: new Text(
                                              snapshot.data[index].title,
                                              maxLines: 2,
                                              style: TextStyle(
                                                fontSize: 16.0,
                                              ),
                                            ),
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  new MaterialPageRoute(
                                                      builder: (BuildContext
                                                              c) =>
                                                          Detail(snapshot
                                                              .data[index])));
                                            })),
                                    new Expanded(
                                        flex: 1,
                                        child: Align(
                                            alignment: Alignment.center,
                                            child: CircleAvatar(
                                              child: new Text(snapshot
                                                  .data[index].id
                                                  .toString()),
                                            ))),
                                  ],
                                ),
                              ),
                            );
                          });
                    }
                  }))
        ],
      ),
    );
  }
}
