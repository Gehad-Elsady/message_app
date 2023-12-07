import 'package:flutter/material.dart';
import 'package:messageme_app/screens/chat_screen.dart';
import 'package:messageme_app/screens/registration_screen.dart';
import 'package:messageme_app/screens/singin_screen.dart';
import 'package:messageme_app/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MessageMe app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: ChatScreen(),
      initialRoute: _auth.currentUser != null ?ChatScreen.ChatRoute : WelcomeScreen.WlcomeRoute,
      routes:{
        WelcomeScreen.WlcomeRoute :(context) => WelcomeScreen(),
        SinginScreen.SinginRoute : (context) => SinginScreen(),
        RegistrationScreen.RegistrationRoute : (context) => RegistrationScreen(),
        ChatScreen.ChatRoute : (context) => ChatScreen(),
      },
    );
  }
}
