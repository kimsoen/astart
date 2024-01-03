import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;

  final LatLng startLatLng = const LatLng(-7.352205, 108.222810);
  final LatLng endLatLng = const LatLng(-7.359368, 108.238375);

  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    markers.add(
      Marker(
        markerId: const MarkerId('start'),
        position: startLatLng,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ),
    );
    markers.add(
      Marker(
        markerId: const MarkerId('end'),
        position: endLatLng,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    );
  }

  List<LatLng> calculateFastestRoute(LatLng start, LatLng end) {
    // Implementasi algoritma A* untuk mencari rute tercepat
    // ...
    // Kembalikan daftar koordinat LatLng yang mewakili rute tercepat
    return [
      const LatLng(-7.3546681, 108.2245863),
      const LatLng(-7.3535989, 108.2352727),
      const LatLng(-7.3594113, 108.2381173),
    ];
  }

  List<LatLng> calculateAlternativeRoute(LatLng start, LatLng end) {
    // Implementasi algoritma A* untuk mencari rute alternatif
    // ...
    // Kembalikan daftar koordinat LatLng yang mewakili rute alternatif
    return [
      const LatLng(-7.3546681, 108.2245863),
      const LatLng(-73576443, 1082308939),
      const LatLng(-7.3603895, 108.2361966),
      const LatLng(-7.3593549, 108.2369878),
    ];
  }

  Set<Polyline> polylines = {};

  void showFastestRoute() {
    List<LatLng> fastestRoute = calculateFastestRoute(startLatLng, endLatLng);
    Polyline fastestPolyline = Polyline(
      polylineId: const PolylineId('fastestRoute'),
      points: fastestRoute,
      color: Colors.blue,
      width: 3,
    );
    setState(() {
      polylines.clear();
      polylines.add(fastestPolyline);
    });
  }

  void showAlternativeRoute() {
    List<LatLng> alternativeRoute =
        calculateAlternativeRoute(startLatLng, endLatLng);
    Polyline alternativePolyline = Polyline(
      polylineId: const PolylineId('alternativeRoute'),
      points: alternativeRoute,
      color: Colors.orange,
      width: 3,
    );
    setState(() {
      polylines.clear();
      polylines.add(alternativePolyline);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              onMapCreated: (controller) {
                mapController = controller;
              },
              markers: markers,
              polylines: polylines,
              initialCameraPosition: CameraPosition(
                target: startLatLng,
                zoom: 12,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: showFastestRoute,
                child: const Text('Fastest Route'),
              ),
              ElevatedButton(
                onPressed: showAlternativeRoute,
                child: const Text('Alternative Route'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
