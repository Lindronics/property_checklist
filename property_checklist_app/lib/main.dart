import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:property_checklist_app/add_property_page.dart';
import 'package:property_checklist_app/comparison_page.dart';
import 'package:property_checklist_app/data/storage_adapter.dart';
import 'package:property_checklist_app/feature_manager_page.dart';
import 'package:property_checklist_app/property_list_page.dart';
import 'package:property_checklist_app/property_page.dart';

import 'data/property.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Property Checklist',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.teal,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Property List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  StorageAdapter<Property> properties = ListStorageAdapter<Property>([
    Property(name: "Test", bedrooms: 2, bathrooms: 1, monthlyRent: 2300),
    Property(name: "Test 2", bedrooms: 2, bathrooms: 1, monthlyRent: 2400)
  ]);

  Property _deletedProperty;
  int _selectedIndex = 0;

  addProperty(BuildContext context) async {
    final Property result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddPropertyPage(
                title: "Add property",
              )),
    );

    if (result == null) {
      return;
    }

    setState(() {
      properties.addItem(result);
    });
  }

  deleteProperty(Property property) {
    print("asdf");
    setState(() {
      properties.deleteItem(property);
      _deletedProperty = property;
      // TODO broken for now
      // Scaffold.of(context).showSnackBar(SnackBar(
      //     content: Text("Deleted ${property.name}"),
      //     action: SnackBarAction(
      //       label: "Undo",
      //       onPressed: () {
      //         setState(() {
      //           properties.addItem(_deletedProperty);
      //         });
      //       },
      //     )));
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = <Widget>[
      PropertyListPage(
          properties: properties, itemDeletionCallback: deleteProperty),
      ComparisonPage(),
      FeatureManagerPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _pages[_selectedIndex],
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.teal[200],
              ),
            ),
            ListTile(
              title: Text('Features'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Map'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          addProperty(context);
        },
        label: Text("Add"),
        tooltip: 'Increment',
        icon: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text("Properties")),
            BottomNavigationBarItem(
                icon: Icon(Icons.compare_arrows), title: Text("Compare")),
            BottomNavigationBarItem(
                icon: Icon(Icons.format_list_bulleted),
                title: Text("Features")),
          ]), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
