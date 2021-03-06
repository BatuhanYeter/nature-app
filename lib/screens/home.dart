import 'package:flutter/material.dart';
import 'package:flutter_appp/screens/home_tabs/activities.dart';
import 'package:flutter_appp/screens/home_tabs/forest.dart';
import 'package:flutter_appp/screens/home_tabs/home_body.dart';
import 'package:flutter_appp/screens/home_tabs/sports.dart';
import 'package:flutter_appp/services/authentication_service.dart';
import 'package:flutter_appp/services/preferences.dart';
import 'package:flutter_appp/services/updated_auth.dart';
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
    didChangeDependencies();
    // TODO: Theme icon needs to be added into the settings page
    theme = UserPreferences.getTheme() ?? "dark";
  }

  @override
  Widget build(BuildContext context) {
    final AuthenticationService auth = AuthenticationService();
    final AuthMethods auth_2 = AuthMethods();
    // final Preferences pref = Preferences();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () => {auth_2.signOut(context)}),
        ],
        centerTitle: true,
        title: Text("Nature Calls"),
        leading: IconButton(
          icon: _selectedIndex == 1
              ? Icon(Icons.add)
              : Icon(FontAwesomeIcons.userEdit),
          onPressed: _selectedIndex == 1
              ? () => Navigator.pushNamed(context, '/addEvent')
              : () => Navigator.pushNamed(context, '/profile'),
        )
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
            title: Text("Maps", style: TextStyle(fontSize: 20)),
            leading: Icon(FontAwesomeIcons.map),
            onTap: () => Navigator.pushNamed(context, "/maps"),
          ),
          ListTile(
            title: Text("Profile", style: TextStyle(fontSize: 20)),
            leading: Icon(FontAwesomeIcons.userEdit),
            onTap: () => Navigator.pushNamed(context, "/profile"),
          ),
          ListTile(
            title: Text("Add Event", style: TextStyle(fontSize: 20)),
            leading: Icon(FontAwesomeIcons.calendarPlus),
            onTap: () => Navigator.pushNamed(context, "/addEvent"),
          ),
          ListTile(
            title: Text("My Events", style: TextStyle(fontSize: 20)),
            leading: Icon(FontAwesomeIcons.calendar),
            onTap: () => Navigator.pushNamed(context, "/myEvents"),
          ),
          ListTile(
            title: Text("Friend Requests", style: TextStyle(fontSize: 20)),
            leading: Icon(FontAwesomeIcons.users),
            onTap: () => Navigator.pushNamed(context, "/friendRequest"),
          ),
          ListTile(
            title: Text("Chat", style: TextStyle(fontSize: 20)),
            leading: Icon(FontAwesomeIcons.envelope),
            onTap: () => Navigator.pushNamed(context, "/chat"),
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
