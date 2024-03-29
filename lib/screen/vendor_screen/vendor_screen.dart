import 'package:comeloso_app/models/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:comeloso_app/animations/animations.dart';
import 'package:comeloso_app/utils/ui_helper.dart';
import 'package:comeloso_app/utils/utils.dart';
import 'package:comeloso_app/widgets/custom_widgets.dart';
import 'package:comeloso_app/data.dart';
import 'package:comeloso_app/screen/home_screen/widgets/clipped_container.dart';
import 'package:comeloso_app/screen/product_screen/product_screen.dart';
import 'package:comeloso_app/screen/vendor_screen/widgets/product_item_card.dart';
import 'package:comeloso_app/screen/vendor_screen/widgets/vendor_info_card.dart';

class VendorScreen extends StatefulWidget {
  const VendorScreen({Key? key, required this.restaurant}) : super(key: key);
  final Restaurant restaurant;

  @override
  _VendorScreenState createState() => _VendorScreenState();
}

class _VendorScreenState extends State<VendorScreen> {
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
    void handleNavigate(BuildContext context, Carta itemCard, String titulo) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => ProductScreen(
          itemCard: itemCard,
          titulo: titulo,
        ),
      ));
    }

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
            children: <Widget>[
              SizedBox(
                height: rh(380),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      height: rf(330),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.network(
                          widget.restaurant.imagen!,
                          width: 100 * SizeConfig.heightMultiplier,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      child: CustomAppBar(
                        onBackTap: _navigateBack,
                        showOptions: false,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: ClippedContainer(
                        backgroundColor: Colors.white,
                        child: VendorInfoCard(
                          title: widget.restaurant.nombre!,
                          rating: widget.restaurant.promedio!,
                          sideImagePath: widget.restaurant.imagen!,
                          reviews: widget.restaurant.nCalificaciones!,
                          descripcion: widget.restaurant.descripcion ??
                              "Sin descripcion",
                          etiqueta: widget.restaurant.etiquetas![0],
                        ),
                      ),
                    ),
                  ],
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
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: const Text("Platos de la carta"),
                      ),
                      ListView.separated(
                        itemCount: widget.restaurant.carta!.length,
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                            height: rh(space4x),
                            endIndent: rw(20),
                            indent: rw(20),
                          );
                        },
                        itemBuilder: (BuildContext context, int index) {
                          final itemCarta = widget.restaurant.carta![index];
                          return GestureDetector(
                            onTap: (() {
                              handleNavigate(context, itemCarta,
                                  widget.restaurant.nombre!);
                            }),
                            child: ProductItem(
                              imagePath: itemCarta.imagen!,
                              title: itemCarta.nombre!,
                              detail: itemCarta.detalle!,
                              precio: itemCarta.precio!,
                              ranking: itemCarta.precio!,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
