import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'bottom_nav_bar.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final Map<String, LatLng> cityCenters = {
    "Paris": LatLng(48.8566, 2.3522),
    "Lyon": LatLng(45.7640, 4.8357),
    "Marseille": LatLng(43.2965, 5.3698),
    "Bordeaux": LatLng(44.8378, -0.5792),
  };

  final List<Map<String, dynamic>> bakeries = [
    {"name": "CalmCup Paris 1", "lat": 48.8534, "lng": 2.3488, "city": "Paris"},
    {"name": "CalmCup Paris 2", "lat": 48.8572, "lng": 2.3529, "city": "Paris"},

    {"name": "CalmCup Lyon 1", "lat": 45.7600, "lng": 4.8350, "city": "Lyon"},
    {"name": "CalmCup Lyon 2", "lat": 45.7681, "lng": 4.8336, "city": "Lyon"},

    {"name": "CalmCup Marseille 1", "lat": 43.2950, "lng": 5.3700, "city": "Marseille"},
    {"name": "CalmCup Marseille 2", "lat": 43.3001, "lng": 5.3689, "city": "Marseille"},

    {"name": "CalmCup Bordeaux 1", "lat": 44.8372, "lng": -0.5785, "city": "Bordeaux"},
    {"name": "CalmCup Bordeaux 2", "lat": 44.8400, "lng": -0.5767, "city": "Bordeaux"},
  ];

  String selectedCity = "Paris";
  late LatLng _currentCenter;

  @override
  void initState() {
    super.initState();
    _currentCenter = cityCenters[selectedCity]!;
  }

  void _filterByCity(String city) {
    setState(() {
      selectedCity = city;
      _currentCenter = cityCenters[city]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredBakeries =
    bakeries.where((b) => b["city"] == selectedCity).toList();

    return Scaffold(
      backgroundColor: Color(0xFF251205),
      appBar: AppBar(
        title: Text("Our Bakery Locations"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: cityCenters.keys.map((city) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ElevatedButton(
                      onPressed: () => _filterByCity(city),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedCity == city ? Colors.orange : Colors.grey[700],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      child: Text(city, style: TextStyle(fontSize: 16)),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),


          Expanded(
            child: FlutterMap(
              options: MapOptions(
                center: _currentCenter,
                zoom: 13.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    for (var bakery in filteredBakeries)
                      Marker(
                        point: LatLng(bakery["lat"], bakery["lng"]),
                        width: 40,
                        height: 40,
                        child: Icon(Icons.location_pin, color: Colors.red, size: 40),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
