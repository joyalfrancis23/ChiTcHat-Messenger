import 'package:ChiTcHat_App/screens/splash_screen.dart';

import './message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatsMsg extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (ctx,futureSnapshot){
                    if(futureSnapshot.connectionState == ConnectionState.waiting){
                      return Center(child: SplashScreen());
                    }
                    return StreamBuilder(
                     stream: FirebaseFirestore.instance.collection('chat').orderBy('timestamp',descending: true).snapshots(),
                     builder: (BuildContext context, AsyncSnapshot <QuerySnapshot> snapShot){
                       if(snapShot.connectionState == ConnectionState.waiting){
                          return Center(child: SplashScreen());

                       }
                    final docs = snapShot.data.docs;
                    
                        return ListView.builder(
                            reverse: true,
                            itemCount: docs.length,
                            itemBuilder: (ctx,index)=>MessageBubble(
                                docs[index]['text'],
                                docs[index]['userId'] == futureSnapshot.data.uid,
                                docs[index]['displayName'],
                                docs[index]['image_url'],
                                key: ValueKey(docs[index].id),
                            )
          ,);}

        );

      },

    );

  }
}