import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:latlong2/latlong.dart';

@RoutePage()
class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    required this.mapPoints,
    this.initialZoom = 15.0,
    this.pointSelect,
    this.showAppBar = true,
  });

  final List<Point?> mapPoints;
  final double initialZoom;
  final Function(Point)? pointSelect;
  final bool showAppBar;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late final MapController _mapController;
  LatLng? _selectedPoints;

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

  List<Marker> _getMarker() {
    List<Marker> markers = [];
    for (final Point? point in widget.mapPoints) {
      if (point != null) {
        final latLng = LatLng(point.lat, point.lon);

        markers.add(
          Marker(
            point: latLng,
            child: SvgPicture.asset('assets/svg/location.svg'),
            width: 50,
            height: 50,
            alignment: Alignment.center,
          ),
        );
      }
    }

    if (_selectedPoints != null) {
      markers.add(
        Marker(
          point: _selectedPoints!,
          child: SvgPicture.asset('assets/svg/location.svg'),
          width: 50,
          height: 50,
          alignment: Alignment.center,
        ),
      );
    }

    return markers;
  }

  LatLng _getInitialMarker() {
    if (widget.mapPoints.isNotEmpty) {
      final point = widget.mapPoints[0];
      if (point != null) {
        final latLng = LatLng(point.lat, point.lon);
        return latLng;
      }
    }
    return const LatLng(55.755793, 37.617134);
  }

  @override
  Widget build(BuildContext context) {
    final List<Marker> markers = _getMarker();
    final latLng = _getInitialMarker();

    return Scaffold(
      appBar: widget.showAppBar
          ? AppBar(
              title: const Center(
                child: Text('Карта'),
              ),
            )
          : null,
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: latLng,
          initialZoom: widget.initialZoom,
          maxZoom: 17.0,
          minZoom: 1.0,
          onTap: (tapPosition, point) {
            if (widget.pointSelect != null) {
              final p = Point(lon: point.longitude, lat: point.latitude);
              widget.pointSelect!(p);
              setState(() {
                _selectedPoints = point;
              });
            }
          },
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.flutter_map_example',
          ),
          MarkerLayer(
            markers: markers,
          ),
        ],
      ),
    );
  }
}
