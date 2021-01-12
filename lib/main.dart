import 'package:ChiTcHat_App/screens/auth_screen.dart';
import 'package:ChiTcHat_App/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'chiTcHat',
      theme: ThemeData(
        primaryColor: const Color(0xFFFFFFFF),
        accentColor: Colors.black54,
        primarySwatch: Colors.blue,
        fontFamily: 'Raleway',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StreamBuilder(stream: FirebaseAuth.instance.onAuthStateChanged,builder: (ctx, snapShots){
        if(snapShots.hasData){
          return ChatScreen();
        }
        
        return AuthScreen();
      }) ,
      routes: {
        '/chatScreen':(_) => ChatScreen(),
        '/loginPage':(_) => AuthScreen(),
      },
    );
  }
}

