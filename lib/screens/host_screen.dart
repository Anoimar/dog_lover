import 'package:doglover/screens/account_screen.dart';
import 'package:doglover/screens/breed_groups_screen.dart';
import 'package:doglover/screens/favourites_screen.dart';
import 'package:doglover/widgets/bottomnavigation/bottom_navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HostScreen extends StatefulWidget {
  static const String id = '/';

  @override
  _HostScreenState createState() => _HostScreenState();
}

class _HostScreenState extends State<HostScreen> {
  var currentTab = [BreedGroupsScreen(), FavouriteScreen(), AccountScreen()];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BottomNavigationBarProvider>(context);
    return Scaffold(
      body: currentTab[provider.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: provider.currentIndex,
        onTap: (index) {
          provider.currentIndex = index;
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 30), title: Text('')),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite, size: 30), title: Text('')),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 30), title: Text('')),
        ],
      ),
    );
  }
}
