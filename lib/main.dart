import 'package:brother_app/db/db.dart';
import 'package:brother_app/pages/checkout_page.dart';
import 'package:brother_app/pages/create_item_page.dart';
import 'package:brother_app/pages/manage_inventory_page.dart';
import 'package:brother_app/providers/checkout_provider.dart';
import 'package:brother_app/util/custom_theme.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => CheckoutProvider()),
    Provider<MyDatabase>(
      create: (context) => MyDatabase(),
      dispose: (context, db) => db.close(),
    )
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: myTheme(),
        initialRoute: "/",
        routes: {
          "/": (_) => MyHomePage(),
          "/create": (BuildContext context) => CreateItemPage(),
          "/scan": (BuildContext context) => BarcodeReader()
        });
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentTab = 1; //initialize to the Manage Inventory screen

  List<TabData> _tabs = [
    TabData(iconData: Icons.add, title: "New Item"),
    TabData(iconData: Icons.folder, title: "Manage Inventory"),
    TabData(iconData: Icons.photo_camera_sharp, title: "Make Sale")
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: _getBody(_currentTab),
          bottomNavigationBar: FancyBottomNavigation(
            initialSelection: 1,
            tabs: _tabs,
            circleColor: Theme.of(context).primaryColor,
            barBackgroundColor: Theme.of(context).primaryColor,
            activeIconColor: Colors.white,
            textColor: Colors.white,
            inactiveIconColor: Colors.white,
            onTabChangedListener: (position) {
              setState(() {
                _currentTab = position;
              });
            },
          )),
    );
  }

  Widget _getBody(int position) {
    switch (position) {
      case 0:
        return CreateItemPage();
      case 1:
        return ManageInventoryPage();
      case 2:
        return BarcodeReader();
      default:
        return ManageInventoryPage();
    }
  }
}
