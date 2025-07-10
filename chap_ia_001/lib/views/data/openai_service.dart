import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenAIService {
  final String _apiKey =
      "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";
  Future<String> sendMessage(String message) async {
    final response = await http.post(
      Uri.parse("https://openrouter.ai/api/v1/chat/completions"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $_apiKey",
      },
      body: jsonEncode({
        "model": "mistralai/mistral-7b-instruct:free",
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
