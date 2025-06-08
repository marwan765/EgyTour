import 'package:flutter/material.dart';
import 'place.dart';
import 'details_page.dart';

// Home page with place list and category filter
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedCategoryIndex = 0;
  List<Place> filteredPlaces = [];
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> categories = [
    {"title": "Historical Monuments", "icon": Icons.account_balance},
    {"title": "Cultural Sites", "icon": Icons.museum},
    {"title": "Religious Sites", "icon": Icons.church},
    {"title": "Recreational Tourism", "icon": Icons.beach_access},
  ];

  @override
  void initState() {
    super.initState();
    filteredPlaces = List.from(places);
    _searchController.addListener(() {
      _searchPlaces(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterPlaces(int index) {
    setState(() {
      selectedCategoryIndex = index;
      if (index == 0) {
        filteredPlaces = places.where((place) {
          return place.title.toLowerCase().contains(searchQuery.toLowerCase());
        }).toList();
      } else {
        filteredPlaces = places.where((place) {
          bool matchesCategory = false;
          switch (categories[index]["title"]) {
            case "Cultural Sites":
              matchesCategory = place.title.contains('Opera') ||
                  place.title.contains('Library') ||
                  place.title.contains('Museum');
              break;
            case "Religious Sites":
              matchesCategory = place.title.contains('Mosque') ||
                  place.title.contains('Church') ||
                  place.title.contains('Temple') ||
                  place.title.contains('Monastery');
              break;
            case "Recreational Tourism":
              matchesCategory = place.title.contains('Beach') ||
                  place.title.contains('Zoo') ||
                  place.title.contains('Palace');
              break;
            default:
              matchesCategory = false;
          }
          return matchesCategory &&
              place.title.toLowerCase().contains(searchQuery.toLowerCase());
        }).toList();
      }
    });
  }

  void _searchPlaces(String query) {
    setState(() {
      searchQuery = query;
      _filterPlaces(selectedCategoryIndex);
    });
  }


  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search',
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'EgyTour',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 350,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('lib/home_page/images/backPyramids.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 70),
                    _buildSearchBar(),
                    const Spacer(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'The Great Pyramid of Giza',
                              style: TextStyle(
                                color: Colors.orange,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Giza Necropolis',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => _filterPlaces(index),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10.0),
                          decoration: BoxDecoration(
                            color: selectedCategoryIndex == index
                                ? Colors.orange
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                categories[index]["icon"],
                                color: selectedCategoryIndex == index
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                categories[index]["title"],
                                style: TextStyle(
                                  color: selectedCategoryIndex == index
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: filteredPlaces.isEmpty
                    ? const Center(child: Text('No places found'))
                    : ListView.builder(
                  padding: const EdgeInsets.all(10.0),
                  itemCount: filteredPlaces.length,
                  itemBuilder: (context, index) {
                    final place = filteredPlaces[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsPage(place: place),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(vertical: 5.0),
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
                                height: MediaQuery.of(context).size.width * 0.4 * 0.75 + 60,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Center(child: Text('Image not found'));
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
        ],
      ),
    );
  }
}