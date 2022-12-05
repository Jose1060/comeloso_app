import 'package:comeloso_app/animations/animations.dart';
import 'package:comeloso_app/data.dart';
import 'package:comeloso_app/models/restaurant.dart';
import 'package:comeloso_app/models/user.dart';
import 'package:comeloso_app/provider/google_sign_in.dart';
import 'package:comeloso_app/screen/map_screen/travel_tracking_page.dart';
import 'package:comeloso_app/screen/travel_oso/tavel_oso_restaurants.dart';
import 'package:comeloso_app/screen/travel_oso/travel_oso_tracking_page.dart';
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
import 'package:rive/rive.dart';

class TravelOso extends StatefulWidget {
  const TravelOso({super.key});

  @override
  State<TravelOso> createState() => _TravelOsoState();
}

class _TravelOsoState extends State<TravelOso> {
  late double _height;
  Future<List<Restaurant>?>? futureRestaurant;
  final _duration = const Duration(milliseconds: 750);
  final _psudoDuration = const Duration(milliseconds: 150);
  late RiveAnimationController _controller;
  LocationData? currentLocation;

  _navigate({required double latitud, required double longitud}) async {
    await _animateContainerFromBottomToTop();

    //push to products screen
    //wait till product is pooped
    // ignore: use_build_context_synchronously
    await Navigation.push(
      context,
      customPageTransition: PageTransition(
        child: TravelOsoTrackingPage(
          destLat: latitud,
          destLong: longitud,
        ),
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
    _isLoading = true;
    Location location = Location();
    final loc = await location.getLocation();
    currentLocation = loc;
    _isLoading = false;
    setState(() {});
  }

  void _togglePlay() =>
      setState(() => _controller.isActive = !_controller.isActive);

  /// Tracks if the animation is playing by whether controller is running
  bool get isPlaying => _controller.isActive;

  bool _isLoading = false;

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
    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
    UserOso globalUser = provider.userOso!;
    _controller = SimpleAnimation('active', autoplay: false);
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void handleNavigatMap(
        {required BuildContext context,
        required double latitud,
        required double longitud}) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => TravelOsoTrackingPage(
                destLat: latitud,
                destLong: longitud,
              )));
    }

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
                  onPressed: _isLoading
                      ? null
                      : () async {
                          _togglePlay;
                          getCurrentLocation();
                          futureRestaurant =
                              RemoteService().getRestaurantsCercaPOST(
                            lat: currentLocation!.latitude!,
                            // * lat: -16.36657,
                            long: currentLocation!.longitude!,
                            // * long: -71.5122104,
                            etiquetas: globalUser.preferencias!,
                            // * etiquetas: ["Comida Peruana"],
                          );
                        },
                  child: currentLocation == null
                      ? CircularProgressIndicator()
                      : SizedBox(
                          height: 155,
                          width: 155,
                          child: RiveAnimation.asset(
                            artboard: "compass",
                            'lib/assets/rive/travel_icon.riv',
                            // Update the play state when the widget's initialized
                            onInit: (_) => setState(() {}),
                            controllers: [_controller],
                            fit: BoxFit.cover,
                          ),
                        )),
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
                          print("hay datos");
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
                                onTap: () {
                                  handleNavigatMap(
                                      context: context,
                                      latitud: rest.latitud!,
                                      longitud: rest.longitud!);
                                },
                                child: RestaurantOsoItem(
                                  imagePath: rest.imagen!,
                                  title: rest.nombre!,
                                  detail: rest.descripcion ?? "Nada",
                                  address: rest.direccion!,
                                ),
                              );
                            },
                          );
                        } else if (restaurantsSnap.hasError) {
                          return Center(
                            child: Text(restaurantsSnap.error.toString()),
                          );
                        } else if (restaurantsSnap.hasData == false) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Presiona el boton para empezar la busqueda, las recomendaciones apareceran debajo",
                              textAlign: TextAlign.center,
                            ),
                          );
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
