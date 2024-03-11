import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Notes extends StatefulWidget {
  Notes({Key? key, required ValueChanged<bool> onThemeChanged}) : super(key: key);

  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  late File _notesFile;
  String _notesContent = '';

  @override
  void initState() {
    super.initState();
    getNotesFile();
  }

  Future<void> getNotesFile() async {
    final Directory dir = await getApplicationDocumentsDirectory();
    _notesFile = File('${dir.path}/notes.txt');
    if (await _notesFile.exists()) {
      _notesContent = await _notesFile.readAsString();
    }
    setState(() {});
  }

  Future<void> saveNotes() async {
    await _notesFile.writeAsString(_notesContent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          maxLines: null,
          onChanged: (value) {
            _notesContent = value;
            saveNotes();
          },
          controller: TextEditingController(text: _notesContent),
        ),
      ),
    );
  }
}
