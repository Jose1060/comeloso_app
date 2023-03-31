import 'package:flutter/material.dart';

import '../../../utils/ui_helper.dart';
import '../../../widgets/button/buttons.dart';

class ProductItem extends StatelessWidget {
  const ProductItem(
      {Key? key,
      required this.title,
      required this.detail,
      required this.imagePath,
      required this.precio,
      required this.ranking})
      : super(key: key);

  final String imagePath;
  final String title;
  final String detail;
  final double precio;
  final double ranking;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: space2x),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(rf(10)),
            child: SizedBox(
              width: rh(space4x),
              child: AspectRatio(
                aspectRatio: 1,
                child: Image.network(
                  imagePath,
                  // width: rw(space4x),
                  // height: rh(space3x),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(
            width: rw(10),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontSize: rf(14)),
              ),
              SizedBox(
                height: rh(5),
              ),
              SizedBox(
                width: rw(160),
                child: Text(
                  detail,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Colors.grey.shade400, fontSize: rf(10)),
                  maxLines: 2,
                ),
              )
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "S./ ${precio.toString()}",
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(fontSize: rf(12)),
              ),
              SizedBox(height: rh(space2x)),
            ],
          )
        ],
      ),
    );
  }
}
