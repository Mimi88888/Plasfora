import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../widgets/navBar.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _SearchHeader extends StatelessWidget {
  const _SearchHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 12,
            spreadRadius: 4,
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.blue, size: 28),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher cliniques à Tunisie...',
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                hintStyle: TextStyle(color: Colors.grey[600]),
              ),
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue[700],
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.tune, color: Colors.white, size: 24),
          ),
        ],
      ),
    );
  }
}

class _MapPageState extends State<MapPage> {
  final LatLng _tunisiaCenter = const LatLng(36.8065, 10.1815);
  final List<Marker> _markers = [];
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    _loadMarkers();
  }

  void _loadMarkers() {
    final clinics = [
      {
        'name': 'Clinique Les Berges du Lac',
        'position': const LatLng(36.8381, 10.2417),
        'type': 'clinic',
      },
      {
        'name': 'Cabinet Dr. Ahmed',
        'position': const LatLng(36.8008, 10.1802),
        'type': 'doctor',
      },
      {
        'name': 'Polyclinique Ennasr',
        'position': const LatLng(36.8516, 10.2189),
        'type': 'clinic',
      },
      {
        'name': 'Cabinet Dr. Mariem',
        'position': const LatLng(36.7942, 10.1738),
        'type': 'doctor',
      },
    ];

    setState(() {
      _markers.addAll(
        clinics.map((clinic) {
          final color = clinic['type'] == 'clinic' ? Colors.blue : Colors.pink;
          final icon = clinic['type'] == 'clinic'
              ? Icons.local_hospital
              : Icons.person_pin_circle;

          return Marker(
            width: 50,
            height: 50,
            point: clinic['position'] as LatLng,
            builder: (ctx) => GestureDetector(
              onTap: () {
                _mapController.move(clinic['position'] as LatLng, 15);
              },
              child: Tooltip(
                message: clinic['name'] as String,
                child: Icon(icon, color: color, size: 40),
              ),
            ),
          );
        }).toList(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: _tunisiaCenter,
              zoom: 12.0,
              interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://tiles.stadiamaps.com/tiles/alidade_smooth/{z}/{x}/{y}{r}.png',
                userAgentPackageName: 'com.example.plasfora_app',
                subdomains: const ['a', 'b', 'c'],
              ),
              MarkerLayer(markers: _markers),
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 20,
            right: 20,
            child: const _SearchHeader(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/profile'),
        backgroundColor: Colors.blue[700],
        child: const Icon(Icons.person, size: 30),
      ),
    );
  }
}
