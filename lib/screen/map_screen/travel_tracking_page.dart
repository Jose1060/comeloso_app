import 'dart:async';

import 'package:comeloso_app/animations/animations.dart';
import 'package:comeloso_app/constants/map.dart';
import 'package:comeloso_app/constants/ui_constants.dart';
import 'package:comeloso_app/screen/home_screen/widgets/clipped_container.dart';
import 'package:comeloso_app/screen/product_screen/product_screen.dart';
import 'package:comeloso_app/screen/vendor_screen/widgets/vendor_info_card.dart';
import 'package:comeloso_app/utils/navigation.dart';
import 'package:comeloso_app/utils/size_config.dart';
import 'package:comeloso_app/utils/ui_helper.dart';
import 'package:comeloso_app/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:rive/rive.dart';

class TravelTrackingPage extends StatefulWidget {
  const TravelTrackingPage({super.key});

  @override
  State<TravelTrackingPage> createState() => _TravelTrackingPageState();
}

class _TravelTrackingPageState extends State<TravelTrackingPage> {
  List<LatLng> polylineCoordinates = [];
  final Completer<GoogleMapController> _controller = Completer();
  static const LatLng sourceLocation =
      LatLng(-16.376027177050197, -71.50814298847764);
  static const LatLng destination =
      LatLng(-16.385942810228553, -71.51120962101196);
  LocationData? currentLocation;
  late RiveAnimationController _controllerRive;

  late double _height;

  final _duration = const Duration(milliseconds: 750);
  final _psudoDuration = const Duration(milliseconds: 150);

  _navigateBack() async {
    await _animateContainerFromBottomToTop();

    Navigation.pop(context);
  }

  _animateContainerFromBottomToTop() async {
    //Animate back to default value
    _height = MediaQuery.of(context).padding.top + rh(50);
    setState(() {});

    //Wait till animation is finished
    await Future.delayed(_duration);
  }

  _animateContainerFromTopToBottom() async {
    //Wait
    await Future.delayed(_psudoDuration);

    //Animate from top to bottom
    _height = MediaQuery.of(context).size.height;
    setState(() {});
  }

  void getPolylinesPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        google_api_key,
        PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
        PointLatLng(destination.latitude, destination.longitude));
    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      setState(() {});
    }
  }

  void getCurrentLocation() async {
    Location location = Location();
    final loc = await location.getLocation();
    currentLocation = loc;
    setState(() {});

    // GoogleMapController googleMapController = await _controller.future;
    // location.onLocationChanged.listen((newLoc) {
    //   currentLocation = newLoc;
    //   googleMapController.animateCamera(
    //     CameraUpdate.newCameraPosition(
    //       CameraPosition(
    //         zoom: 19.5,
    //         target: LatLng(newLoc.latitude!, newLoc.longitude!),
    //       ),
    //     ),
    //   );
    // });
    setState(() {});
  }

  void _togglePlay() =>
      setState(() => _controllerRive.isActive = !_controllerRive.isActive);

  /// Tracks if the animation is playing by whether controller is running
  bool get isPlaying => _controllerRive.isActive;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //Default height
    _height = MediaQuery.of(context).padding.top + rh(50);
    setState(() {});
    //Animate Container from Top to bottom
    _animateContainerFromTopToBottom();
  }

  @override
  void initState() {
    _controllerRive = SimpleAnimation('Move', autoplay: true);
    getCurrentLocation();
    getPolylinesPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AnimatedContainer(
        height: _height,
        duration: _duration,
        padding: EdgeInsets.only(bottom: rh(20)),
        curve: Curves.fastOutSlowIn,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: currentLocation == null
            ? Center(
                child: SizedBox(
                  height: 200,
                  width: 150,
                  child: RiveAnimation.asset(
                    'lib/assets/rive/delivery.riv',
                    onInit: (_) => setState(() {}),
                    controllers: [_controllerRive],
                    fit: BoxFit.cover,
                  ),
                ),
              )
            : Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                        target: LatLng(currentLocation!.latitude!,
                            currentLocation!.longitude!),
                        zoom: 13.5),
                    markers: {
                      Marker(
                        markerId: MarkerId("currentLocation"),
                        position: LatLng(currentLocation!.latitude!,
                            currentLocation!.longitude!),
                      ),
                    },
                    onMapCreated: (mapController) {
                      _controller.complete(mapController);
                    },
                  ),
                ],
              ),
      ),
    );
  }
}
