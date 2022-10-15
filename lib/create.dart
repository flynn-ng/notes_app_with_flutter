import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:notes/urls.dart';

class CreatePage extends StatefulWidget {
  final Client client;

  const CreatePage({
    Key? key,
    required this.client,
  }) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create"),
      ),
      body: Column(
        children: [
          TextField(
            controller: controller,
            maxLines: 10,
          ),
          ElevatedButton(
              onPressed: () {
                widget.client.post(
                  createUrl,
                  body: {'body': controller.text},
                );
                Navigator.pop(context);
              },
              child: const Text("Create Note"))
        ],
      ),
    );
  }
}
