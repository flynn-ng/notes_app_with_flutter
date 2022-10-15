import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:notes/urls.dart';

class UpdatePage extends StatefulWidget {
  final Client client;
  final int id;
  final String note;

  const UpdatePage({
    Key? key,
    required this.client,
    required this.id,
    required this.note,
  }) : super(key: key);

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    controller.text = widget.note;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update"),
      ),
      body: Column(
        children: [
          TextField(
            controller: controller,
            maxLines: 10,
          ),
          ElevatedButton(
              onPressed: () {
                widget.client.put(updateUrl(widget.id), body: {'body': controller.text});
                Navigator.pop(context);
              },
              child: const Text("Update Note"))
        ],
      ),
    );
  }
}
