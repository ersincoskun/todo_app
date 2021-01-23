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
  bool checkValue = false;

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
              if (value != null) myList.insert(0, value);
            });
          });
        },
      ),
      body: _myBody(),
    );
  }

  Widget _myBody() {
    return Align(
        child: ReorderableListView(
          onReorder: (oldIndex, newIndex) {
            setState(() {
              if(newIndex>oldIndex){
                newIndex-=1;
              }
              final item=myList.removeAt(oldIndex);
              myList.insert(newIndex, item);
            });
          },
          children: [
            for (Model item in myList)
              Dismissible(
                direction: DismissDirection.startToEnd,
                key: Key(
                  item.title,
                ),
                onDismissed: (direction) {
                  setState(() => myList.remove(item));
                },
                child: item.checkValue == false
                    ? _myListItem(
                    item, Colors.white, Colors.black, ValueKey(item))
                    : _myListItem(
                    item, Colors.green, Colors.white, ValueKey(item)),
              )


          ],
        ));
  }

  Padding _myListItem(Model item, cardColor, textColor, key) {
    return Padding(
      key: key,
      padding: EdgeInsets.fromLTRB(12, 10, 12, 0),
      child: Card(
        key: key,
        color: cardColor,
        child: ListTile(
          key: key,
          leading: Checkbox(
            key: key,
            activeColor: Colors.indigo,
            value: item.checkValue,
            onChanged: (value) {
              setState(
                () {
                  item.checkValue = value;
                  if (value == true) {
                    myList.remove(item);
                    myList.insert(0, item);
                  }
                },
              );
            },
          ),
          title: Text(
            item.title,
            style: TextStyle(
              color: textColor,
            ),
          ),
          subtitle: Text(
            item.description,
            style: TextStyle(
              color: textColor,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Colors.indigo,
          ),
        ),
      ),
    );
  }
}

//item click events
