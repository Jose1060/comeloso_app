import 'dart:async';

import 'package:comeloso_app/animations/animations.dart';
import 'package:comeloso_app/constants/map.dart';
import 'package:comeloso_app/constants/ui_constants.dart';
import 'package:comeloso_app/models/restaurant.dart';
import 'package:comeloso_app/screen/home_screen/widgets/clipped_container.dart';
import 'package:comeloso_app/screen/product_screen/product_screen.dart';
import 'package:comeloso_app/screen/vendor_screen/vendor_screen.dart';
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

class TravelOsoTrackingPage extends StatefulWidget {
  const TravelOsoTrackingPage(
      {super.key,
      required this.destLong,
      required this.destLat,
      required this.restaurante});
  final double destLong;
  final double destLat;
  final Restaurant restaurante;
  @override
  State<TravelOsoTrackingPage> createState() => _TravelOsoTrackingPageState();
}

class _TravelOsoTrackingPageState extends State<TravelOsoTrackingPage> {
  List<LatLng> polylineCoordinates = [];
  final Completer<GoogleMapController> _controller = Completer();
  late LatLng sourceLocation;
  late LatLng destination;

  LocationData? currentLocation;

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

  void getPolylinesPoints(
      {required double latitudDest,
      required double longitudDest,
      required double latitudSource,
      required double longitudSource}) async {
    print(
        "Latitud dest --> $latitudDest | Longitud dest --> $longitudDest | Latitud Source $latitudSource | Longitud Source $longitudSource");
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        google_api_key,
        PointLatLng(latitudSource, longitudSource),
        PointLatLng(latitudDest, longitudDest));
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
    sourceLocation = LatLng(-16.376027177050197, -71.50814298847764);
    destination = LatLng(widget.destLat, widget.destLong);
    getCurrentLocation();
    getPolylinesPoints(
      latitudDest: destination.latitude,
      longitudDest: destination.longitude,
      longitudSource: sourceLocation.longitude,
      latitudSource: sourceLocation.latitude,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void handleNavigate(BuildContext context, Restaurant rest) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => VendorScreen(
          restaurant: rest,
        ),
      ));
    }

    print(polylineCoordinates);
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
            ? const Center(
                child: RiveAnimation.asset(
                  'lib/assets/rive/delivery.riv',
                ),
              )
            : Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                        target: LatLng(
                            sourceLocation.latitude, sourceLocation.longitude),
                        zoom: 18.5),
                    polylines: {
                      Polyline(
                          polylineId: PolylineId("route"),
                          points: polylineCoordinates,
                          color: primaryColor,
                          width: 6),
                    },
                    markers: {
                      // Marker(
                      //   markerId: MarkerId("currentLocation"),
                      //   position: LatLng(currentLocation!.latitude!,
                      //       currentLocation!.longitude!),
                      // ),
                      Marker(
                        markerId: MarkerId("source"),
                        position: sourceLocation,
                      ),
                      Marker(
                        markerId: MarkerId("destination"),
                        position: destination,
                      ),
                    },
                    onMapCreated: (mapController) {
                      _controller.complete(mapController);
                    },
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onLongPress: () {
                        handleNavigate(context, widget.restaurante);
                      },
                      child: ClippedContainer(
                        backgroundColor: Colors.white,
                        height: rh(150),
                        child: VendorInfoCard(
                          title: widget.restaurante.nombre!,
                          rating: widget.restaurante.promedio!,
                          sideImagePath: widget.restaurante.imagen!,
                          reviews: widget.restaurante.nCalificaciones!,
                          descripcion: widget.restaurante.descripcion ??
                              "Sin descripcion",
                          etiqueta: widget.restaurante.etiquetas![0],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
