import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:graduation_project_3/home_page/details_page.dart';
import 'package:graduation_project_3/home_page/place.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

late Interpreter _interpreter;
List<String> labels = [];

// Mean and Std values for normalization (matching MobileNetV2 ImageNet preprocessing)
const double meanR = 0.485;
const double meanG = 0.456;
const double meanB = 0.406;
const double stdR = 0.229;
const double stdG = 0.224;
const double stdB = 0.225;

// Function to pre-resize image to 640x640 to reduce memory usage
img.Image preResizeImage(img.Image image) {
  print('Pre-resizing to 640x640');
  return img.copyResize(image, width: 640, height: 640);
}

// Function to resize image to exact 224x224
img.Image resizeImage(img.Image image) {
  print('Resizing to 224x224');
  return img.copyResize(image, width: 224, height: 224);
}

class Camera_Page extends StatelessWidget {
  const Camera_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CameraScreen(),
    );
  }
}

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  late Future<void> _initializeControllerFuture;
  bool _isTakingPicture = false;
  bool _isProcessing = false;
  String result = "";
  String guidanceMessage = "Place the artifact in the frame";

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    loadModel();
  }

  Future<void> loadModel() async {
    print('Loading model');
    try {
      _interpreter = await Interpreter.fromAsset('assets/models/model_with_metadata.tflite');
      print('Model loaded successfully');
      String labelsString = await rootBundle.loadString('assets/models/Labels.txt');
      labels = labelsString.split('\n').where((label) => label.isNotEmpty).toList();
      print("Model Labels loaded: $labels");
    } catch (e) {
      print('Error loading model: $e');
      setState(() => result = "Failed to load model");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to load model: $e")),
      );
    }
  }

  Future<void> _initializeCamera() async {
    print('Initializing camera');
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        print("No cameras available");
        setState(() => result = "No cameras available");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("No cameras available")),
        );
        return;
      }

      _controller = CameraController(
        cameras.first,
        ResolutionPreset.high, // Changed to high for better quality
        enableAudio: false,
      );

      _initializeControllerFuture = _controller!.initialize();
      await _initializeControllerFuture;

      print('Camera initialized');
      setState(() {});
    } catch (e) {
      print("Error initializing camera: $e");
      setState(() => result = "Failed to initialize camera");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to initialize camera: $e")),
      );
    }
  }

  @override
  void dispose() {
    print('Disposing camera and interpreter');
    _controller?.dispose();
    _interpreter.close();
    super.dispose();
  }

  Future<void> runModel(File imgFile) async {
    print('Running model for image: ${imgFile.path}');
    setState(() => _isProcessing = true);

    try {
      // Decode image
      final bytes = await imgFile.readAsBytes();
      print('Image bytes read: ${bytes.length} bytes');
      img.Image? imageInput = img.decodeImage(bytes);
      if (imageInput == null) {
        throw Exception("Failed to decode image");
      }

      // Pre-resize to 640x640
      img.Image preResizedImage = preResizeImage(imageInput);

      // Resize to 224x224
      img.Image processedImage = resizeImage(preResizedImage);

      // Normalize pixel values
      print('Normalizing image');
      var input = List.generate(
        1,
            (i) => List.generate(
          224,
              (j) => List.generate(
            224,
                (k) => List.filled(3, 0.0),
          ),
        ),
      );

      for (int x = 0; x < 224; x++) {
        for (int y = 0; y < 224; y++) {
          var pixel = processedImage.getPixel(y, x);
          input[0][x][y][0] = ((pixel.r / 255.0) - meanR) / stdR;
          input[0][x][y][1] = ((pixel.g / 255.0) - meanG) / stdG;
          input[0][x][y][2] = ((pixel.b / 255.0) - meanB) / stdB;
        }
      }

      // Run the model
      print('Running inference');
      var output = List.filled(1 * labels.length, 0).reshape([1, labels.length]);
      _interpreter.run(input, output);

      // Process the output
      int maxIndex = 0;
      double maxConfidence = 0.0;
      for (int i = 0; i < labels.length; i++) {
        if (output[0][i] > maxConfidence) {
          maxConfidence = output[0][i].toDouble();
          maxIndex = i;
        }
      }

      // Set the result
      double threshold = 0.7;
      setState(() {
        result = maxConfidence >= threshold
            ? "Result: ${labels[maxIndex]} (${(maxConfidence * 100).toStringAsFixed(2)}%)"
            : "Unknown - ${(maxConfidence * 100).toStringAsFixed(2)}%";
      });
    } catch (e) {
      print('Error in runModel: $e');
      setState(() => result = "Error processing image");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error processing image: $e")),
      );
    } finally {
      setState(() => _isProcessing = false);
    }
  }

  Future<void> _captureImage() async {
    if (_isTakingPicture || _controller == null || !_controller!.value.isInitialized) {
      print('Cannot capture: Taking picture=$_isTakingPicture, Controller=${_controller == null}, Initialized=${_controller?.value.isInitialized}');
      setState(() => result = "Camera not ready");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Camera not ready")),
      );
      return;
    }
    setState(() => _isTakingPicture = true);

    try {
      print('Capturing image');
      await _initializeControllerFuture;
      final image = await _controller!.takePicture();
      File imageFile = File(image.path);
      print('Image captured: ${imageFile.path}');

      await runModel(imageFile);
      _navigateToFullScreen(imageFile);
    } catch (e) {
      print('Error capturing image: $e');
      setState(() => result = "Error capturing image");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error capturing image: $e")),
      );
    } finally {
      setState(() => _isTakingPicture = false);
    }
  }

  Future<void> _pickImage() async {
    print('Picking image from gallery');
    try {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);
        print('Image picked: ${imageFile.path}');
        await runModel(imageFile);
        _navigateToFullScreen(imageFile);
      } else {
        print('Image picking cancelled');
        setState(() => result = "Image picking cancelled");
      }
    } catch (e) {
      print('Error picking image: $e');
      setState(() => result = "Error picking image");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error picking image: $e")),
      );
    }
  }

  void _navigateToFullScreen(File image) {
    print('Navigating to full screen with result: $result');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => FullScreenImage(image: image, result: result)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: _controller == null
                ? const Center(child: CircularProgressIndicator())
                : FutureBuilder(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: SizedBox(
                        width: _controller!.value.previewSize!.height,
                        height: _controller!.value.previewSize!.width,
                        child: CameraPreview(_controller!),
                      ),
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          // Add a guiding frame overlay
          Positioned.fill(
            child: IgnorePointer(
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.height * 0.6,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      guidanceMessage,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (_isProcessing) const Center(child: CircularProgressIndicator()),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  heroTag: "gallery",
                  onPressed: _pickImage,
                  backgroundColor: Colors.white,
                  child: const Icon(Icons.photo_library, color: Colors.black),
                ),
                const SizedBox(width: 30),
                FloatingActionButton(
                  heroTag: "camera",
                  onPressed: _captureImage,
                  backgroundColor: Colors.white,
                  child: const Icon(Icons.camera_alt, color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class FullScreenImage extends StatelessWidget {
  final File image;
  final String result;

  const FullScreenImage({super.key, required this.image, required this.result});

  // Extract and normalize artifact name
  String _normalizeArtifactName(String name) {
    String cleaned = name
        .replaceAll(RegExp(r'Result:\s*', caseSensitive: false), '')
        .replaceAll(RegExp(r'\s*\(\d+\.\d+%\)'), '')
        .trim();
    return cleaned.replaceAll('_', ' ').toLowerCase().trim();
  }

  // Display-friendly artifact name (capitalized)
  String _displayArtifactName(String name) {
    String cleaned = _normalizeArtifactName(name);
    return cleaned.split(' ').map((word) {
      if (word.isNotEmpty) {
        return word[0].toUpperCase() + word.substring(1);
      }
      return word;
    }).join(' ');
  }

  // Find Place by matching normalized artifact name
  Place? _findPlaceByTitle(String artifactName) {
    try {
      String normalizedName = _normalizeArtifactName(artifactName);
      print('Searching for: $normalizedName');
      print('Available Place titles: ${places.map((p) => p.title.toLowerCase()).toList()}');
      Place? match = places.firstWhere(
            (place) => place.title.toLowerCase() == normalizedName,
      );
      if (match == null) {
        match = places.firstWhere(
              (place) => place.title.toLowerCase().contains(normalizedName),
        );
      }
      return match;
    } catch (e) {
      print('No matching Place found for: $artifactName');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    String artifactName = _normalizeArtifactName(result);
    String displayName = _displayArtifactName(result);
    Place? matchedPlace = _findPlaceByTitle(artifactName);

    return Scaffold(
      // خلفية متدرجة بدلاً من اللون الأسود المسطح
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF121212), // درجات داكنة متدرجة
              Color(0xFF000000),
            ],
            stops: [0.3, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Full screen image with zoom capability
            Positioned.fill(
              child: InteractiveViewer(
                panEnabled: true,
                minScale: 1.0,
                maxScale: 5.0,
                child: Center(
                  child: Image.file(
                    image,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),

            // Enhanced gradient overlay for better contrast
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.9),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // Bottom sheet with results - تصميم محدث مع تدرجات لونية
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 25, 20, 25),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF2A2A2A).withOpacity(0.95),
                      Color(0xFF1A1A1A).withOpacity(0.98),
                    ],
                  ),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                  border: Border.all(
                    color: Colors.orange.withOpacity(0.3),
                    width: 1.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 25,
                      spreadRadius: 5,
                    ),
                    BoxShadow(
                      color: Colors.orange.withOpacity(0.1),
                      blurRadius: 15,
                      spreadRadius: 3,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title with refined decoration
                    Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF3A3A3A),
                            Color(0xFF2A2A2A),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.orange.withOpacity(0.4),
                          width: 1.0,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 5,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Text(
                        displayName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    const SizedBox(height: 10),

                    if (matchedPlace != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Discover more about this artifact',
                              style: TextStyle(
                                color: Colors.grey[300],
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF3A3A3A),
                              foregroundColor: Colors.orange[200],
                              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: BorderSide(
                                  color: Colors.orange.withOpacity(0.5),
                                  width: 1.5,
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsPage(place: matchedPlace),
                                ),
                              );
                            },
                            child: const Text(
                              'Explore',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            Icon(Icons.info_outline, color: Colors.grey[400], size: 20),
                            const SizedBox(width: 10),
                            Text(
                              'No additional details available',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // Back button with refined styling
            Positioned(
              top: 40,
              left: 20,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF3A3A3A),
                      Color(0xFF2A2A2A),
                    ],
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.orange.withOpacity(0.4),
                    width: 1.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, size: 28),
                  color: Colors.orange[300],
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}