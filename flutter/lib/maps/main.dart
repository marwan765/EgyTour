import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_compass/flutter_compass.dart';


class Geo extends StatefulWidget {
  const Geo({super.key});

  @override
  State<Geo> createState() => _GeoState();
}

class _GeoState extends State<Geo> {
  CameraPosition cameraPosition = CameraPosition(
    target: LatLng(30.033333, 31.233334),
    zoom: 12,
  );

  StreamSubscription<Position>? positionStream;
  StreamSubscription<CompassEvent>? compassStream;
  BitmapDescriptor? customIcon;
  LatLng? currentLocation;
  double currentHeading = 0;
  bool isHybrid = false;
  GoogleMapController? mapController;

  final List<Marker> cityMarkers = [
    Marker(
      markerId: MarkerId("abu-el-abbas"),
      position: LatLng(31.205766087222127, 29.8822189653093),
    ),
    Marker(
      markerId: MarkerId("abu_haggag"),
      position: LatLng(25.700215804062534, 32.63973545821933),
    ),
    Marker(
      markerId: MarkerId("agiba_beach"),
      position: LatLng(31.414522410643045, 27.006459782512337),
    ),
    Marker(
      markerId: MarkerId("akhenaten"),
      position: LatLng(27.67009090397138, 30.903678297706712),
    ),
    Marker(
      markerId: MarkerId("alex_opera"),
      position: LatLng(31.197428045371048, 29.901543700127466),
    ),
    Marker(
      markerId: MarkerId("amenhotep"),
      position: LatLng(25.721471529688987, 32.60901915160589),
    ),
    Marker(
      markerId: MarkerId("amr Ibn al-aas"),
      position: LatLng(30.010233084838262, 31.233131895946958),
    ),
    Marker(
      markerId: MarkerId("babylon fortress"),
      position: LatLng(30.005797665824225, 31.23000322663354),
    ),
    Marker(
      markerId: MarkerId("baron_palace"),
      position: LatLng(30.086873141078044, 31.330291038278226),
    ),
    Marker(
      markerId: MarkerId("bent_pyramid"),
      position: LatLng(29.791186102334816, 31.209726529818756),
    ),
    Marker(
      markerId: MarkerId("bib_alex"),
      position: LatLng(31.209132579054884, 29.909115780652836),
    ),
    Marker(
      markerId: MarkerId("bust of ramesses"),
      position: LatLng(29.849591408005814, 31.254233419759487),
    ),
    Marker(
      markerId: MarkerId("cairo tower"),
      position: LatLng(30.046123669002018, 31.22437389779936),
    ),
    Marker(
      markerId: MarkerId("citadel_of_qaitbay"),
      position: LatLng(31.214122191233987, 29.88562078065302),
    ),
    Marker(
      markerId: MarkerId("colossi_of_memnon"),
      position: LatLng(25.720640023392587, 32.6105563418152),
    ),
    Marker(
        markerId: MarkerId("deir_el_medina"),
        position: LatLng(25.728275942651702, 32.60140353748585),
    ),
    Marker(
        markerId: MarkerId("egyptian museum tahrir"),
        position: LatLng(30.048520986901142, 31.23366739532158),
    ),
    Marker(
        markerId: MarkerId("egyptian_national_military_museum"),
        position: LatLng(30.0308585978326, 31.262409020458833),
    ),
    Marker(
        markerId: MarkerId("fatimid_cemetery"),
        position: LatLng(24.07793171787177, 32.8916638951012),
    ),
    Marker(
        markerId: MarkerId("gebel_silsila"),
        position: LatLng(24.643642414137627, 32.92984482739142),
    ),
    Marker(
        markerId: MarkerId("giza_zoo"),
        position: LatLng(30.027757874575364, 31.213477135800844),
    ),
    Marker(
        markerId: MarkerId("great hypostyle hall of karnak"),
        position: LatLng(25.718787233189634, 32.658103058373825),
    ),
    Marker(
        markerId: MarkerId("great temple of ramesses"),
        position: LatLng(25.718506874176192, 32.65694434385831),
    ),
    Marker(
        markerId: MarkerId("hanging_church"),
        position: LatLng(30.00557334872685, 31.230265454839518),
    ),
    Marker(
        markerId: MarkerId("high_dam"),
        position: LatLng(23.971098655253, 32.877237708591),
    ),
    Marker(
        markerId: MarkerId("ibn tulun"),
        position: LatLng(30.028983760958333, 31.249509651143022),
    ),
    Marker(
        markerId: MarkerId("luxor_temple"),
        position: LatLng(25.69955469633832, 32.63892974173476),
    ),
    Marker(
        markerId: MarkerId("Tomb of Tutankhamun"),
        position: LatLng(25.740419119709365, 32.601386242055334),
    ),

    Marker(
        markerId: MarkerId("Monastery of St. Simeon"),
        position: LatLng(24.0947705773588, 32.87570719572977),
    ),
    Marker(
        markerId: MarkerId("Montaza Palace"),
        position: LatLng(31.288775901804936, 30.01586284996933),
    ),
    Marker(
        markerId: MarkerId("Dendera Temple of Hathor"),
        position: LatLng(26.142438305359356, 32.67037475717346),
    ),
    Marker(
        markerId: MarkerId("Step Pyramid of Djoser"),
        position: LatLng(29.87137501663826, 31.216732080597886),
    ),
    Marker(
        markerId: MarkerId("Pyramids of Giza"),
        position: LatLng(29.979058224715992, 31.131376845818828),
    ),
    Marker(
        markerId: MarkerId("Dome of Abu Al-Hawa"),
        position: LatLng(24.102017374428804, 32.88911816689429),
    ),
    Marker(
        markerId: MarkerId("ramesseum"),
        position: LatLng(25.69955469633832, 32.63892974173476),
    ),
    Marker(
        markerId: MarkerId("saint_george_church_in_coptic"),
        position: LatLng(30.006277138585652, 31.230704266464706),
    ),
    Marker(
        markerId: MarkerId("sphinx"),
        position: LatLng(29.975318228102235, 31.137587844806816),
    ),
    Marker(
        markerId: MarkerId("statue of ramesses"),
        position: LatLng(29.84988492845427, 31.25579421250417),
    ),
    Marker(
        markerId: MarkerId("statue of tutankhamun with ankhesenamun"),
        position: LatLng(25.740593054382124, 32.6014935258416),
    ),Marker(
        markerId: MarkerId("temple_of_kom_ombo"),
        position: LatLng(24.45237734143784, 32.928442623948975),
    ),Marker(
        markerId: MarkerId("temple_of_seti"),
        position: LatLng(25.786609542946508, 32.61330200167912),
    ),
    Marker(
        markerId: MarkerId("unfinished_obelisk"),
        position: LatLng(24.077142163567125, 32.89555501229193),
    ),

  ];

  getPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      positionStream = Geolocator.getPositionStream().listen(
            (Position position) {
          if (!mounted) return;  // Add this check
          setState(() {
            currentLocation = LatLng(position.latitude, position.longitude);
          });
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _loadCustomMarker();
    getPermission();
    compassStream = FlutterCompass.events?.listen((CompassEvent event) {
      if (!mounted) return;  // Add this check
      setState(() {
        currentHeading = event.heading ?? 0;
      });
    });
  }

  void _loadCustomMarker() async {
    if (customIcon != null) return;  // Add this line to prevent reloading

    // ignore: deprecated_member_use
    customIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(5, 5)),
      'assets/images/arrow.png',
    );
    if (mounted) setState(() {});  // Add this to refresh after load
  }

  @override
  void dispose() {
    positionStream?.cancel();
    compassStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: isHybrid ? MapType.hybrid : MapType.normal,
            initialCameraPosition: cameraPosition,
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
            markers: {
              ...cityMarkers,
              if (currentLocation != null)
                Marker(
                  markerId: MarkerId("current_location"),
                  position: currentLocation!,
                  icon: customIcon ??BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
                  rotation: currentHeading,
                  anchor: Offset(0.5, 0.5),
                ),
            },
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Column(
              children: [
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      isHybrid = !isHybrid;
                    });
                  },
                  child: Icon(Icons.map),
                ),
                SizedBox(height: 10),
                FloatingActionButton(
                  onPressed: () async {
                    Position position = await Geolocator.getCurrentPosition();
                    setState(() {
                      currentLocation =
                          LatLng(position.latitude, position.longitude);
                    });
                    mapController?.animateCamera(
                      CameraUpdate.newLatLng(currentLocation!),
                    );
                  },
                  child: Icon(Icons.my_location),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}