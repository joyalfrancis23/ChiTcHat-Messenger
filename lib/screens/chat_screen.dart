
import '../chat/chats.dart';
import '../chat/messageTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(title: RichText(text: TextSpan(text:'ChiT',style: GoogleFonts.raleway(
          color: Colors.cyan,fontWeight: FontWeight.bold,fontSize: 20),
        children: <TextSpan>[
          TextSpan(
            text:'cHat',
            style: GoogleFonts.raleway(color: Colors.amber,fontWeight: FontWeight.bold,fontSize: 30),
          ),
          TextSpan(
            text:'  Messenger',
            style: GoogleFonts.raleway(color: Colors.black54),      
          )
        ]
        ),
        ),backgroundColor: const Color(0xFFFFFFFF),
        actions: [
          DropdownButtonHideUnderline(
                      child: DropdownButton(
              icon: Icon(Icons.more_vert,color:Colors.black54),
              underline: null,
              items: [
              DropdownMenuItem(child: Container(child: Row(children: <Widget>[
                Icon(Icons.exit_to_app),
                SizedBox(width:2),
                Text('Logout'),
              ],),),
              value: 'logout',
              ),
            ], onChanged: (value){
              if(value == 'logout'){
                FirebaseAuth.instance.signOut().then((result)=>Navigator.pushReplacementNamed(context,'/loginPage'));
                
              }
            }),
          )
        ],
        ),
        body: Container(
          child: Column(children:<Widget> [
            Expanded(child: 
            ChatsMsg()
            ,),
            MessageField()
          ],)
        ),
        );
  
  }
}