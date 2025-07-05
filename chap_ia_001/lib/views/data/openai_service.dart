import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenAIService {
  final String _apiKey =
      "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";
  Future<String> sendMessage(String message) async {
    final response = await http.post(
      Uri.parse("https://api.openai.com/v1/chat/completions"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $_apiKey",
      },
      body: jsonEncode({
        "model": "gpt-3.5-turbo",
        "messages": [
          {"role": "user", "content": message},
        ],
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'].trim();
    } else {
      throw Exception('Error: ${response.statusCode}\n${response.body}');
    }
  }
}
