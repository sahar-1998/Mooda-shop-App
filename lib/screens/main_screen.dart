import 'package:Modda_shop/screens/bn_screens/favorite_screen.dart';
import 'package:flutter/material.dart';
import 'package:Modda_shop/models/bn_screen.dart';
import 'package:Modda_shop/screens/bn_screens/categories_screen.dart';
import 'package:Modda_shop/screens/bn_screens/home_screen.dart';
import 'package:Modda_shop/screens/bn_screens/profile_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<BnScreen> _bnScreens = <BnScreen>[
    const BnScreen(title: 'Home', widget: Home()),
    const BnScreen(title: 'Categories', widget: CategoriesScreen()),
    const BnScreen(title: 'Favorite', widget: FavouriteScreen()),
    const BnScreen(title: 'Profile', widget: ProfileScreen()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bnScreens[_currentIndex].widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int value) {
          setState(() {
            _currentIndex = value;
          });
        },
        currentIndex: _currentIndex,

        type: BottomNavigationBarType.fixed,

        showSelectedLabels: true,
        showUnselectedLabels: true,

        // backgroundColor: HexColor("#01221D"),
        backgroundColor: Colors.white,
        elevation: 10,

        selectedItemColor: Colors.black,
        selectedIconTheme: const IconThemeData(
          color: Colors.black,
        ),
        selectedFontSize: 14.sp,
        selectedLabelStyle: TextStyle(letterSpacing: 2.sp),

        unselectedItemColor: Colors.grey,
        unselectedIconTheme: IconThemeData(color: Colors.grey.shade700),
        unselectedFontSize: 12,
        unselectedLabelStyle:
            const TextStyle(fontWeight: FontWeight.w300, letterSpacing: 1),

        iconSize: 18,
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.category),
            activeIcon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.favorite),
            activeIcon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.person),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          )
        ],
      ),
    );
  }
}
