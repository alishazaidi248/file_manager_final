import 'dart:io';
import 'package:flutter/material.dart';
class SecondRoute extends StatefulWidget {
  final FileSystemEntity? file;
  final List files;

  SecondRoute({this.file, required this.files, Key? key}) : super(key: key);

  @override
  _SecondRouteState createState() => _SecondRouteState();
}


class _SecondRouteState extends State<SecondRoute> {
  late Directory _trashDirectory;
  List<FileSystemEntity>? _files;

  @override
  void initState() {
    super.initState();
    getTrashDirectory();
  }

  Future<void> getTrashDirectory() async {
    _trashDirectory = Directory('/storage/emulated/0/Download/Trash');
    setState(() {
      _files = _trashDirectory.listSync().where((element) => element is File).toList();
    });
  }

  Future<void> deleteFile(FileSystemEntity file) async {
    if (file is File) {
      await file.delete();
    }
    getTrashDirectory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recycle Bin'),
      ),
      body: _files != null
          ? ListView.builder(
        itemCount: _files!.length,
        itemBuilder: (BuildContext context, int index) {
          final FileSystemEntity file = _files![index];
          return ListTile(
            leading: Icon(Icons.insert_drive_file),
            title: Text(file.path.split('/').last),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                deleteFile(file);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('File deleted permanently')),
                );
              },
            ),
          );
        },
      )
          : Center(child: Text('Recycle Bin is empty')),
    );
  }
}
