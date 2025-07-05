import 'package:chap_ia_001/bloc/chap_bloc.dart';
import 'package:chap_ia_001/bloc/chap_event.dart';
import 'package:chap_ia_001/bloc/chap_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'loading_view.dart';
import 'error_view.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 2, 70),
        centerTitle: true,
        title: Stack(
          children: [
            Text(
              'CHAP LUCIANA ❁',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 6
                  ..color = Colors.blue,
              ),
            ),
            Text(
              'CHAP LUCIANA ❁',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: BlocBuilder<ChatBloc, ChatState>(
                  builder: (context, state) {
                    if (state is ChatLoading) {
                      return LoadingView();
                    } else if (state is ChatSuccess) {
                      return SingleChildScrollView(
                        reverse: true,
                        child: Text(
                          state.response,
                          style: TextStyle(fontSize: 16),
                        ),
                      );
                    } else if (state is ChatError) {
                      return ErrorView(
                        message: state.error,
                        onRetry: () {
                          final pregunta = _controller.text.trim();
                          if (pregunta.isNotEmpty) {
                            context.read<ChatBloc>().add(
                              SendMessageEvent(pregunta),
                            );
                          }
                        },
                      );
                    } else {
                      return Center(
                        child: Stack(
                          children: [
                            Text(
                              "¿En qué puedo ayudarte?",
                              style: TextStyle(
                                fontSize: 24,
                                fontStyle: FontStyle.italic,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 1.5
                                  ..color = Colors.blue, // Borde azul
                              ),
                            ),
                            Text(
                              "¿En qué puedo ayudarte?",
                              style: TextStyle(
                                fontSize: 24,
                                fontStyle: FontStyle.italic,
                                color: Colors.black, // Letra negra
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 0, 2, 70),
                border: Border(
                  top: BorderSide(color: Colors.blueGrey.shade300),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        hintText: "Pregunta lo que quieras",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        filled: true,
                        fillColor: Colors.black38,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.blue, width: 2),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        final pregunta = _controller.text.trim();
                        if (pregunta.isNotEmpty) {
                          context.read<ChatBloc>().add(
                            SendMessageEvent(pregunta),
                          );
                          _controller.clear();
                          FocusScope.of(context).unfocus(); // Oculta el teclado
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(14),
                        backgroundColor: Colors.black,
                        elevation: 0,
                      ),
                      child: Icon(
                        Icons.arrow_upward,
                        size: 24,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
