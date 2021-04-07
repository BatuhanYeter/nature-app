import 'package:flutter/material.dart';
import 'package:flutter_appp/screens/home_tabs/activities.dart';
import 'package:flutter_appp/screens/home_tabs/forest.dart';
import 'package:flutter_appp/screens/home_tabs/home_body.dart';
import 'package:flutter_appp/screens/home_tabs/sports.dart';
import 'package:flutter_appp/services/authentication_service.dart';
import 'package:flutter_appp/services/preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Widget> tabs = [HomeBody(), Activities(), Forest(), Sports()];
  String theme = "";

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    // TODO: Theme icon needs to be added into the settings page
    theme = UserPreferences.getTheme() ?? "dark";
  }

  @override
  Widget build(BuildContext context) {
    final AuthenticationService auth = AuthenticationService();
    // final Preferences pref = Preferences();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Nature Calls"),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => {auth.signOut(context)}),
      ),
      drawer: _drawer(context, auth),
      bottomNavigationBar: _bottomNavbar(),
      body: tabs[_selectedIndex],
    );
  }

  BottomNavigationBar _bottomNavbar() {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.calendar),
          label: 'Activities',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.tree),
          label: 'Forest',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.running),
          label: 'Sports',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.teal[400],
      unselectedItemColor: Colors.blueGrey,
      onTap: _onItemTapped,
      type: BottomNavigationBarType.shifting,
    );
  }

  Drawer _drawer(BuildContext context, AuthenticationService auth) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
            ),
            child: Text(
              "Navigate",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: Text("Settings", style: TextStyle(fontSize: 20)),
            leading: Icon(FontAwesomeIcons.cog),
            onTap: () => Navigator.pushNamed(context, "/settings"),
          ),
          ListTile(
            title: Text("Profile", style: TextStyle(fontSize: 20)),
            leading: Icon(FontAwesomeIcons.userEdit),
            onTap: () {},
          ),
          ListTile(
            title: Text("Messages", style: TextStyle(fontSize: 20)),
            leading: Icon(FontAwesomeIcons.envelope),
            onTap: () {},
          ),
          ListTile(
            title: Text("Sign Out", style: TextStyle(fontSize: 20)),
            leading: Icon(FontAwesomeIcons.signOutAlt),
            onTap: () => auth.signOut(context),
          ),
        ],
      ),
    );
  }
}

/*
                IconButton(
                icon: Icon(theme == "dark" ? Icons.brightness_4 : Icons.brightness_2),
              onPressed: () async {
                if (theme == "dark")
                  await UserPreferences.setTheme("light");
                else
                  await UserPreferences.setTheme("dark");
                  })
              */
