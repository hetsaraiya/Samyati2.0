import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:samyati/Theme/dark_theme.dart';
import 'package:samyati/Theme/light_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:samyati/firebase_options.dart';
import 'Screens/splash_screen.dart';
import 'Theme/colos.dart';
import 'Theme/theme_modal.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();

}
class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ThemeModal(),
        child: Consumer(
        builder: (context, ThemeModal themeModal, child)
    {
      return  MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: themeModal.isDark
            ? ThemeData(
          brightness: Brightness.light,
          primaryColor: Constants().lightTextColor,
          appBarTheme: AppBarTheme(
              backgroundColor: Constants().lightAppBar),
          scaffoldBackgroundColor: Constants().lightBg,
          fontFamily: Constants().allFontFamily,
          primaryTextTheme: TextTheme(
            bodyLarge: TextStyle(
              color: Constants().lightTextColor,
            ),
          ),
        )
            : ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Constants().darkBg,
          primaryColor: Constants().darkTextColor,
          textTheme: Typography().white.apply(
            fontFamily: Constants().allFontFamily,
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Constants().darkAppBar,
          ),
        ),
            home: const Scaffold(
              body: Splash_Screen(),
            ),
          );
    }
    )

    );
  }
}