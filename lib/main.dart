import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/add_page.dart';

import 'model/model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Todo App",
      home: MyAppHome(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class MyAppHome extends StatefulWidget {
  @override
  _MyAppHomeState createState() => _MyAppHomeState();
}

class _MyAppHomeState extends State<MyAppHome> {
  List<Model> myList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Todo List",
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPage(),
            ),
          ).then((value) {
            setState(() {
              if(value!=null)
              myList.add(value);
            });
          });
        },
      ),
      body: _myBody(),
    );
  }

  Widget _myBody() {
    return Align(
      alignment: Alignment.topCenter,
      child: ListView.builder(
        reverse: true,
        shrinkWrap: true,
        itemBuilder: _listViewBuild,
        itemCount: myList.length,
      ),
    );
  }

  Widget _listViewBuild(context, index) {
    return Dismissible(
      direction: DismissDirection.startToEnd,
      key: Key(
        index.toString(),
      ),
      onDismissed: (direction) {
        setState(() {
          myList.removeAt(index);
        });
      },
      child: ListTile(
        title: Text(myList[index].title),
        subtitle: Text(myList[index].description),
      ),
    );
  }
}
