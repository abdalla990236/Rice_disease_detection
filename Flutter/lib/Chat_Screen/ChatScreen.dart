import 'package:chatapp/Model/Message.dart';
import 'package:chatapp/modules/Login/LoginScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/shared/components/components.dart';
import 'package:chatapp/shared/components/constants.dart';
import 'package:chatapp/shared/components/small_widgets.dart';
import '../../shared/components/CustomBubbleChat.dart';

class ChatScren extends StatelessWidget {
  CollectionReference messages =
      FirebaseFirestore.instance.collection(KeyMessageCollection);
  var textInput = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  static String id = "ChatScren";
  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments.toString();
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(KCreatedAt, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messagesaList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesaList.add(Message.fromJson(snapshot.data!.docs[i]));
          }
          return Scaffold(
              // backgroundColor: Colors.white,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                centerTitle: true, // add this line to center the title
                leading: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.deepPurple,
                  ),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .center, // center the row contents horizontally
                  children: [
                    Image.asset(
                      LogoChat,
                      height: 50,
                      width: 50,
                    ),
                    Text(
                      "Chat",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple),
                    ),
                  ],
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                          reverse: true,
                          controller: _scrollController,
                          itemCount: messagesaList.length,
                          itemBuilder: (context, index) {
                            return messagesaList[index].id == email
                                ? CustomBubbleChat(
                                    message: messagesaList[index],
                                  )
                                : CustomBubbleChatForFreind(
                                    message: messagesaList[index]);
                          })),
                  Padding(
                      padding: const EdgeInsets.only(right: 5, left: 5),
                      child: TextField(
                        controller: textInput,
                        onSubmitted: (data) {
                          messages.add({
                            KeyMessage: data,
                            KCreatedAt: DateTime.now(),
                            'id': email
                          }).then((data) {
                            print('Data added to Firestore');
                            _scrollController.jumpTo(0);
                          }).catchError(
                              (error) => print('Failed to add data: $error'));
                          textInput.clear();
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors
                              .deepPurple, // change the background color here
                          hintText: "send message",
                          suffixIcon: GestureDetector(
                            onTap: () {
                              messages.add({
                                KeyMessage: textInput.text,
                                KCreatedAt: DateTime.now(),
                                'id': email
                              }).then((data) {
                                print('Data added to Firestore');
                                _scrollController.jumpTo(0);
                              }).catchError((error) =>
                                  print('Failed to add data: $error'));
                              textInput.clear();
                            },
                            child: Icon(
                              Icons.send,
                              color: Colors.white,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(26),
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(26),
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      )),
                ],
              ));
        } else {
          return Text("Loading.....");
        }
      },
    );
    //centerTitle: true,
  }
}
