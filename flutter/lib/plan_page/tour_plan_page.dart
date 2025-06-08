import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'background.dart';
import 'header.dart';
import 'package:graduation_project_3/home_page/place.dart';
import 'package:graduation_project_3/home_page/details_page.dart';

class TourPlanPage extends StatefulWidget {
  const TourPlanPage({super.key});

  @override
  _TourPlanPageState createState() => _TourPlanPageState();
}

class _TourPlanPageState extends State<TourPlanPage> {
  List<Place> plannedPlaces = [];

  @override
  void initState() {
    super.initState();
    _loadPlannedPlaces();
  }

  // تحميل الأماكن المخطط لها من SharedPreferences
  Future<void> _loadPlannedPlaces() async {
    final prefs = await SharedPreferences.getInstance();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final email = user.email;
      final savedPlaces = prefs.getString('plannedPlaces_$email');
      if (savedPlaces != null) {
        final List<dynamic> jsonList = jsonDecode(savedPlaces);
        setState(() {
          plannedPlaces =
              jsonList.map((json) => Place.fromJson(json)).toList();
        });
      }
    }
  }

  // حفظ الأماكن المخطط لها إلى SharedPreferences
  Future<void> _savePlannedPlaces() async {
    final prefs = await SharedPreferences.getInstance();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final email = user.email;
      final jsonList = plannedPlaces.map((place) => place.toJson()).toList();
      await prefs.setString('plannedPlaces_$email', jsonEncode(jsonList));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Background(),
          SafeArea(
            child: Column(
              children: [
                const Header(),
                Expanded(
                  child: plannedPlaces.isEmpty
                      ? const Center(
                    child: Text(
                      'No places added to your plans yet!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  )
                      : ListView.builder(
                    padding: const EdgeInsets.all(10.0),
                    itemCount: plannedPlaces.length,
                    itemBuilder: (context, index) {
                      final place = plannedPlaces[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailsPage(place: place),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 2,
                          margin:
                          const EdgeInsets.symmetric(vertical: 5.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.asset(
                                  place.imagePath,
                                  width: double.infinity,
                                  height: MediaQuery.of(context).size.width *
                                      0.4 *
                                      0.75 +
                                      60,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (context, error, stackTrace) {
                                    return const Center(
                                        child: Text('Image not found'));
                                  },
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.black,
                                    size: 24,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      plannedPlaces.removeAt(index);
                                    });
                                    _savePlannedPlaces(); // حفظ التغييرات
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            '${place.title} removed from your plans!'),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.9),
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(10.0),
                                      bottomRight: Radius.circular(10.0),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        place.title,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Color(0xFFDAA520),
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        place.location,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFFDAA520),
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      if (place.plannedDate != null) ...[
                                        const SizedBox(height: 4),
                                        Text(
                                          'Planned: ${place.plannedDate!.toString().split(' ')[0]}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFFDAA520),
                                            fontStyle: FontStyle.italic,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}