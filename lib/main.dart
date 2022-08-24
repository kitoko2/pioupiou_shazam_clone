import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shazam_clone/screens/home.dart';
import 'package:shazam_clone/utils/theme.dart';

late bool isFirst;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  String? theme = prefs.getString('theme') ?? 'dark';
  isFirst = prefs.getBool('isFirst') ?? true;
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xff16161e),
    ),
  );
  runApp(
    MyApp(
      theme: theme,
    ),
  );
}

class MyApp extends StatelessWidget {
  final String? theme;
  const MyApp({Key? key, required this.theme}) : super(key: key);
  ThemeMode getThemeActuel() {
    switch (theme) {
      case "dark":
        return ThemeMode.dark;
      case "light":
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: getThemeActuel(),
      debugShowCheckedModeBanner: false,
      theme: ThemePerso.ligthTheme,
      darkTheme: ThemePerso.darkTheme,
      title: 'Pioupiou shazam clone',
      home: const HomePage(),
      // home: Loading(),
    );
  }
}
