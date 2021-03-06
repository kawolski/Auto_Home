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
    return StreamProvider<CustomUser>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}

