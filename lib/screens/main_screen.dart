import 'dart:async';

import 'package:flutter/material.dart';
import 'package:task/common/localization/app_localization.dart';
import 'package:task/screens/home/home_screen.dart';
import 'package:task/screens/profile/profile_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}
class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  late List<Widget> _children;
  int _navigationBottomIndex=0;
  StreamController _streamControllerIndex = StreamController.broadcast();
  @override
  void initState() {
    _children = [
      HomeScreen(),
      ProfileScreen()
    ];
    _streamControllerIndex.sink.add(_currentIndex);
    super.initState();
  }
  @override
  void dispose() {
    _streamControllerIndex.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
return
  SafeArea(
    child: Scaffold(
    appBar:  AppBar(
      title:  Text(AppLocalizations.of(context: context)?.translate(key: "home_products")??""),
      actions: <Widget>[
        InkWell(
          onTap: () {
            // NavigationHandler.navigateTo(const SearchItemScreenRoute());
          },
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Icon(Icons.shopping_cart),
          ),
        )
      ],
    ),
      body:  StreamBuilder(
        stream: _streamControllerIndex.stream,
        builder: (context, AsyncSnapshot snapshot) {
          _navigationBottomIndex = snapshot.data ?? _currentIndex;
          return IndexedStack(
            index: _navigationBottomIndex,
            children: _children,
          );
          // _children[navigationButtomIndex];
        },
      ),
      bottomNavigationBar:
        StreamBuilder(
        stream: _streamControllerIndex.stream,
        builder: (context,AsyncSnapshot snapshot) {
          _navigationBottomIndex = snapshot.data ?? _currentIndex;
          return BottomNavigationBar(
            onTap: (index)=>_streamControllerIndex.sink.add(index),
            currentIndex: _navigationBottomIndex,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.blue,
            items: _navigationBottomItem(),
          );
        }),
    ));
  }

  List<BottomNavigationBarItem> _navigationBottomItem(){
    List<BottomNavigationBarItem> _navigationBottomBarItem=[
      BottomNavigationBarItem(
        icon: Icon(Icons.home_sharp),
        label: AppLocalizations.of(context: context)
            ?.translate(key: "navigation_label_home"),
      ),
      BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label:AppLocalizations.of(context: context)?.translate(key: "navigation_label_profile"))
    ];

    return _navigationBottomBarItem;
  }
  
}