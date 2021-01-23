import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model/model.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  GlobalKey<FormState> myKey = GlobalKey<FormState>();
  String title;
  String description;
  Model myModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Add Todo"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Form(
          key: myKey,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(22, 70, 22, 18),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Todo Title",
                    border: OutlineInputBorder(),
                  ),
                  maxLength: 40,
                  onSaved: (value) => title = value,
                  validator: _commonValidation,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(22, 22, 22, 0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Todo description",
                    border: OutlineInputBorder(),
                  ),
                  maxLength: 120,
                  onSaved: (value) => description = value,
                  validator: _commonValidation,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(130, 50, 130, 0),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  elevation: 5,
                  child: Text(
                    "Add Todo",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    myModel = _saveValues();
                    if (title != null && description != null) {
                      Navigator.pop(context, myModel);
                    }
                  },
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Model _saveValues() {
    if(myKey.currentState.validate()){
      myKey.currentState.save();
      if (title != null && description != null) {
        return Model(title, description,false);
      } else {
        throw Exception("The values are null");
      }
    }
  }

  String _commonValidation(String value) {
    if (value == "") {
      return "The field mustn't be empty";
    }
  }
}
