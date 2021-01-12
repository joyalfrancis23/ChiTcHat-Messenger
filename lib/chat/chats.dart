import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatsMsg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          itemBuilder: (ctx,index)=>Text(docs[index]['text'])
        ,);
      },
    );
  }
}