import 'package:comeloso_app/models/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:comeloso_app/animations/fade_animation.dart';
import 'package:comeloso_app/animations/scale_animation.dart';
import 'package:comeloso_app/animations/slide_animation.dart';
import 'package:comeloso_app/utils/navigation.dart';
import 'package:comeloso_app/utils/size_config.dart';
import 'package:comeloso_app/utils/ui_helper.dart';
import 'package:comeloso_app/widgets/app_bar/custom_app_bar.dart';
import 'package:comeloso_app/widgets/button/buttons.dart';
import 'package:comeloso_app/screen/product_screen/widgets/product_info_text.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key, required this.itemCard, required this.titulo})
      : super(key: key);
  final Carta itemCard;
  final String titulo;

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                onBackTap: _navigateBack,
                showOptions: false,
              ),
              FadeAnimation(
                duration: const Duration(milliseconds: 4550),
                child: Center(
                  child: Text(
                    widget.titulo,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
              SizedBox(
                height: 50 * SizeConfig.heightMultiplier,
                child: Stack(
                  children: [
                    Positioned.fill(
                      top: 0,
                      bottom: 0,
                      left: -180,
                      child: ScaleAnimation(
                        begin: 0,
                        duration: const Duration(milliseconds: 1000),
                        intervalStart: 0.2,
                        curve: Curves.easeOutBack,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Image.network(
                            widget.itemCard.imagen!,
                            width: rw(380),
                          ),
                        ),
                      ),
                    ),

                    //Food Info
                    Positioned.fill(
                      top: rh(40),
                      bottom: 0,
                      right: rw(space4x),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: FadeAnimation(
                          duration: const Duration(milliseconds: 1250),
                          child: ScaleAnimation(
                            intervalStart: 0.4,
                            duration: const Duration(milliseconds: 1250),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                ProductInfoText(
                                  text: 'Calificación',
                                  value: widget.itemCard.ranking!.toString(),
                                ),
                                const ProductInfoText(
                                  text: 'Numero de reseñas',
                                  value: "20 reseñas",
                                ),
                                const ProductInfoText(
                                  text: 'Cantidad',
                                  value: '1 Persona',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: space2x),
                child: FadeAnimation(
                  intervalStart: 0.4,
                  duration: const Duration(milliseconds: 1300),
                  child: SlideAnimation(
                    intervalStart: 0.4,
                    begin: const Offset(0, 80),
                    duration: const Duration(milliseconds: 1300),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.itemCard.nombre!,
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(fontSize: rf(40)),
                        ),
                        Divider(
                          height: 30,
                          thickness: 6,
                          color: Colors.grey.shade400,
                        ),
                        SizedBox(height: rh(space1x)),
                        Text(
                          "S/.${widget.itemCard.precio.toString()}",
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    color: Theme.of(context).primaryColorDark,
                                    fontSize: rf(25),
                                    fontWeight: FontWeight.normal,
                                  ),
                        ),
                        SizedBox(height: rh(space2x)),
                        Text(
                          widget.itemCard.detalle!,
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: rf(18),
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(
              //     horizontal: space2x,
              //     vertical: space5x,
              //   ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: <Widget>[
              //       Container(
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(15),
              //           color: Colors.white,
              //         ),
              //         child: Buttons.icon(
              //           context: context,
              //           icon: Icons.favorite_border,
              //           size: 28,
              //           iconColor: Theme.of(context).primaryColorDark,
              //           top: space2x,
              //           left: space2x,
              //           right: space2x,
              //           bottom: space2x,
              //           semanticLabel: 'Favorite',
              //           onPressed: () {},
              //         ),
              //       ),
              //       SizedBox(width: rw(space2x)),
              //       Expanded(
              //         child: Buttons.flexible(
              //           vPadding: 20,
              //           borderRadius: 15,
              //           context: context,
              //           text: 'Add to Cart',
              //           onPressed: () {},
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
