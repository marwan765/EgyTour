import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'place.dart';
import 'package:graduation_project_3/plan_page/tour_plan_page.dart';

class DetailsPage extends StatefulWidget {
  final Place place;

  const DetailsPage({super.key, required this.place});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late FlutterTts flutterTts;
  bool isSpeaking = false;
  bool isDescriptionExpanded = false;
  List<Place> plannedPlaces = [];

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
    _initTts();
    _loadPlannedPlaces();
  }

  Future<void> _initTts() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);

    flutterTts.setStartHandler(() {
      setState(() {
        isSpeaking = true;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        isSpeaking = false;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        isSpeaking = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error while playing audio: $msg')),
      );
    });

    var engines = await flutterTts.getEngines;
    if (engines.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No TTS engine available on this device')),
      );
    }
  }

  Future<void> _toggleAudio() async {
    if (isSpeaking) {
      await flutterTts.stop();
      setState(() {
        isSpeaking = false;
      });
    } else {
      var result = await flutterTts.speak(widget.place.description);
      if (result == 1) {
        setState(() {
          isSpeaking = true;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to start audio playback')),
        );
      }
    }
  }

  Future<void> _loadPlannedPlaces() async {
    final prefs = await SharedPreferences.getInstance();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final email = user.email;
      final savedPlaces = prefs.getString('plannedPlaces_$email');
      if (savedPlaces != null) {
        final List<dynamic> jsonList = jsonDecode(savedPlaces);
        setState(() {
          plannedPlaces = jsonList.map((json) => Place.fromJson(json)).toList();
        });
      }
    }
  }

  Future<void> _savePlannedPlaces() async {
    final prefs = await SharedPreferences.getInstance();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final email = user.email;
      final jsonList = plannedPlaces.map((place) => place.toJson()).toList();
      await prefs.setString('plannedPlaces_$email', jsonEncode(jsonList));
    }
  }

  Future<void> _addToPlan() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.orange,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      final placeWithDate = widget.place.copyWith(plannedDate: pickedDate);
      bool alreadyExists = plannedPlaces.any(
            (p) =>
        p.title == placeWithDate.title &&
            p.plannedDate == placeWithDate.plannedDate,
      );

      if (!alreadyExists) {
        setState(() {
          plannedPlaces.add(placeWithDate);
        });
        await _savePlannedPlaces(); // حفظ التغييرات في SharedPreferences
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${widget.place.title} added to your plans for ${pickedDate.toString().split(' ')[0]}!',
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${widget.place.title} is already planned for this date!',
            ),
          ),
        );
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TourPlanPage()),
      );
    }
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          widget.place.title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 350,
              decoration: BoxDecoration(
                image: widget.place.imagePath.isNotEmpty
                    ? DecorationImage(
                  image: AssetImage(widget.place.imagePath),
                  fit: BoxFit.cover,
                )
                    : null,
              ),
              child: widget.place.imagePath.isEmpty
                  ? const Center(
                child: Text(
                  'Image not available',
                  style: TextStyle(color: Colors.white),
                ),
              )
                  : null,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.place.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.place.location,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Icon(Icons.description, color: Colors.orange),
                      const SizedBox(width: 8),
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    isDescriptionExpanded
                        ? widget.place.description
                        : '${widget.place.description.substring(0, widget.place.description.length > 400 ? 400 : widget.place.description.length)}...',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isDescriptionExpanded = !isDescriptionExpanded;
                      });
                    },
                    child: Text(
                      isDescriptionExpanded
                          ? 'Hide Full Description'
                          : 'Read Full Description',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.orange,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: _toggleAudio,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: const BoxDecoration(
                            color: Colors.orange,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isSpeaking ? Icons.stop : Icons.play_arrow,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          isSpeaking ? 'Stop Audio' : 'Play Audio Tour',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Divider(color: Colors.grey.withOpacity(0.3)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.photo, color: Colors.orange),
                      const SizedBox(width: 8),
                      const Text(
                        'Images',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 120,
                    child: widget.place.galleryImages.isNotEmpty
                        ? ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.place.galleryImages.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.asset(
                              widget.place.galleryImages[index],
                              width: 150,
                              height: 120,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 150,
                                  height: 120,
                                  color: Colors.grey.withOpacity(0.3),
                                  child: const Center(
                                    child: Text(
                                      'Image not found',
                                      style:
                                      TextStyle(color: Colors.black54),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    )
                        : const Center(
                      child: Text(
                        'No images available',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Divider(color: Colors.grey.withOpacity(0.3)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.access_time, color: Colors.orange),
                      const SizedBox(width: 8),
                      const Text(
                        'Opening Hours',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widget.place.openingHours.isNotEmpty
                        ? widget.place.openingHours.map((hour) {
                      return Padding(
                        padding:
                        const EdgeInsets.symmetric(vertical: 2.0),
                        child: Text(
                          hour,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                      );
                    }).toList()
                        : [
                      const Text(
                        'Not available',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Divider(color: Colors.grey.withOpacity(0.3)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.monetization_on, color: Colors.orange),
                      const SizedBox(width: 8),
                      const Text(
                        'Prices',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widget.place.prices.isNotEmpty
                        ? widget.place.prices.map((price) {
                      return Padding(
                        padding:
                        const EdgeInsets.symmetric(vertical: 2.0),
                        child: Text(
                          price,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                      );
                    }).toList()
                        : [
                      const Text(
                        'Not available',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Divider(color: Colors.grey.withOpacity(0.3)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.info, color: Colors.orange),
                      const SizedBox(width: 8),
                      const Text(
                        'Guidelines for Visitors',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: widget.place.touristTips.isNotEmpty
                          ? widget.place.touristTips.map((tip) {
                        return Padding(
                          padding:
                          const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text(
                            '• $tip',
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                            ),
                          ),
                        );
                      }).toList()
                          : [
                        const Text(
                          'No guidelines available',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        shadowColor: Colors.black,
                        elevation: 6,
                      ),
                      onPressed: _addToPlan,
                      child: const Text('Add to My Plans'),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}