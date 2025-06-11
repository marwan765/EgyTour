import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';


class HotelBookingPage extends StatefulWidget {
  const HotelBookingPage({super.key});

  @override
  State<HotelBookingPage> createState() => _HotelBookingPageState();
}

class _HotelBookingPageState extends State<HotelBookingPage> {
  List<dynamic> _hotels = [];
  bool _isLoading = false;
  String? _errorMessage;
  String? _destinationId;
  String _languageCode = 'en-us';

  final TextEditingController _searchController = TextEditingController();
  DateTime _checkInDate = DateTime.now().add(const Duration(days: 3));
  DateTime _checkOutDate = DateTime.now().add(const Duration(days: 7));
  int _adults = 2;
  int _children = 0;
  int _rooms = 1;
  bool _showFilters = false;

  @override
  void initState() {
    super.initState();
    _searchController.text = 'Cairo';
    _fetchDestinationId().then((_) => _fetchHotels());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchDestinationId() async {
    final query = _searchController.text.trim();
    if (query.isEmpty) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final url = Uri.parse(
          'https://booking-com15.p.rapidapi.com/api/v1/hotels/searchDestination?query=$query');
      final response = await http.get(url, headers: {
        'x-rapidapi-key': "f0839a2ffdmshb944ff42edb1f34p13f35ajsn5f7dc8fc39a2",
        'x-rapidapi-host': 'booking-com15.p.rapidapi.com',
      });

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body) as Map<String, dynamic>;
        if (decodedData['status'] == true) {
          final data = decodedData['data'] as List<dynamic>;
          if (data.isNotEmpty) {
            setState(() {
              _destinationId = data.first['dest_id'].toString();
            });
            return;
          }
        }
      }
      setState(() {
        _errorMessage = 'Location not found';
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error fetching destination: ${e.toString()}';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchHotels() async {
    if (_destinationId == null) {
      await _fetchDestinationId();
      if (_destinationId == null) {
        setState(() {
          _errorMessage = 'Could not determine destination';
          _isLoading = false;
        });
        return;
      }
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final checkIn = DateFormat('yyyy-MM-dd').format(_checkInDate);
      final checkOut = DateFormat('yyyy-MM-dd').format(_checkOutDate);

      final url = Uri.parse(
          'https://booking-com15.p.rapidapi.com/api/v1/hotels/searchHotels?'
              'dest_id=$_destinationId&'
              'search_type=city&'
              'arrival_date=$checkIn&'
              'departure_date=$checkOut&'
              'adults=$_adults&'
              'children_age=${List.filled(_children, 0).join(',')}&'
              'room_qty=$_rooms&'
              'page_number=1&'
              'languagecode=$_languageCode&'
              'currency_code=EGP');

      final response = await http.get(
        url,
        headers: {
          'x-rapidapi-key': "",
          'x-rapidapi-host': 'booking-com15.p.rapidapi.com',
        },
      ).timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body) as Map<String, dynamic>;

        if (decodedData['status'] == false) {
          setState(() {
            _errorMessage = _parseErrorMessage(decodedData['message']);
            _isLoading = false;
          });
          return;
        }

        final data = decodedData['data'] as Map<String, dynamic>? ?? {};
        final hotelsData = data['hotels'] as List<dynamic>? ?? [];

        setState(() {
          _hotels = hotelsData;
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to load hotels (Status: ${response.statusCode})';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  String _parseErrorMessage(dynamic errorData) {
    if (errorData is String) return errorData;
    if (errorData is List) {
      return errorData.map((e) => e['message'] ?? e.toString()).join(', ');
    }
    if (errorData is Map) {
      return errorData['message']?.toString() ?? 'Unknown error';
    }
    return 'Unknown error occurred';
  }

  Widget _buildHotelCard(dynamic hotel) {
    final property = hotel['property'] as Map<String, dynamic>? ?? {};
    final name = property['name']?.toString() ?? 'Unknown Hotel';
    final rating = property['reviewScore']?.toString() ?? 'Not rated';
    final imageUrl = (property['photoUrls'] as List<dynamic>?)?.firstOrNull?.toString() ?? '';

    // Format check-in and check-out dates
    final checkIn = DateFormat('yyyy-MM-dd').format(_checkInDate);
    final checkOut = DateFormat('yyyy-MM-dd').format(_checkOutDate);

    // Construct booking URL with filter parameters
    final baseUrl = property['url']?.toString() ??
        'https://www.booking.com/searchresults.html?ss=${Uri.encodeComponent(_searchController.text)}';

    // Append filter parameters to the URL
    final bookingUrl = Uri.parse(baseUrl).replace(queryParameters: {
      ...Uri.parse(baseUrl).queryParameters,
      'checkin': checkIn,
      'checkout': checkOut,
      'group_adults': _adults.toString(),
      'no_rooms': _rooms.toString(),
      'group_children': _children.toString(),
      'ss': _searchController.text,
    }).toString();

    final priceInfo = property['priceBreakdown'] as Map<String, dynamic>? ?? {};
    final priceValue = (priceInfo['grossPrice']?['value'] as num?) ??
        (priceInfo['allInclusivePrice']?['value'] as num?) ??
        (priceInfo['value'] as num?) ?? 0;
    final currency = priceInfo['grossPrice']?['currency']?.toString() ??
        priceInfo['allInclusivePrice']?['currency']?.toString() ??
        priceInfo['currency']?.toString() ?? 'EGP';

    final price = priceValue != 0
        ? NumberFormat.currency(
      locale: 'en_US',
      symbol: '$currency ',
      decimalDigits: 0,
    ).format(priceValue)
        : 'Price not available';

    return Card(
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          imageUrl.isNotEmpty
              ? Image.network(
            imageUrl,
            height: 150,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              height: 150,
              color: Colors.grey[200],
              child: const Icon(Icons.hotel, size: 50),
            ),
          )
              : Container(
            height: 150,
            color: Colors.grey[200],
            child: const Icon(Icons.hotel, size: 50),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text(rating),
                  ],
                ),
                const SizedBox(height: 4),
                Text('Price: $price'),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => _launchBookingUrl(bookingUrl),
                    child: const Text('BOOK NOW'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchBookingUrl(String url) async {
    try {
      // Ensure URL is valid
      String processedUrl = url.trim();
      if (!processedUrl.startsWith('http://') && !processedUrl.startsWith('https://')) {
        processedUrl = 'https://$processedUrl';
      }

      final uri = Uri.parse(processedUrl);

      // Try launching the URL
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
          webOnlyWindowName: '_blank',
        );
        return;
      }

      // Fallback to Booking.com homepage
      await launchUrl(
        Uri.parse('https://www.booking.com'),
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open booking page: ${e.toString()}')),
      );
    }
  }

  Future<void> _selectDate(BuildContext context, bool isCheckIn) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isCheckIn ? _checkInDate : _checkOutDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        if (isCheckIn) {
          _checkInDate = picked;
          if (_checkOutDate.isBefore(picked.add(const Duration(days: 1)))) {
            _checkOutDate = picked.add(const Duration(days: 1));
          }
        } else {
          _checkOutDate = picked;
        }
      });
    }
  }

  Widget _buildFilters() {
    return Card(
      margin: const EdgeInsets.all(2),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Filter Options', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 16),

            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Location',
                hintText: 'Enter city or hotel name',
                prefixIcon: const Icon(Icons.location_on),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Check-in'),
                      TextButton(
                        onPressed: () => _selectDate(context, true),
                        child: Text(DateFormat('MMM d, yyyy').format(_checkInDate)),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Check-out'),
                      TextButton(
                        onPressed: () => _selectDate(context, false),
                        child: Text(DateFormat('MMM d, yyyy').format(_checkOutDate)),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            const Text('Guests'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Text('Adults'),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: _adults > 1 ? () => setState(() => _adults--) : null,
                        ),
                        Text('$_adults'),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () => setState(() => _adults++),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text('Children'),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: _children > 0 ? () => setState(() => _children--) : null,
                        ),
                        Text('$_children'),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () => setState(() => _children++),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text('Rooms'),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: _rooms > 1 ? () => setState(() => _rooms--) : null,
                        ),
                        Text('$_rooms'),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () => setState(() => _rooms++),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 16),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() => _showFilters = false);
                  _fetchDestinationId().then((_) => _fetchHotels());
                },
                child: const Text('Apply Filters'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search for hotels...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: () => setState(() => _showFilters = !_showFilters),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onSubmitted: (value) {
              _fetchDestinationId().then((_) => _fetchHotels());
            },
          ),
        ),

        if (_showFilters) _buildFilters(),

        Expanded(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _errorMessage != null
              ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(_errorMessage!),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _fetchHotels,
                  child: const Text('Retry'),
                ),
              ],
            ),
          )
              : _hotels.isEmpty
              ? const Center(child: Text('No hotels found'))
              : RefreshIndicator(
            onRefresh: _fetchHotels,
            child: ListView.builder(
              itemCount: _hotels.length,
              itemBuilder: (context, index) => _buildHotelCard(_hotels[index]),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotel Booking'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchHotels,
          ),
        ],
      ),
      body: _buildBody(),
    );
  }
}
