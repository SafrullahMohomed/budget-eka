import 'package:budget_management/landing.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// This is the type used by the popup menu below.
enum Menu { EditProfile, Logout, itemThree, itemFour }

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const BudgetMain());
}

class BudgetMain extends StatefulWidget {
  const BudgetMain({super.key});

  @override
  State<BudgetMain> createState() => _BudgetMainState();
}

class _BudgetMainState extends State<BudgetMain> {
  String _selectedMenu = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Budget App",
      home: Scaffold(
        appBar: AppBar(
          // adding a profile popup menu
          actions: <Widget>[
            // This button presents popup menu items.
            PopupMenuButton<Menu>(
                padding: EdgeInsets.all(0),
                icon: const Icon(
                  Icons.account_circle,
                  color: Color.fromARGB(255, 190, 194, 194),
                  size: 40,
                ),
                // Callback that sets the selected popup menu item.
                onSelected: (Menu item) {
                  setState(() {
                    _selectedMenu = item.name;
                  });
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
                      const PopupMenuItem<Menu>(
                        value: Menu.EditProfile,
                        child: Text('Edit Profile'),
                      ),
                      const PopupMenuItem<Menu>(
                        value: Menu.Logout,
                        child: Text('Logout'),
                      ),
                      const PopupMenuItem<Menu>(
                        value: Menu.itemThree,
                        child: Text('Item 3'),
                      ),
                      const PopupMenuItem<Menu>(
                        value: Menu.itemFour,
                        child: Text('Item 4'),
                      ),
                    ]),
          ],
          title: const Text('Budget'),
        ),
        body: landing(),

        // adding a drawer
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
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: Text('Item 1'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Item 2'),
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
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
