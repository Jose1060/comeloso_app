import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comeloso_app/animations/animations.dart';
import 'package:comeloso_app/animations/slide_animation.dart';
import 'package:comeloso_app/data.dart';
import 'package:comeloso_app/models/restaurant.dart';
import 'package:comeloso_app/models/user.dart';
import 'package:comeloso_app/provider/google_sign_in.dart';
import 'package:comeloso_app/screen/home_screen/widgets/category_list_view.dart';
import 'package:comeloso_app/screen/home_screen/widgets/clipped_container.dart';
import 'package:comeloso_app/screen/home_screen/widgets/vendor_card.dart';
import 'package:comeloso_app/screen/map_screen/travel_tracking_page.dart';
import 'package:comeloso_app/screen/vendor_screen/vendor_screen.dart';
import 'package:comeloso_app/services/remote_services.dart';
import 'package:comeloso_app/utils/navigation.dart';
import 'package:comeloso_app/utils/ui_helper.dart';
import 'package:comeloso_app/widgets/custom_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  late double _height;

  final _duration = const Duration(milliseconds: 1750);
  final _psudoDuration = const Duration(milliseconds: 150);

  _navigate(Restaurant rest) async {
    //Animate screen container from bottom to top
    await _animateContainerFromBottomToTop();

    await Navigation.push(
      context,
      customPageTransition: PageTransition(
        child: VendorScreen(
          restaunrant: rest,
        ),
        type: PageTransitionType.fadeIn,
      ),
    );

    await _animateContainerFromTopToBottom();
  }

  _navigateMap() async {
    //Animate screen container from bottom to top
    await _animateContainerFromBottomToTop();

    await Navigation.push(
      context,
      customPageTransition: PageTransition(
        child: const TravelTrackingPage(),
        type: PageTransitionType.fadeIn,
      ),
    );

    await _animateContainerFromTopToBottom();
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    //Default height
    _height = 0;
    setState(() {});

    //Animate Container from Top to bottom
    Timer(const Duration(milliseconds: 50), () {
      _animateContainerFromTopToBottom();
    });
  }

  List<Restaurant>? restaurants;
  var isLoaded = false;

  getData() async {
    restaurants = await RemoteService().getRestaurants();
    if (restaurants != null) {
      setState(() {
        isLoaded = true;
        print("$isLoaded data ---> $restaurants");
      });
    }
  }

  @override
  void initState() {
    getData();
  }

  @override
  Widget build(BuildContext context) {
    void handleNavigate(BuildContext context, Restaurant rest) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => VendorScreen(
          restaunrant: rest,
        ),
      ));
    }

    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SlideAnimation(
        begin: const Offset(0, 400),
        duration: _duration,
        child: AnimatedContainer(
          height: _height,
          duration: _duration,
          padding: EdgeInsets.only(bottom: rh(20)),
          curve: Curves.fastOutSlowIn,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid.toString())
                .snapshots(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasData && snapshot.data!.exists) {
                final userData = snapshot.data!;
                final userDataOso = UserOso.fromDocumentSnapshot(userData);
                provider.userOso = userDataOso;
                UserOso globalUser = provider.userOso!;
                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomAppBar(
                        hasBackButton: false,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: space2x),
                        child: RichText(
                          text: TextSpan(
                            text: "Hola, ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    fontSize: rf(24),
                                    fontWeight: FontWeight.normal),
                            children: <TextSpan>[
                              TextSpan(
                                text: globalUser.nombre!.split(' ').first,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                      fontSize: rf(24),
                                    ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: space2x),
                        child: Text(
                          "Pasos realizados ${userDataOso.puntos}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontSize: rf(12), height: 1.5),
                        ),
                      ),
                      SizedBox(height: rh(20)),
                      ClippedContainer(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        child: const CategoryListView(), //! Aca esta la vaina
                      ),
                      SizedBox(
                        height: rh(space5x),
                      ),
                      FadeAnimation(
                        intervalStart: 0.4,
                        duration: const Duration(milliseconds: 2250),
                        child: SlideAnimation(
                          begin: const Offset(0, 100),
                          intervalStart: 0.4,
                          duration: const Duration(milliseconds: 2250),
                          child: FutureBuilder(
                              future: RemoteService().getRestaurants(),
                              builder: (BuildContext context, restaurantsSnap) {
                                //final restaurants =
                                //Restaurant.fromJson(snapshot.data!.data()!);

                                if (restaurantsSnap.hasData) {
                                  return ListView.separated(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: restaurantsSnap.data!.length,
                                    scrollDirection: Axis.vertical,
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
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      var rest = restaurantsSnap.data![index];
                                      print("Hola 🐻‍❄️$rest");
                                      return GestureDetector(
                                          onTap: () {
                                            handleNavigate(context, rest);
                                          },
                                          child: VendorCard(
                                            imagePath: rest.imagen!,
                                            name: rest.nombre!,
                                            rating: rest.promedio!.toString(),
                                          ));
                                    },
                                  );
                                } else if (restaurantsSnap.hasError) {
                                  return Center(
                                    child: Text(snapshot.error.toString()),
                                  );
                                } else if (restaurantsSnap.hasData == false) {
                                  print("no hay datos");
                                  return const SizedBox(
                                    height: 300,
                                    child: Center(
                                        child: Text(
                                      "No hay restaurantes :,v",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 40),
                                    )),
                                  );
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              }),
                        ),
                      )
                    ],
                  ),
                );
              }
              return Center(
                child: Text(
                  "Hola",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: rf(12), height: 1.5),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
