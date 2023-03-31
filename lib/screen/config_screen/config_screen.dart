import 'package:comeloso_app/models/restaurant.dart';
import 'package:comeloso_app/screen/home_page.dart';
import 'package:comeloso_app/screen/home_screen/start_page.dart';
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
import 'package:comeloso_app/provider/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../profile_screen/profile_user.dart';

class ConfiguracionItem {
  final String titulo;
  final IconData icono;
  final void Function(BuildContext context) onTap;

  ConfiguracionItem(
      {required this.titulo, required this.icono, required this.onTap});
}

Future<void> mostrarModalConfirmacionCerrarSesion(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Confirmación'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('¿Está seguro de que desea cerrar sesión?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Confirmar'),
            onPressed: () async {
              // Agregar el código para cerrar sesión
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              await provider.logout();
              Navigator.of(context).pop();
              handleNavigatHome(context);
            },
          ),
        ],
      );
    },
  );
}

class ConfiguracionList extends StatelessWidget {
  final List<ConfiguracionItem> items;

  ConfiguracionList({required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: items.length,
      shrinkWrap: true,
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          height: rh(space2x),
          endIndent: rw(20),
          indent: rw(20),
        );
      },
      itemBuilder: (BuildContext context, int index) {
        final item = items[index];
        return ListTile(
          leading: Icon(item.icono),
          title: Text(item.titulo),
          onTap: () => item.onTap(context),
        );
      },
    );
  }
}

void handleNavigatProfile(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (_) => ProfileUser()));
}

void handleNavigatHome(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (_) => HomePage()));
}

class ConfigScreen extends StatefulWidget {
  const ConfigScreen({super.key});

  @override
  State<ConfigScreen> createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  late double _height;

  final _duration = const Duration(milliseconds: 750);
  final _psudoDuration = const Duration(milliseconds: 150);

  final List<ConfiguracionItem> items = [
    ConfiguracionItem(
      titulo: 'Perfil',
      icono: Icons.person,
      onTap: (BuildContext context) {
        handleNavigatProfile(context);
      },
    ),
    ConfiguracionItem(
      titulo: 'Cerrar sesión',
      icono: Icons.account_circle,
      onTap: (BuildContext context) {
        mostrarModalConfirmacionCerrarSesion(context);
      },
    ),
    // Agregar más elementos según sea necesario
  ];

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
                title: "Configuración",
                showOptions: false,
              ),
              FadeAnimation(
                intervalStart: 0.4,
                duration: const Duration(milliseconds: 1250),
                child: SlideAnimation(
                  begin: const Offset(0, 100),
                  intervalStart: 0.4,
                  duration: const Duration(milliseconds: 1250),
                  child: ConfiguracionList(items: items),
                ),
              )

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
    ;
  }
}
