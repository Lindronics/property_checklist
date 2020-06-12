import 'package:flutter/material.dart';

import 'data/property.dart';

class PropertyPage extends StatefulWidget {
  PropertyPage({Key key, this.property}) : super(key: key);

  final Property property;

  @override
  _PropertyPageState createState() => _PropertyPageState();
}

class _PropertyPageState extends State<PropertyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.property.name),
      ),
    );
  }
}
