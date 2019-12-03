import 'package:flutter/material.dart';
import 'Model/Data.dart';

class Detail extends StatefulWidget {

  Data data;

  Detail(this.data);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Page"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: ListView(
        children: <Widget>[
          new Container(
            margin: EdgeInsets.all(10.0),
            child: new Column(
              children: <Widget>[
                new Image.network(
                  widget.data.url,
                  height: 250.0,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  child: new Row(
                    children: <Widget>[
                      new Container(
                        child: CircleAvatar(
                          child: new Text(widget.data.id.toString()),
                        ),
                      ),
                      SizedBox(width: 6.0,),
                      new Container(
                          child: Text(widget.data.title))
                    ],
                  ),
                )
              ],
            ),
          )

        ],
      ),
    );
  }
}
