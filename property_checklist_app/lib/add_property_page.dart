import 'package:flutter/material.dart';

import 'data/property.dart';

class AddPropertyPage extends StatefulWidget {
  AddPropertyPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AddPropertyPageState createState() => _AddPropertyPageState();
}

class _AddPropertyPageState extends State<AddPropertyPage> {
  final _formKey = GlobalKey<FormState>();
  var _newProperty = Property();

  void addProperty() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Navigator.pop(context, _newProperty);
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
              child: Padding(
            padding: const EdgeInsets.all(15.0),
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
                      _newProperty.name = value;
                    }),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "Address"),
                    onSaved: (value) {
                      _newProperty.setAddress(value, (p) {});
                    }),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                    keyboardType: TextInputType.url,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "URL"),
                    validator: (value) {
                      if (Uri.tryParse(value) == null) {
                        return 'URL not valid';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _newProperty.posting = Uri(path: value);
                    }),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Price per month"),
                    validator: (value) {
                      try {
                        int.parse(value);
                      } on FormatException {
                        return ('Not a valid number!');
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _newProperty.monthlyRent = int.parse(value);
                    }),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Number of bedrooms"),
                    validator: (value) {
                      try {
                        int.parse(value);
                      } on FormatException {
                        return ('Not a valid number!');
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _newProperty.bedrooms = int.parse(value);
                    }),
              ],
            ),
          )),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: addProperty,
            tooltip: 'Add property',
            label: Text("Create"),
            icon: Icon(Icons.check),
          ),
        ));
  }
}
