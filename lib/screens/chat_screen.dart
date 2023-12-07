import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:messageme_app/screens/singin_screen.dart';
import 'package:messageme_app/screens/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
final _firestore = FirebaseFirestore.instance;
late User signdInUsre;

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);
  static const ChatRoute = 'chat_screen';


  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final MassegeControl =TextEditingController();
  final _auth = FirebaseAuth.instance;
  String? massegeText;
  @override
  void initState() {
    getUser();
    super.initState();
  }

  void getUser(){
   try{
     final user = _auth.currentUser;
     if(user != null){
       signdInUsre = user;
       print(signdInUsre.email);
     }
   }catch(e){
     print(e);
   }
  }

  // void getMasseges()async{
  //  final masseges =await _firestore.collection('messages').get();
  //  for(var massege in masseges.docs){
  //    print(massege.data());
  //  }
  // void massegesStream()async{
  //   await for(var snapshot in _firestore.collection('messages').snapshots()){
  //     for(var massege in snapshot.docs){
  //          print(massege.data());
  //     }
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[900],
        title: Row(
          children: [
            Image.asset(
                'images/attachment_59060581.png',
              height: 25,
            ),
            SizedBox(width: 10,),
            Text('MassageMe')
          ],
        ),
        actions: [
          IconButton(onPressed: (){
            // massegesStream();
            _auth.signOut();
            Navigator.pushReplacementNamed(context, SinginScreen.SinginRoute);
          }, icon: Icon(Icons.close))
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BuilderWidget(),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.teal[700]!,
                    width: 2,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: TextField(
                        controller: MassegeControl,
                        onChanged: (value){
                          massegeText = value;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10
                          ),
                          hintText: 'Write your massage here......',
                          border: InputBorder.none
                        ),
                      )
                  ),
                  IconButton(onPressed: (){
                    MassegeControl.clear();
                    _firestore.collection('messages').add({
                      'text': massegeText,
                      'sender': signdInUsre.email,
                      'time': FieldValue.serverTimestamp()
                    });
                  }, icon: Icon(Icons.send,color: Colors.blue[800],))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class MassegLine extends StatelessWidget {
   MassegLine({Key? key,required this.massage,required this.sender,required this.isMe}) : super(key: key);
  final String sender;
  final String massage;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:isMe ? CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: [
          Text('$sender',style: TextStyle(
            fontSize: 12,
            color: Colors.teal
          ),),
          Material(
            elevation: 5,
            borderRadius:isMe ? BorderRadius.only(
              topLeft: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)
            ):BorderRadius.only(
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)
            ),
            color:isMe ? Colors.blue[800]: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20),
                child: Text('$massage',style: TextStyle(fontSize: 15,color: isMe ? Colors.white: Colors.black54),),
              )
          ),
        ],
      ),
    );
  }
}
class BuilderWidget extends StatelessWidget {
  const BuilderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').orderBy('time').snapshots(),
      builder: (context, snapshot){
        List<MassegLine> massageWidgets =[];
        if(!snapshot.hasData){
          return Center(
            child:CircularProgressIndicator(
              backgroundColor: Colors.blue,
            ) ,
          );
        }
        final masseges =snapshot.data!.docs.reversed;
        for(var massege in masseges){
          final masstext = massege.get('text');
          final massSender = massege.get('sender');
          final currentUser = signdInUsre.email;



          final massagewidget = MassegLine(massage: masstext,sender: massSender,isMe: currentUser == massSender,);
          massageWidgets.add(massagewidget);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
            children: massageWidgets,
          ),
        );
      },
    );
  }
}
