import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/mock_data.dart';

class AIChatScreen extends StatefulWidget {
  const AIChatScreen({super.key});

  @override
  State<AIChatScreen> createState() => _AIChatScreenState();
}

class _AIChatScreenState extends State<AIChatScreen> {
  final TextEditingController _textFieldController = TextEditingController();
  String _response = ""; // To hold the current response
  bool _isLoading = false; // To show loading indicator while fetching response
  
  Future<void> _askQuestion(String question) async {
    if (loadMockData) {
      setState(() {
        _isLoading = true;
      });
      await Future.delayed(const Duration(seconds: 2));
      setState(() {
        _response = mockResponce;
      });
      setState(() {
        _isLoading = false;
      });
      return;
    }
    setState(() {
      _isLoading = true;
    });
    const apiKey = '';
    const url = 'https://api.openai.com/v1/chat/completions';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          "model": "gpt-4o-mini",
          "messages": [
            {
              "role": "user",
              "content":
                  'I am a student, i need assistance in higher education for: $question. dont ask me any questions. give me general instructions. i am from UAE. limit the response to 500 tokens. the value should be rich text'
            }
          ],
        }),
      );

      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _response = data['choices'][0]['message']['content'];
        });
        log(_response);
      } else {
        final data = jsonDecode(response.body);
        setState(() {
          _response = 'Error: ${data['error']['message']}';
        });
      }
    } catch (e) {
      setState(() {
        _response = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("EduMentor"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Input text field
            TextField(
              controller: _textFieldController,
              cursorColor: Theme.of(context).primaryColor,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                labelText: 'Subjects you are interested in?',
                labelStyle: const TextStyle(color: Color.fromARGB(255, 211, 204, 204)),
                suffixIcon: _textFieldController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _textFieldController.clear();
                          setState(() {
                            _response = "";
                          });
                        },
                      )
                    : null,
              ),
              onChanged: (text) {
                setState(() {});
              },
            ),
            const SizedBox(height: 16),

            // Button to send query
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_textFieldController.text.isNotEmpty) {
                    _askQuestion(_textFieldController.text);
                  }
                },
                child: const Text("Get Guidance"),
              ),
            ),
            const SizedBox(height: 16),

            // Show loading indicator while fetching response
            if (_isLoading) const Center(child: CircularProgressIndicator(color: Colors.white)),
            
            const SizedBox(height: 16),

            // Display the response
            if (_response.isNotEmpty)
              Expanded(
                child: Container(
                  width: double.infinity, // Ensure full width
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: SingleChildScrollView(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: _response,
                            style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}