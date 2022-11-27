import 'package:comeloso_app/firebase_options.dart';
import 'package:comeloso_app/screen/home_page.dart';
import 'package:comeloso_app/screen/landing_page.dart';
import 'package:comeloso_app/screen/login_page.dart';
import 'package:comeloso_app/provider/google_sign_in.dart';
import 'package:comeloso_app/provider/user_data.dart';
import 'package:comeloso_app/theme/app_theme.dart';
import 'package:comeloso_app/utils/size_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gql_http_link/gql_http_link.dart';
import 'package:ferry/ferry.dart';

import 'package:gql_http_link/gql_http_link.dart';
import 'package:ferry/ferry.dart';
import 'package:ferry_hive_store/ferry_hive_store.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

// Future<Client> initClient() async {
//   await Hive.initFlutter();

//   final box = await Hive.openBox("graphql");

//   final store = HiveStore(box);

//   / cache = Cache(store: store, possibleTypes: possibleTypesMap);

//   final link = HttpLink('[path/to/endpoint]');

//   final client = Client(
//     link: link,
//     cache: cache,
//   );

//   return client;
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => GoogleSignInProvider()),
      ChangeNotifierProvider(create: (context) => UserDataProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SizeConfiguration(
      builder: (_) => MaterialApp(
        title: 'ComelOso',
        theme: AppTheme.light(),
        initialRoute: "/home",
        debugShowCheckedModeBanner: false,
        routes: {
          '/landin': (context) => const LandingPage(),
          '/login': (context) => const LoginPage(),
          '/home': (context) => const HomePage()
        },
      ),
    );
  }
}
