import 'package:chatapp/Model/Message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomBubbleChat extends StatelessWidget {
  const CustomBubbleChat({Key? key, required this.message}) : super(key: key);
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
            decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(0),
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                )),
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 15, bottom: 15, left: 8, right: 8),
              child: Text(
                message.message,
                style: TextStyle(color: Colors.white),
              ),
            )),
      ),
    );
  }
}

class CustomBubbleChatForFreind extends StatelessWidget {
  const CustomBubbleChatForFreind({Key? key, required this.message})
      : super(key: key);
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
            decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(15),
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                )),
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 15, bottom: 15, left: 8, right: 8),
              child: Text(
                message.message,
                style: TextStyle(color: Colors.white),
              ),
            )),
      ),
    );
  }
}
