import 'package:chat_app/main.dart';
import 'package:chat_app/src/screens/chat_screen/chat_screen.dart';
import 'package:chat_app/src/shared/strings.dart';
import 'package:chat_app/src/shared/themes.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: ChatScreen(chatRoom: chatRoom,),
      theme: themeLight,
    );
  }
}
