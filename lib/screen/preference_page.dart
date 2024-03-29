import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:comeloso_app/constants/ui_constants.dart';
import 'package:comeloso_app/provider/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

typedef AddPrefList = void Function(String value);

class PreferenceRegisterPage extends StatelessWidget {
  const PreferenceRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> preferencesList = [];
    final height = MediaQuery.of(context).size.height;
    CarouselController buttonCarouselController = CarouselController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Preferencias",
          style: AppStyle.headerTextStyle,
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.logout();
              },
              icon: const FaIcon(
                FontAwesomeIcons.doorOpen,
                color: Colors.white,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                "Preferencias",
                style: AppStyle.titlesH1,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "Necesitamos saber un poco de ti para empezar con la aventura, no te preocupes no venderemos tus datos a otra empresa 😊",
                  style: AppStyle.paragraph1,
                ),
              ),
              SizedBox(
                child: CarouselSlider(
                  items: [
                    PreferenceOptions(
                      preferencesList: preferencesList,
                      carouselController: buttonCarouselController,
                      color: Colors.green,
                      icon: FontAwesomeIcons.dollarSign,
                      option1: 'No tengo problemas en pagar',
                      option2: 'Si la comida se ve buena puedo darme un gusto',
                      option3: 'Tengo 10 lucas',
                      subTitle: 'Dinos cuanto estas dispuesto a pagar',
                      title: 'Precios',
                      value1: 'Caro',
                      value2: 'Medio',
                      value3: 'Barato',
                      bgcolor: Colors.green,
                      description:
                          "Responde con sinceridad, no te queremos mandar a un retaurant gourmet con 15 soles en el bolsillo",
                    ),
                    PreferenceOptions(
                      preferencesList: preferencesList,
                      carouselController: buttonCarouselController,
                      color: Colors.pink.shade100,
                      icon: FontAwesomeIcons.bowlFood,
                      option1: 'Como de todo',
                      option2: 'Vegetariano',
                      option3: 'Vegano',
                      subTitle: '¿🍗 o 🍅?',
                      title: 'Dieta',
                      value1: 'Todo',
                      value2: 'Vegetariano',
                      value3: 'Vegano',
                      bgcolor: Colors.pink.shade100,
                      description:
                          "Si un dia cambias de parecer, puedes cambiarlo en opciones",
                    ),
                    CardBoxPrefFood(
                      carouselController: buttonCarouselController,
                      preferencesList: preferencesList,
                    ),
                    const CardBoxPrefStart(),
                  ],
                  carouselController: buttonCarouselController,
                  options: CarouselOptions(
                      enlargeCenterPage: false,
                      height: 490,
                      enableInfiniteScroll: false),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}

class PreferenceOptions extends StatelessWidget {
  const PreferenceOptions({
    Key? key,
    required this.preferencesList,
    required this.carouselController,
    required this.color,
    required this.option1,
    required this.option2,
    required this.option3,
    required this.value1,
    required this.value2,
    required this.value3,
    required this.title,
    required this.subTitle,
    required this.icon,
    required this.bgcolor,
    required this.description,
  }) : super(key: key);

  final List<String> preferencesList;
  final CarouselController carouselController;
  final String title;
  final String subTitle;
  final IconData icon;
  final Color color;
  final Color bgcolor;
  final String option1;
  final String option2;
  final String option3;
  final String value1;
  final String value2;
  final String value3;
  final String description;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 350),
      child: Card(
        color: bgcolor,
        elevation: 10,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Padding(
          padding:
              const EdgeInsets.only(bottom: 5, left: 30, right: 30, top: 20),
          child: Column(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                child: FaIcon(
                  icon,
                  color: color,
                  size: 50,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                title,
                style: AppStyle.titlesH2,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                subTitle,
                style: AppStyle.paragraph2,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  OptionButton(
                    label: option1,
                    value: value1,
                    carouselController: carouselController,
                    preferences: preferencesList,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  OptionButton(
                    label: option2,
                    value: value2,
                    preferences: preferencesList,
                    carouselController: carouselController,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  OptionButton(
                    label: option3,
                    value: value3,
                    carouselController: carouselController,
                    preferences: preferencesList,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                description,
                textAlign: TextAlign.center,
                style: AppStyle.textOut1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardBoxPrefFood extends StatelessWidget {
  const CardBoxPrefFood({
    Key? key,
    required this.carouselController,
    required this.preferencesList,
  }) : super(key: key);
  final CarouselController carouselController;
  final List<String> preferencesList;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 350),
      child: Card(
        color: Colors.orange.shade100,
        elevation: 10,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Padding(
          padding:
              const EdgeInsets.only(bottom: 5, left: 30, right: 30, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.orange.shade200,
                child: const FaIcon(
                  FontAwesomeIcons.faceSmileBeam,
                  color: Colors.white,
                  size: 33,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Comida",
                textAlign: TextAlign.center,
                style: AppStyle.titlesH2,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "¿Que tipo de comida es la que te gusta mas?",
                style: AppStyle.paragraph2,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  children: [
                    optionCard("Comida Peruana", preferencesList, "Peruana",
                        "lib/assets/peruvian_food.jpg", carouselController),
                    optionCard("Comida China", preferencesList, "China",
                        "lib/assets/peruvian_food.jpg", carouselController),
                    optionCard(
                        "Comida Venezolana",
                        preferencesList,
                        "Venezolana",
                        "lib/assets/peruvian_food.jpg",
                        carouselController),
                    optionCard("Comida Italiana", preferencesList, "Italiana",
                        "lib/assets/peruvian_food.jpg", carouselController),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Escoge al menos 2 tipos",
                textAlign: TextAlign.center,
                style: AppStyle.textIn1,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget optionCard(
  String value,
  List<String> preferenceList,
  String name,
  String image,
  CarouselController carouselController,
) {
  bool containsIt = false;

  for (var element in preferenceList) {
    print(element);
    if (element == value) {
      print(containsIt);
      carouselController.jumpToPage(4);
      setState() {
        containsIt = true;
      }
    } else {
      containsIt = false;
    }
  }
  return InkWell(
      onTap: () {
        preferenceList.add(value);
        print(preferenceList);
      },
      child: Container(
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("lib/assets/peruvian_food.jpg"),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Card(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Divider(),
                ],
              ),
            ),
          )));
}

class CardBoxPrefStart extends StatelessWidget {
  const CardBoxPrefStart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 350),
      child: Card(
        color: Colors.white,
        elevation: 10,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Padding(
          padding:
              const EdgeInsets.only(bottom: 5, left: 30, right: 30, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const CircleAvatar(
                radius: 80,
                backgroundColor: Colors.green,
                child: FaIcon(
                  FontAwesomeIcons.check,
                  color: Colors.white,
                  size: 100,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Terminamos",
                textAlign: TextAlign.center,
                style: AppStyle.titlesH2,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Gracias por reponder, espero con sinceridad",
                style: AppStyle.paragraph2,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                onPressed: () {},
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.grey.shade200,
                child: Text("Empezar"),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Estos datos iran cambiando dependiendo que lugares vayas agregando a favoritos o que recurrentemente asistas",
                textAlign: TextAlign.center,
                style: AppStyle.textIn1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OptionButton extends StatefulWidget {
  final String label;
  final List<String> preferences;
  final String value;
  final CarouselController carouselController;

  const OptionButton({
    Key? key,
    required this.label,
    required this.value,
    required this.preferences,
    required this.carouselController,
  }) : super(key: key);

  @override
  State<OptionButton> createState() => _OptionButtonState();
}

class _OptionButtonState extends State<OptionButton> {
  @override
  Widget build(BuildContext context) {
    bool containsIt = false;

    for (var element in widget.preferences) {
      print(element);
      if (element == widget.value) {
        print(containsIt);
        widget.carouselController.jumpToPage(4);

        containsIt = true;
      } else {
        containsIt = false;
      }
    }

    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.grey.shade200,
      onPressed: () {
        if (containsIt == false) {
          widget.preferences.add(widget.value);
        }
        widget.carouselController.jumpToPage(4);
        print(widget.preferences);
      },
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Text(
        widget.label,
        textAlign: TextAlign.center,
      ),
    );
  }
}
