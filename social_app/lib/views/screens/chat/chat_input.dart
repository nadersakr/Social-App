import 'package:flutter/material.dart';

class ChatInput extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  final Function(String) onSend;

  ChatInput({super.key, required this.onSend});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Enter your message',
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[200],
          suffixIcon: IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                onSend(controller.text);
                controller.clear();
              }
            },
          ),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Please enter a message';
          }
          return null;
        },
      ),
    );
  }
}
