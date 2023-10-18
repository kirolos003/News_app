import 'dart:async';
import 'package:flutter/material.dart';
import 'package:news_app/Network/local/cache_helper.dart';
import 'package:news_app/Network/remote/dio_helper.dart';
import 'package:news_app/UI/screens/Home/home_screen.dart';
import 'package:news_app/provider/app_provider.dart';
import 'package:news_app/shared/components.dart';
import 'package:news_app/style/themes.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init();
  runApp(ChangeNotifierProvider(
      create: (BuildContext context) => AppProvider(),
      child: const MyApp()
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() =>
      SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  SplashScreenState();
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      navigateAndFinish(context, const HomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Image.asset('assets/images/splash_screen.png',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            )
          ],
        ),
      ),
    );
  }
}
