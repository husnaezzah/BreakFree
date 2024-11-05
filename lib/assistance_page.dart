import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'; // Import for Google Maps
import 'package:geolocator/geolocator.dart'; // For getting the current location
import 'package:http/http.dart' as http; // For API integration
import 'dart:convert'; // To handle JSON data

class AssistancePage extends StatefulWidget {
  @override
  _AssistancePageState createState() => _AssistancePageState();
}

class _AssistancePageState extends State<AssistancePage> {
  late GoogleMapController _mapController;
  Position? _currentPosition;
  List<dynamic> _supportPoints = [];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _currentPosition = position;
      });
      _fetchSupportPoints(position.latitude, position.longitude);
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  Future<void> _fetchSupportPoints(double latitude, double longitude) async {
    final response = await http.get(
      Uri.parse('https://api.example.com/support-points?lat=$latitude&lng=$longitude'),
    );

    if (response.statusCode == 200) {
      setState(() {
        _supportPoints = json.decode(response.body);
      });
    } else {
      print("Error fetching support points: ${response.statusCode}");
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      appBar: AppBar(
        backgroundColor: Colors.purple[100],
        title: Text(
          'BreakFree.',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.chat_bubble_outline),
            onPressed: () {
              // Navigate to chat or support page
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                _currentPosition == null
                    ? Center(child: CircularProgressIndicator())
                    : GoogleMap(
                        onMapCreated: _onMapCreated,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                            _currentPosition!.latitude,
                            _currentPosition!.longitude,
                          ),
                          zoom: 14,
                        ),
                        myLocationEnabled: true,
                      ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: FloatingActionButton(
                    onPressed: _getCurrentLocation,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.refresh, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nearest Support Points',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                ..._supportPoints.map((point) => _buildSupportPointCard(point)).toList(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.purple[100],
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.black,
        onTap: (int index) {
          if (index == 2) {
            Navigator.pushNamed(context, '/profile');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/sos');
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Text(
              'SOS',
              style: TextStyle(
                color: Colors.red,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildSupportPointCard(Map<String, dynamic> point) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(Icons.location_on, color: Colors.purple),
        title: Text(point['name']),
        subtitle: Text('Distance: ${point['distance']}km'),
        trailing: ElevatedButton(
          onPressed: () {
            _mapController.animateCamera(
              CameraUpdate.newLatLng(
                LatLng(point['latitude'], point['longitude']),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple,
            foregroundColor: Colors.white,
          ),
          child: Text('View'),
        ),
      ),
    );
  }
}
