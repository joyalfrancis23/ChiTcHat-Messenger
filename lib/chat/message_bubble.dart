import 'package:flutter/material.dart';


class MessageBubble extends StatelessWidget {
  MessageBubble(this._message,this.isMe,{this.key});
  final String _message;
  final bool isMe;
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
          child: Text(_message),
        ),
      ],
    );
  }
}