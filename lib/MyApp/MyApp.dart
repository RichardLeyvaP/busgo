import 'package:BusGo/myApp/GoRouterClass.dart';
import 'package:BusGo/myApp/ThemeDataClass.dart';
import 'package:BusGo/ui/app_bar/AppBarWidget.dart';
import 'package:BusGo/ui/pages/FunPage.dart';
import 'package:BusGo/ui/pages/HomePage/Home/HomePage.dart';
import 'package:BusGo/ui/pages/NotificationsPage.dart';
import 'package:BusGo/ui/pages/Statistics/StatisticsPage.dart';
import 'package:BusGo/ui/pages/ListPage.dart';
import 'package:BusGo/ui/menu_bottom/BottomAppBarWidget.dart';
import 'package:flutter/material.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      theme: themeDataInitial(),
      debugShowCheckedModeBanner: false,
     // home: DashboardPage(),
    );
  }
}

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: 
      AppBarWidget(context),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(), // Evita deslizar entre páginas
        children: [
          HomePage(),
          ListPage(),
          NotificationsPage(),
          StatisticsPage(),
          FunPage(),
        ],
      ),
      bottomNavigationBar: 
      BottomAppBarWidget(_currentIndex,_onItemTapped),
    );
  }
  }
