import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';

class Apps extends StatefulWidget {
  Apps({Key? key, required ValueChanged<bool> onThemeChanged}) : super(key: key);

  @override
  _AppsState createState() => _AppsState();
}

class _AppsState extends State<Apps> {
  late List<Application> _apps;

  @override
  void initState() {
    super.initState();
    getInstalledApps();
  }

  Future<void> getInstalledApps() async {
    List<Application> apps = await DeviceApps.getInstalledApplications(includeAppIcons: true, includeSystemApps: true);
    setState(() {
      _apps = apps;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Installed Applications'),
      ),
      body: FutureBuilder<List<Application>>(
        future: DeviceApps.getInstalledApplications(includeAppIcons: true, includeSystemApps: true),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('An error occurred'));
          } else {
            _apps = snapshot.data!;
            return ListView.builder(
              itemCount: _apps.length,
              itemBuilder: (BuildContext context, int index) {
                Application app = _apps[index];
                return ListTile(
                  leading: app is ApplicationWithIcon ? Image.memory(app.icon) : null,
                  title: Text(app.appName),
                  subtitle: Text(app.packageName),
                );
              },
            );
          }
        },
      ),
    );
  }

}
