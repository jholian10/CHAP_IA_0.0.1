import 'package:chap_ia_001/bloc/chap_bloc.dart';
import 'package:chap_ia_001/views/chat_page.dart';
import 'package:chap_ia_001/views/data/openai_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
}

class MyApp extends StatelessWidget {
  final OpenAIService api = OpenAIService();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pregúntale a la IA',
      home: BlocProvider(create: (_) => ChatBloc(api), child: ChatPage()),
    );
  }
}
