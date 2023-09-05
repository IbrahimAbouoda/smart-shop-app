import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gaza_shop/generated/l10n.dart';
import 'package:gaza_shop/providers/users_provider.dart';
import 'package:provider/provider.dart';

import 'components/general_provider.dart';
import 'core/shared_preferences/shared_preferences.dart';
import 'core/utils/routers.dart';
import 'providers/products_provider.dart';
import 'service/backend/product_service.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase first
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SharedPrefController.init();

  // Now, you can set up other initializations

  FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
    SharedPrefController.saveToken(newToken);
  });

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<ProductProvider>(
        create: (context) => ProductProvider()),
    ChangeNotifierProvider<ProductService>(
        create: (context) => ProductService()),
    ChangeNotifierProvider<GeneralProvider>(
        create: (context) => GeneralProvider()),
    ChangeNotifierProvider<UserProvider>(
    create: (context) => UserProvider()),
    // ChangeNotifierProvider<MailsByTagsProvider>(
    // create: (context) => MailsByTagsProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale('ar'),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: "/",
      routes: routes,
    );
  }
}
