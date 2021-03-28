
import 'package:firebase_core/firebase_core.dart';

import './screens/auth_screen.dart';
import './screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      home: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),
      builder: (ctx, snapShots){
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

