import 'package:auto_home/shared/themes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:auto_home/models/user.dart';
import 'package:auto_home/screens/wrapper.dart';
import 'package:auto_home/services/auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData appTheme = ThemeData(
      primaryColor: Colors.red.withOpacity(1),
      accentColor: Colors.red[900].withOpacity(1),
      backgroundColor: Colors.white.withOpacity(1),
      focusColor: Colors.red[100].withOpacity(1),
      iconTheme: IconThemeData(
        color: Colors.red[900].withOpacity(1)
      ),
      buttonColor: Colors.white,

    );
    return StreamProvider<CustomUser>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        home: Wrapper(),
      ),
    );
  }
}

