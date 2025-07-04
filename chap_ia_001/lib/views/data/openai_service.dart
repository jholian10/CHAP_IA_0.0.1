import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenAIService {
  final String _apiKey =
      "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"; // api de prueva

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
