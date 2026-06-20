import 'package:chat_app/constans.dart';
import 'package:chat_app/models/massage.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/widget/ChatBuble.dart';
import 'package:chat_app/widget/custom_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});

  static const String chatPageId = "chatpage";

  String message = "";

  CollectionReference massageRef = FirebaseFirestore.instance.collection(
    KmassageCollection,
  );

  final _scrollController = ScrollController();

  TextEditingController Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: massageRef.orderBy(KCreatedAT, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Massage> massageList = [];

          for (var doc in snapshot.data!.docs) {
            massageList.add(Massage.fromJson(doc));
          }

          return Scaffold(
            appBar: AppBar(
              backgroundColor: KPrimaryColor,
              title: Row(
                children: [
                  Image.asset('assets/images/scholar.png', height: 60),
                  const SizedBox(width: 10),
                  const Text('Scholar Chat'),
                ],
              ),
            ),

            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: _scrollController,
                    itemCount: massageList.length,
                    itemBuilder: (context, index) {
                      return massageList[index].id == email
                          ? ChatBuble(massageBuble: massageList[index])
                          : ChatBubleForFriend(
                              massageBuble: massageList[index],
                            );
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    controller: Controller,
                    onSubmitted: (data) {
                      massageRef.add({
                        KmassageCollection: data,
                        KCreatedAT: Timestamp.now(),
                        Kid: email,
                      });
                      Controller.clear();
                      _scrollController.animateTo(
                        0,

                        duration: Duration(milliseconds: 500),

                        curve: Curves.easeIn,
                      );
                    },
                    decoration: InputDecoration(
                      hintText: "Type your message here...",
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 18,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: KPrimaryColor),
                      ),
                      prefixIcon: Icon(Icons.add, color: KPrimaryColor),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.send, color: KPrimaryColor),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Center(child: Text("loading..."));
        }
      },
    );
  }
}
