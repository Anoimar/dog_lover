import 'package:doglover/data/repository/account_repository.dart';
import 'package:doglover/screens/account_screen.dart';
import 'package:doglover/screens/breed_groups_screen.dart';
import 'package:doglover/screens/favourites_screen.dart';
import 'package:doglover/screens/info_screen.dart';
import 'package:doglover/screens/login_screen.dart';
import 'package:doglover/styles.dart';
import 'package:doglover/widgets/bottomnavigation/bottom_navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HostScreen extends StatefulWidget {
  static const String id = '/';

  @override
  _HostScreenState createState() => _HostScreenState();
}

class _HostScreenState extends State<HostScreen> {
  @override
  Widget build(BuildContext context) {
    var bottomNavigationProvider =
        Provider.of<BottomNavigationBarProvider>(context);
    var currentTab = [
      BreedGroupsScreen(),
      FavouriteScreen(),
      AccountScreen(
        onLogOff: () {
          bottomNavigationProvider.currentIndex = 0;
        },
      ),
      InfoScreen(),
    ];
    var accountRepository = Provider.of<AccountRepository>(context);
    return Scaffold(
      body: currentTab[bottomNavigationProvider.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Styles.quincy,
        currentIndex: bottomNavigationProvider.currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          bottomBarTapped(accountRepository, bottomNavigationProvider, index);
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 30), title: Text('')),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite, size: 30), title: Text('')),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 30), title: Text('')),
          BottomNavigationBarItem(
              icon: Icon(Icons.info, size: 30), title: Text('')),
        ],
      ),
    );
  }

  bottomBarTapped(AccountRepository accountRepository,
      BottomNavigationBarProvider bottomNavigationBarProvider, int index) {
    var isLogged = accountRepository.isLogged();
    if (isLogged || (index != 2)) {
      bottomNavigationBarProvider.currentIndex = index;
    } else {
      Navigator.pushNamed(context, LoginScreen.id);
    }
  }
}
