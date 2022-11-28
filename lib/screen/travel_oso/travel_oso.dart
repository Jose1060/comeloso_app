import 'package:comeloso_app/animations/animations.dart';
import 'package:comeloso_app/data.dart';
import 'package:comeloso_app/models/restaurant.dart';
import 'package:comeloso_app/models/user.dart';
import 'package:comeloso_app/provider/google_sign_in.dart';
import 'package:comeloso_app/screen/map_screen/travel_tracking_page.dart';
import 'package:comeloso_app/screen/vendor_screen/widgets/product_item_card.dart';
import 'package:comeloso_app/services/remote_services.dart';
import 'package:comeloso_app/utils/navigation.dart';
import 'package:comeloso_app/utils/size_config.dart';
import 'package:comeloso_app/utils/ui_helper.dart';
import 'package:comeloso_app/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class TravelOso extends StatefulWidget {
  const TravelOso({super.key});

  @override
  State<TravelOso> createState() => _TravelOsoState();
}

class _TravelOsoState extends State<TravelOso> {
  late double _height;
  late Future<List<Restaurant>?> futureRestaurant;
  final _duration = const Duration(milliseconds: 750);
  final _psudoDuration = const Duration(milliseconds: 150);
  LocationData? currentLocation;

  _navigate() async {
    await _animateContainerFromBottomToTop();

    //push to products screen
    //wait till product is pooped
    await Navigation.push(
      context,
      customPageTransition: PageTransition(
        child: TravelTrackingPage(),
        type: PageTransitionType.fadeIn,
      ),
    );

    await _animateContainerFromTopToBottom();
  }

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

  void getCurrentLocation() async {
    Location location = Location();
    final loc = await location.getLocation();
    currentLocation = loc;

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
    futureRestaurant = RemoteService().getRestaurantsCerca(
      //lat: currentLocation!.latitude!,
      lat: -9999999.9,
      //long: currentLocation!.longitude!,
      long: -9999999.9,
      //etiquetas: globalUser.preferencias!,
      etiquetas: ["Nada"],
    );
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
    UserOso globalUser = provider.userOso!;
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: [
                  Positioned(
                    child: CustomAppBar(
                      onBackTap: _navigateBack,
                      showOptions: false,
                    ),
                  ),
                ],
              ),
              MaterialButton(
                elevation: 20,
                height: rh(200),
                minWidth: rh(200),
                color: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                  side: BorderSide(color: Theme.of(context).primaryColor),
                ),
                onPressed: () async {
                  getCurrentLocation();
                  futureRestaurant = RemoteService().getRestaurantsCerca(
                    //lat: currentLocation!.latitude!,
                    lat: -16.36657,
                    //long: currentLocation!.longitude!,
                    long: -71.5122104,
                    //etiquetas: globalUser.preferencias!,
                    etiquetas: ["Comida Peruana"],
                  );
                },
                child: currentLocation == null
                    ? CircularProgressIndicator()
                    : FaIcon(
                        FontAwesomeIcons.compass,
                        color: Colors.white,
                        size: rh(120),
                      ),
              ),
              SizedBox(height: rh(space5x)),
              FadeAnimation(
                intervalStart: 0.4,
                duration: const Duration(milliseconds: 1250),
                child: SlideAnimation(
                  begin: const Offset(0, 100),
                  intervalStart: 0.4,
                  duration: const Duration(milliseconds: 1250),
                  child: FutureBuilder(
                      future: futureRestaurant,
                      builder: (BuildContext context, restaurantsSnap) {
                        if (restaurantsSnap.hasData) {
                          return ListView.separated(
                            itemCount: restaurantsSnap.data!.length,
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Divider(
                                height: rh(space4x),
                                endIndent: rw(20),
                                indent: rw(20),
                              );
                            },
                            itemBuilder: (BuildContext context, int index) {
                              var rest = restaurantsSnap.data![index];

                              return GestureDetector(
                                onTap: _navigate,
                                child: ProductItem(
                                  imagePath: rest.imagen!,
                                  title: rest.nombre!,
                                  detail: rest.descripcion!,
                                ),
                              );
                            },
                          );
                        } else if (restaurantsSnap.hasError) {
                          return Center(
                            child: Text(restaurantsSnap.error.toString()),
                          );
                        } else if (restaurantsSnap.hasData == false) {
                          return Text("Presiona el boton :v");
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
