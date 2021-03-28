import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(this._message,this.isMe,this.userName,{this.key});
  final String _message;
  final bool isMe;
  final String userName;
  
  final Key key;
  
  @override
  
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: !isMe?MainAxisAlignment.start:MainAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16,vertical:10),
          decoration: BoxDecoration(
            color: !isMe?Colors.blue[200]:Colors.blue[400],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(17),
              topRight: Radius.circular(17),
              bottomLeft: isMe?Radius.circular(17):Radius.circular(0),
              bottomRight: isMe?Radius.circular(0):Radius.circular(17)
            )
          ),
          margin: EdgeInsets.symmetric(vertical:4,horizontal:8),
          child: Column(
            crossAxisAlignment: isMe?CrossAxisAlignment.end:CrossAxisAlignment.start,
            children: <Widget>[
              Text(userName,style: TextStyle(fontSize:10,fontWeight: FontWeight.bold,color: Colors.indigo[900]),),
              Text(_message,style: TextStyle(fontSize: 18,letterSpacing: 1),textAlign: isMe?TextAlign.end:TextAlign.start,),
            ],
          ),
        ),
      ],
    );
  }
}