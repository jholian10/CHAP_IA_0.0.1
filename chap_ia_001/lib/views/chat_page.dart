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
  String? lastAnswer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Stack(
          children: [
            Text(
              'IAmego',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 2
                  ..color = Colors.blue,
              ),
            ),

            Text(
              'IAmego',
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

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Pregunta lo que quiras",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.blue, width: 3),
              ),
              child: ElevatedButton(
                onPressed: () {
                  final pregunta = _controller.text.trim();
                  if (pregunta.isNotEmpty) {
                    context.read<ChatBloc>().add(SendMessageEvent(pregunta));
                    _controller.clear();
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(16),
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  elevation: 0,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      Icons.arrow_upward,
                      size: 30,
                      color: Colors.blue,
                      shadows: [
                        Shadow(
                          blurRadius: 3,
                          color: Colors.blue,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),

                    Icon(Icons.arrow_upward, size: 22, color: Colors.black),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  if (state is ChatLoading) {
                    return LoadingView();
                  } else if (state is ChatSuccess) {
                    return SingleChildScrollView(
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
                    return Text("Haz una pregunta para comenzar.");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
