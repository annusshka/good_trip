import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latlong2/latlong.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({
    super.key,
    required this.latLng,
  });

  final LatLng latLng;

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late final MapController _mapController;

  @override
  void initState() {
    _mapController = MapController();
    super.initState();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  Marker _getMarker() {
    return Marker(
      point: widget.latLng,
      child: SvgPicture.asset('assets/svg/location.svg'),
      width: 50,
      height: 50,
      alignment: Alignment.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: widget.latLng,
        initialZoom: 15.0,
        maxZoom: 17.0,
        minZoom: 1.0,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.flutter_map_example',
        ),
        MarkerLayer(
          markers: [_getMarker()],
        ),
      ],
    );
  }
}
