import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageField extends StatefulWidget {
  @override
  _MessageFieldState createState() => _MessageFieldState();
}

class _MessageFieldState extends State<MessageField> {
  var _enteredMessage = '';
  final _messageField = new TextEditingController();
  void _sendMessage(){
    FocusScope.of(context).unfocus();
    Firestore.instance.collection('chat').add({
      'text': _enteredMessage,
      'timestamp':Timestamp.now(),
    }).then((value) => print('Method for sending a message has been called!!!')).catchError((didg){print(didg);});
    _messageField.clear();

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