import 'package:comeloso_app/screen/config_screen/config_screen.dart';
import 'package:comeloso_app/screen/profile_screen/profile_user.dart';
import 'package:comeloso_app/screen/travel_oso/travel_oso.dart';
import 'package:flutter/material.dart';
import 'package:comeloso_app/utils/ui_helper.dart';
import 'package:comeloso_app/data.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../animations/page_transition.dart';
import '../../../utils/navigation.dart';
import '../../map_screen/travel_tracking_page.dart';

class CategoryListView extends StatefulWidget {
  const CategoryListView({Key? key}) : super(key: key);

  @override
  _CategoryListViewState createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    void handleNavigateMap(BuildContext context) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => TravelTrackingPage()));
    }

    void handleNavigatProfile(BuildContext context) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => ProfileUser()));
    }

    void handleNavigateOso(BuildContext context) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => TravelOso()));
    }

    void handleNavigateConfig(BuildContext context) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => ConfigScreen()));
    }

    return SizedBox(
      height: rh(120),
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: space2x),
        scrollDirection: Axis.horizontal,
        children: [
          GestureDetector(
            onTap: () {
              handleNavigateMap(context);
            },
            child: CategoryItem(
                name: "Mapa",
                backgroundColor: const Color(0xfff2e3db),
                icon: const FaIcon(FontAwesomeIcons.map)),
          ),
          GestureDetector(
            onTap: () {
              handleNavigateOso(context);
            },
            child: CategoryItem(
                name: "Viaje",
                backgroundColor: const Color(0xfff2e3db),
                icon: const FaIcon(FontAwesomeIcons.compass)),
          ),
          GestureDetector(
            onTap: () {
              handleNavigatProfile(context);
            },
            child: CategoryItem(
                name: "Perfil",
                backgroundColor: const Color(0xfff2e3db),
                icon: const FaIcon(FontAwesomeIcons.userAstronaut)),
          ),
          GestureDetector(
            onTap: () {
              handleNavigateConfig(context);
            },
            child: CategoryItem(
                name: "Configuracion",
                backgroundColor: const Color(0xfff2e3db),
                icon: const FaIcon(FontAwesomeIcons.toolbox)),
          )
        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem(
      {Key? key,
      required this.icon,
      required this.name,
      required this.backgroundColor})
      : super(key: key);

  final Widget icon;
  final String name;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: space2x),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: rf(30),
            backgroundColor: backgroundColor,
            child: icon,
          ),
          SizedBox(
            height: rf(space1x),
          ),
          Text(
            name,
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontSize: rf(12),
                ),
          ),
        ],
      ),
    );
  }
}
