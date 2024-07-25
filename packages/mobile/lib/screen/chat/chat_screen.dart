import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ChatScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Center(
        child: Text('Ct Screen'),
      ),
    );
  }
}
