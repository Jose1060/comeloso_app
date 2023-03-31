import 'package:comeloso_app/constants/colors.dart';
import 'package:comeloso_app/provider/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SizedBox(
          height: height,
          child: Stack(
            children: [
              Container(
                height: height / 1.5,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorConstants.primaryColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                    bottomRight: Radius.circular(60),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 180,
                      child: Image(
                          image: AssetImage("lib/assets/bear_logo_2.png")),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          top: 10, bottom: 15, left: 50, right: 50),
                      child: const Divider(
                        height: 2,
                        thickness: 3,
                        color: Colors.white,
                        indent: 2,
                        endIndent: 2,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "Miles de restaurantes a tu disposicion",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Roboto',
                        fontStyle: FontStyle.normal,
                      ),
                    )
                  ],
                ),
              ),
              SingleChildScrollView(
                child: SizedBox(
                  height: height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: height / 2.5,
                        margin: const EdgeInsets.all(20),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 40,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            //LoginEmailForm(),
                            Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 30),
                                  child: Text(
                                    "Por el momento no tenemos un registro con correo y tu propia contraseña, pero puede registrarte con tu cuenta del señor Google, mas facil ¿no?",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: ColorConstants.commentedColor),
                                  ),
                                )
                              ],
                            ),

                            MaterialButton(
                                onPressed: () {
                                  final provider =
                                      Provider.of<GoogleSignInProvider>(context,
                                          listen: false);
                                  provider.googleLogin();
                                },
                                color: ColorConstants.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(31),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      "LOG IN WITH GOOGLE",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    FaIcon(
                                      FontAwesomeIcons.google,
                                      color: Colors.white,
                                    ),
                                  ],
                                )),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    thickness: 1,
                                    height: 1,
                                    color: ColorConstants.starterWhite,
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Text("Visitamos en nuestras redes sociales",
                                    style: TextStyle(
                                        color: ColorConstants.commentedColor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700)),
                                const SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                  child: Divider(
                                    thickness: 1,
                                    height: 1,
                                    color: ColorConstants.starterWhite,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 22,
                            ),
                            const SocialMediaLinks()
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LoginEmailForm extends StatelessWidget {
  const LoginEmailForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Login Account",
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 22,
        ),
        const SizedBox(
          height: 40,
          child:
              InputLogin(hint: "Username or Email", icon: Icons.email_outlined),
        ),
        const SizedBox(
          height: 16,
        ),
        const SizedBox(
          height: 40,
          child: InputLogin(hint: "Password", icon: Icons.visibility_outlined),
        ),
        SwitchListTile.adaptive(
          value: true,
          onChanged: ((value) {}),
          contentPadding: EdgeInsets.zero,
          title: Text(
            "Remember me",
            style: TextStyle(
              color: ColorConstants.starterWhite,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}

class SocialMediaLinks extends StatelessWidget {
  const SocialMediaLinks({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        SizedBox(
          height: 10,
          child: FaIcon(FontAwesomeIcons.twitter),
        ),
        SizedBox(width: 16),
        SizedBox(
          height: 10,
          child: FaIcon(FontAwesomeIcons.facebookF),
        ),
        SizedBox(width: 16),
        SizedBox(
          height: 10,
          child: FaIcon(FontAwesomeIcons.instagram),
        ),
        SizedBox(width: 16),
        SizedBox(
          height: 10,
          child: FaIcon(FontAwesomeIcons.tiktok),
        ),
      ],
    );
  }
}

class InputLogin extends StatelessWidget {
  const InputLogin({
    Key? key,
    required this.hint,
    required this.icon,
  }) : super(key: key);

  final String hint;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          labelText: hint,
          labelStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(26),
            borderSide: BorderSide(color: ColorConstants.starterWhite),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(26),
            borderSide: BorderSide(color: ColorConstants.primaryColor),
          ),
          suffixIcon: Icon(icon)),
    );
  }
}
