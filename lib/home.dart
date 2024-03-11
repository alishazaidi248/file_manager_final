import 'package:filemanager/settings.dart';
import 'package:flutter/material.dart';

import 'Apps.dart';
import 'Documents.dart';
import 'Images.dart';
import 'Notes.dart';
import 'archive.dart';
import 'bin.dart';
import 'favourites.dart';
import 'downloads.dart';
import 'main.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title, required this.onThemeChanged}) : super(key: key);
  final String title;
  final ValueChanged<bool> onThemeChanged;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _textScrollController = ScrollController();

  List<String> buttonNames = [
    'Downloads',
    'Images',
    'Identity Docs',
    'Notes',
    'Apps',
    'Documents',
  ];
  List<IconData> buttonIcons = [
    Icons.arrow_downward,
    Icons.image,
    Icons.person,
    Icons.note,
    Icons.apps,
    Icons.description,
  ];
  List<Color> buttonColors = [
    Colors.red,
    Colors.red,
    Colors.red,
    Colors.red,
    Colors.red,
    Colors.red,
  ];
  late Map<String, Widget> pageMappings;

  get file => null;

  @override
  void initState() {
    super.initState();

    pageMappings = {
      'downloads': Downloads(onThemeChanged: widget.onThemeChanged),
      'images': Images(onThemeChanged: widget.onThemeChanged),
      'identity docs': Downloads(onThemeChanged: widget.onThemeChanged),
      'notes': Notes(onThemeChanged: widget.onThemeChanged),
      'apps': Apps(onThemeChanged: widget.onThemeChanged),
      'documents': Documents(onThemeChanged: widget.onThemeChanged),
    };
  }
  Type currentPageType = Downloads;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.red,
        title: TextField(
          controller: _searchController,
          onChanged: (query) {
            String lowerCaseQuery = query.toLowerCase();
            if (pageMappings.containsKey(lowerCaseQuery)) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => pageMappings[lowerCaseQuery]!,
                ),
              );
              _searchController.clear();
            }
          },
          decoration: InputDecoration(

            hintText: 'Search',
            prefixIcon: Icon(Icons.search),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu Options'),
              decoration: BoxDecoration(
                color:Colors.red,
              ),
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text('Recycle Bin'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondRoute(file: file, files: [],)),
                );

              },
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Favourites'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ThirdRoute()),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Image.network(
                'https://th.bing.com/th/id/R.706188c1f1f3cf980fda4c751ce87d2e?rik=KDwaQbPJagzDtQ&riu=http%3a%2f%2fwww.pixelstalk.net%2fwp-content%2fuploads%2f2016%2f03%2fRed-abtsract-neon-wallpaper-HD.jpg&ehk=JI%2bc5LZK2sxJq8WPECHTZdqLA0Q8caqOSCQ5GslmhmI%3d&risl=&pid=ImgRaw&r=0',
                width: 2000,
                height: 500,
                fit: BoxFit.fitWidth,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

              ],
            ),
            SizedBox(height: 16.0),
            Expanded(

              child: GridView.builder(
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),


                itemCount: 6,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 2),
                ),

                itemBuilder: (BuildContext context, int index) {
                  return ElevatedButton(

                    style: ElevatedButton.styleFrom(

                      primary: buttonColors[index],

                      shape: RoundedRectangleBorder(

                        borderRadius: BorderRadius.circular(15.0),

                      ),

                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                          pageMappings[buttonNames[index].toLowerCase()]!,
                        ),
                      );
                    },
                    child: Column(

                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          buttonIcons[index],
                          color: Colors.white,
                          size: 32.0,
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          buttonNames[index],
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),

                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive_outlined),
            label: 'Archive',
          ),
        ],
        selectedIconTheme: IconThemeData(color: Colors.red),
        unselectedIconTheme: IconThemeData(color: Colors.red),
        onTap: (int index) {
          if (index == 0 && currentPageType != MyHomePage) {
          }
          else if (index == 1 && currentPageType != SettingsPage) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SettingsPage(onThemeChanged: widget.onThemeChanged),
              ),
            );
          }
          else if (index == 2 && currentPageType != archive) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => archive(onThemeChanged: widget.onThemeChanged),
              ),
            );
          }
        },
      ),
    );
  }
}

_showFolderInputDialog(BuildContext context) {
  String folderName = '';

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Enter Folder Name'),
        content: TextField(
          onChanged: (value) {
            folderName = value;
          },
          decoration: InputDecoration(
            hintText: 'Folder Name',
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (folderName.isNotEmpty) {

                Navigator.of(context).pop();
              }
            },
            child: Text('Add'),
          ),
        ],
      );
    },
  );
}