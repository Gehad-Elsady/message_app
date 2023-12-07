import 'package:flutter/material.dart';
import 'package:messageme_app/screens/registration_screen.dart';
import 'package:messageme_app/screens/singin_screen.dart';

import '../widget/mybutton.dart';


class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static const WlcomeRoute = 'welcome_screen';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Container(
                  height: 180,
                  child:Image.asset('images/attachment_59060581.png'),
                ),
                Text('MassageMe',style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                  color: Colors.white
                ),)
              ],
            ),
            SizedBox(height: 30,),
            MyButton(color: Colors.blue[700]!,title: 'Sing in',onPressed: (){Navigator.pushNamed(context, SinginScreen.SinginRoute);},),
            MyButton(color: Colors.blue[700]!, title: 'Sing up', onPressed: (){Navigator.pushNamed(context, RegistrationScreen.RegistrationRoute);})
          ],
        ),
      ),
    );
  }
}

