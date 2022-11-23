import 'package:comeloso_app/constants/ui_constants.dart';
import 'package:comeloso_app/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    void handleNavigate(BuildContext context) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    }

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const Positioned.fill(
            child: RiveAnimation.asset(
              'lib/assets/rive/coffe.riv',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: maxPageWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 195,
                    ),
                    const Text(
                      "Hola,\nBienvenido a ComelOso",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 75,
                    ),
                    const Text(
                      "Tu dinos que te gusta y nosotros lo buscamos",
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "Create with love for\nJose1060 <3",
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                    const SizedBox(
                      height: 75,
                    ),
                    const Text(
                      "Powered with Firebase and Flutter",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                    ElevatedButton(
                      onPressed: () => {
                        handleNavigate(context),
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        backgroundColor: Colors.white,
                      ),
                      child: const Text(
                        "Empezar",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
