import 'package:ChiTcHat_App/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatsMsg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
                  future: FirebaseAuth.instance.currentUser(),
                  builder: (ctx,futureSnapshot){
                    if(futureSnapshot.connectionState == ConnectionState.waiting){
                      return Center(child: CircularProgressIndicator());
                    }
                    return StreamBuilder(
                    stream: Firestore.instance.collection('chat').orderBy('timestamp',descending: true).snapshots(),
                   builder: (ctx,snapShot){
                  if(snapShot.connectionState == ConnectionState.waiting){
                    return CircularProgressIndicator();
                   }
                    final docs = snapShot.data.documents;
                        return ListView.builder(
                             reverse: true,
                            itemCount: docs.length,
                            itemBuilder: (ctx,index)=>MessageBubble(
                                docs[index]['text'],
                                docs[index]['userId'] == futureSnapshot.data.uid,
                                key: ValueKey(docs[index].documentID),
                            )
          ,);}

        );

      },

    );

  }
}