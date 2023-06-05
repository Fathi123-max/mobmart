import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:shopzler/core/viewmodel/control_viewmodel.dart';
import 'package:shopzler/view/checkout_view.dart';

import '../core/services/location_servises.dart';

class GetLocation extends StatefulWidget {
  @override
  _GetLocationState createState() => _GetLocationState();
}

class _GetLocationState extends State<GetLocation> {
  var locationService = LocationService();
  bool location = false;
  Position? _currentPosition;
  @override
  void initState() {
    super.initState();
    _handleLocationPermission();
    _getCurrentPosition();
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        location = true;
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    print("${_currentPosition?.latitude} + *****************");
    return Scaffold(
        body: location
            ? OpenStreetMapSearchAndPick(
                center: LatLong(_currentPosition?.latitude ?? 50,
                    _currentPosition?.longitude ?? 60),
                buttonColor: Colors.blue,
                buttonText: 'Set Current Location',
                onPicked: (pickedData) {
                  print(pickedData.latLong.latitude);
                  print(pickedData.latLong.longitude);
                  print(pickedData.address);
                  Get.put<ControlViewModel>(ControlViewModel()).words =
                      pickedData.address.split(",");
                  Get.put<ControlViewModel>(ControlViewModel())
                      .words
                      .forEach((element) {
                    print(element);
                  });

                  Get.put<ControlViewModel>(ControlViewModel()).locationLat =
                      pickedData.latLong.latitude;
                  Get.put<ControlViewModel>(ControlViewModel()).locationLag =
                      pickedData.latLong.longitude;
                  Get.off(CheckoutView());
                },
                //  onGetCurrentLocationPressed: _getCurrentPosition(),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }
}
