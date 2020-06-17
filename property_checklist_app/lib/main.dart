import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Property Checklist',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Property List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  StorageAdapter<Property> properties = ListStorageAdapter<Property>([
    Property(
        name: "Not Subway Byres Road",
        bedrooms: 2,
        bathrooms: 1,
        monthlyRent: 2300,
        address: "239 Byres Road, Glasgow"),
    Property(
        name: "Not Subway Dumbarton Road",
        bedrooms: 2,
        bathrooms: 1,
        monthlyRent: 2400,
        address: "172 Dumbarton Road, Glasgow")
  ]);

  Set<Marker> _markers = {};

  Property _deletedProperty;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    for (Property property in properties.getItems()) {
      property.setAddress(property.address, addMarker);
    }
  }

  /// Adds a new [Marker] to the [Set] of map markers.
  /// Redraws the page.
  void addMarker(Property property) {
    setState(() => _markers.add(Marker(
        markerId: MarkerId(property.name),
        position: property.location,
        infoWindow: InfoWindow(
            title: property.name,
            snippet: "£${property.monthlyRent}pcm",
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PropertyPage(
                            property: property,
                          )));
            }))));
  }

  /// Launches an [AddPropertyPage].
  /// Adds a new [Property] to [properties] if returned by the [AddPropertyPage].
  void addProperty(BuildContext context) async {
    final Property result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddPropertyPage(
                title: "Add property",
              )),
    );
    if (result != null) {
      setState(() {
        properties.addItem(result);
      });
    }
  }

  /// Deletes a [Property] from [properties].
  /// Displays a [SnackBar] to allow undoing the deletion.
  void deleteProperty(BuildContext context, Property property) {
    print("asdf");
    setState(() {
      properties.deleteItem(property);
      _deletedProperty = property;
      Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Deleted ${property.name}"),
          action: SnackBarAction(
            label: "Undo",
            onPressed: () {
              setState(() {
                properties.addItem(_deletedProperty);
              });
            },
          )));
    });
  }

  @override
  Widget build(BuildContext context) {

    // Pages in bottom navigation bar
    List<Widget> _pages = <Widget>[
      PropertyListPage(
          properties: properties,
          markers: _markers,
          itemDeletionCallback: deleteProperty),
      ComparisonPage(),
      FeatureManagerPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _pages[_selectedIndex],
      drawer: Drawer(
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
              onTap: () {},
            ),
            ListTile(
              title: Text('Map'),
              onTap: () {},
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
          ]),
    );
  }
}
