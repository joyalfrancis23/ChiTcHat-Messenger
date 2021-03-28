import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class MessageField extends StatefulWidget {
  @override
  _MessageFieldState createState() => _MessageFieldState();
}

class _MessageFieldState extends State<MessageField> {
  var _enteredMessage = '';
  final _messageField = new TextEditingController();
  void _sendMessage()async{
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    final name = await FirebaseFirestore.instance.collection('userAccounts').doc('${user.uid}').get();
    await FirebaseFirestore.instance.collection('chat').add({
      'text': _enteredMessage,
      'timestamp':Timestamp.now(),
      'userId': user.uid,
      'displayName': !name.exists?user.displayName:name['username'],
      'image_url': !name.exists?user.photoURL:name['image_url'],
    }).then((value) => print('Method for sending a message has been called!!!')).catchError((didg){print('Error in sending message $didg');});
    _messageField.clear();
    print(name);
    print("Working");
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child:Row(
        children: <Widget>[
          Expanded(child: TextField(
            controller: _messageField,
            decoration: InputDecoration(
              labelText: 'Send a message...',
            ),
            onChanged: (value){
              setState(() {
                _enteredMessage = value;
              });
            }
          )),
          IconButton(
            icon: Icon(Icons.send_rounded),
            color: Colors.blue,
            onPressed: _enteredMessage.trim().isEmpty? null :_sendMessage,

          )
        ],
      )
    );
  }
}