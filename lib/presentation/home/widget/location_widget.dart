import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationWidget extends StatefulWidget {
  final Function(String)? onLocationChanged;

  const LocationWidget({
    super.key,
    this.onLocationChanged,
  });

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  String location = "Loading...";

  @override
  void initState() {
    super.initState();
    _loadSavedLocation();
  }

  Future<void> _loadSavedLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedLocation = prefs.getString('last_location');

    if (savedLocation != null) {
      _updateLocation(savedLocation);
    } else {
      _getLastKnownLocation();
    }
  }

  Future<void> _saveLocation(String loc) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('last_location', loc);
  }

  Future<void> _getLastKnownLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _updateLocation("Location services are disabled");
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _updateLocation("Location permissions are denied");
          return;
        }
      }

      Position? position = await Geolocator.getLastKnownPosition();
      if (position != null) {
        await _getAddressFromLatLong(position.latitude, position.longitude);
      } else {
        _updateLocation("No last known location found");
      }
    } catch (e) {
      _updateLocation("Error: $e");
    }
  }

  Future<void> _getAddressFromLatLong(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude,
        longitude,
      );
      Placemark place = placemarks[0];

      String newLocation = "${place.locality}, ${place.country}";
      await _saveLocation(newLocation);
      _updateLocation(newLocation);
    } catch (e) {
      _updateLocation("Failed to get address");
    }
  }

  void _updateLocation(String newLocation) {
    setState(() {
      location = newLocation;
    });
    widget.onLocationChanged?.call(newLocation);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.location_on_outlined),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            location,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}