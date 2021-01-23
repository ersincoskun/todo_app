import 'package:flutter/material.dart';

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
  List<Model> myList=[];

  @override
  void initState() {
    _generateMyList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Todo App",
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () {},
      ),
      body: _myBody(),
    );
  }

  Widget _myBody() {
    return ListView.builder(
      itemBuilder: _listViewBuild,
      itemCount: myList.length,
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

  _generateMyList() {
    for (int i = 0; i < 12; i++) {
      myList.add(Model("$i. title", "$i. description"));
    }
  }
}
