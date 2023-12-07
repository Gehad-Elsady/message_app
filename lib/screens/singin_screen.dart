import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:messageme_app/screens/chat_screen.dart';
import 'package:messageme_app/widget/mybutton.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SinginScreen extends StatefulWidget {
  const SinginScreen({Key? key}) : super(key: key);
  static const SinginRoute = 'singin_screen';


  @override
  State<SinginScreen> createState() => _SinginScreenState();
}

class _SinginScreenState extends State<SinginScreen> {
  bool _saving = false;
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _saving,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 30,),
              // registration text
              const Center(
                child: Text(
                  'Sing in',
                  style: TextStyle(
                    color: Colors.teal,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 30,),
              // image logo
              Container(
                height: 180,
                child: Image.asset('images/attachment_59060581.png'),
              ),
              SizedBox(height: 50,),
              // email field
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value){
                  email = value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter Your Email',
                  contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.cyan[700]!,width: 1),
                    borderRadius: BorderRadius.circular(10),),
                  focusedBorder:  OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.teal,width: 2),
                    borderRadius: BorderRadius.circular(10),),
                ),
              ),
              SizedBox(height: 15,),
              // password field
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value){
                  password = value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter Your Password',
                  contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.cyan[700]!,width: 1),
                    borderRadius: BorderRadius.circular(10),),
                  focusedBorder:  OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.teal,width: 2),
                    borderRadius: BorderRadius.circular(10),),
                ),
              ),
              SizedBox(height: 10,),
              // sing up button
              MyButton(
                  color: Colors.pink[700]!,
                  title: 'Sing in',
                  onPressed: ()async{
                    setState(() {
                      if(email !=null && password !=null){
                        _saving = true;
                      }else{
                        _saving = false;
                      }
                    });
                    try{
                      final user = await _auth.signInWithEmailAndPassword(email: email, password: password);
                      if(user != null){
                        Navigator.pushNamed(context, ChatScreen.ChatRoute);
                        setState(() {
                          _saving = false;
                        });
                      }
                    }catch(e){
                      print(e);
                    }
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
