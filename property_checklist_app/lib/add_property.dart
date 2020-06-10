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
  final _formKey = GlobalKey<FormState>();
  String _name;

  void addProperty() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Property newProperty = Property(_name);
      Navigator.pop(context, newProperty);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
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
                        return 'Please enter a name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _name = value;
                    }),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: addProperty,
            tooltip: 'Add property',
            label: Text("Create"),
            icon: Icon(Icons.check),
          ),
        ));
  }
}
