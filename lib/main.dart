import 'dart:convert';

import 'package:notes/update.dart';
import 'package:notes/urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'create.dart';
import 'note.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Django X Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Client client = http.Client();
  List<Note> notes = [];

  @override
  void initState() {
    _retrieveNotes();
    super.initState();
  }

  _retrieveNotes() async {
    notes = [];
    List response = json.decode((await client.get(retrieveUrl)).body);
    response.forEach((element) {
      notes.add(Note.fromMap(element));
    });
    setState(() {});
  }

  void _deleteNote(int id) {
    client.delete(deleteUrl(id));
    _retrieveNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _retrieveNotes();
        },
        child: ListView.builder(
            itemCount: notes.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(notes[index].note),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => UpdatePage(
                              client: client,
                              id: notes[index].id,
                              note: notes[index].note,
                            )),
                  );
                },
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _deleteNote(notes[index].id),
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => CreatePage(
                    client: client,
                  )),
        ),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
