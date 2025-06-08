import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduation_project_3/camera/Cameras.dart';
import 'package:graduation_project_3/home_page/collection.dart';
import 'package:graduation_project_3/hotel/HotelBookingPage.dart';
import 'package:graduation_project_3/maps/main.dart';
import 'package:graduation_project_3/plan_page/tour_plan_page.dart';


class Homescreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    collection(),
    Geo(),
    Camera_Page(),
    TourPlanPage(), // TourPlanPage includes Header/Background
    HotelBookingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // Directly show the current page
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.amber,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/images/map.png")),
            label: "Explore",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/images/camera.png")),
            label: "Camera",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/images/plane.png")),
            label: "Tour plan",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/images/hotel.png")),
            label: "Hotel",
          ),
        ],
      ),
    );
  }
}

// Other pages (simple content without Header/Background)


class HotelPage extends StatelessWidget {
  const HotelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Hotel Content"));
  }
}