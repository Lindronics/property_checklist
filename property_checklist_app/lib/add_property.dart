import 'package:flutter/material.dart';
import 'package:property_checklist_app/data/storage_adapter.dart';

import 'data/property.dart';

class AddPropertyPage extends StatefulWidget {
  AddPropertyPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AddPropertyPageState createState() => _AddPropertyPageState();
}

class _AddPropertyPageState extends State<AddPropertyPage> {
  void addProperty() {
    Property newProperty = Property("asdf");
    Navigator.pop(context, newProperty);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Name"),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: addProperty,
        tooltip: 'Add property',
        label: Text("Finish"),
        icon: Icon(Icons.check),
      ),
    ));
  }
}
