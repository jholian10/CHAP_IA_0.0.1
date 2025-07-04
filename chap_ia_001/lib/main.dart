import 'package:chap_ia_001/bloc/chap_bloc.dart';
import 'package:chap_ia_001/views/chat_page.dart';
import 'package:chap_ia_001/views/data/openai_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final OpenaiService api = OpenaiService();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pregúntale a la IA',
      home: BlocProvider(create: (_) => ChatBloc(api), child: ChatPage()),
    );
  }
}
