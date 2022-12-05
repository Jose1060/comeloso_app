import 'package:flutter/material.dart';
import 'package:comeloso_app/utils/ui_helper.dart';
import 'package:comeloso_app/widgets/custom_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VendorCard extends StatelessWidget {
  const VendorCard(
      {Key? key,
      required this.imagePath,
      required this.name,
      required this.rating,
      required this.etiqueta,
      required this.address})
      : super(key: key);

  final String imagePath;
  final String name;
  final String rating;
  final String etiqueta;
  final String address;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: space2x),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              imagePath,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: rw(20)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                name,
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(fontSize: rf(16)),
              ),
              SizedBox(height: rh(5)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CIcons.fromMaterial(
                    icon: Icons.star,
                    semanticLabel: 'rating',
                    size: rf(18),
                    color: const Color(0xffffb740),
                  ),
                  SizedBox(width: rw(5)),
                  Text(
                    rating,
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontSize: rf(14)),
                  ),
                  Text(
                    " * $etiqueta * ",
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: const Color(0xff977f98),
                          fontSize: rf(12),
                        ),
                  ),
                ],
              ),
              SizedBox(height: rh(10)),
              Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(space1x),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xfff7f2f7),
                    ),
                    child: Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.arrowRightToCity,
                          color: Colors.purple.shade200,
                          size: 15,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(address,
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontSize: rf(10),
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xff977f98),
                                    )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: space1x,
                  ),
                  // Text(
                  //   '2.4 km',
                  //   style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  //         color: Colors.grey.shade400,
                  //         fontSize: rf(12),
                  //       ),
                  // ),
                ],
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class FavIcon extends StatelessWidget {
  const FavIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CIcons.fromMaterial(
      icon: Icons.favorite_border,
      semanticLabel: 'Favorite',
      color: Theme.of(context).primaryColorDark,
    );
  }
}
