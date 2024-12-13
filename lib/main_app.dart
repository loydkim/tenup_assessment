import 'package:flutter/material.dart';
import 'package:tenup_project/common/widgets/bottom_navigation_center_circle.dart';
import 'package:tenup_project/dashboard/view/dashboard_page.dart';
import 'package:tenup_project/developer/view/developer_page.dart';
import 'package:tenup_project/favorites/view/my_favorites_page.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with TickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(
                width: 50,
                height: 50,
                child: Image.asset('assets/imgs/10up.jpg')),
            SizedBox(width: 10),
            Text(
              'Restaurant Tour',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ],
        ),
        shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12))),
        automaticallyImplyLeading: false,
        centerTitle: false,
        toolbarHeight: 60,
        elevation: 0,
        foregroundColor: Theme.of(context).primaryColorDark,
      ),
      body: TabBarView(
        controller: _controller,
        children: const [DashboardPage(), MyFavoritesPage(), DeveloperPage()],
      ),
      floatingActionButton:
          BottomNavigationCenterCircle(tabController: _controller),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(18), topLeft: Radius.circular(18)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18.0),
            topRight: Radius.circular(18.0),
          ),
          child: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                  icon: Container(
                    padding: EdgeInsets.fromLTRB(4, 8, 8, 8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                  ),
                  label: ''),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Developer',
              ),
            ],
            currentIndex: _controller.index,
            selectedItemColor: Colors.red[900],
            selectedFontSize: 12,
            unselectedItemColor: Colors.grey[800],
            unselectedFontSize: 12,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _controller.index = index;
    });
  }
}
