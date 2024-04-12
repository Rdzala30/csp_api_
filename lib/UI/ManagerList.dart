import 'package:flutter/material.dart';
import '../Services/ManagerService.dart';
import '../DataModels/Manager.dart';

class ManagerList extends StatefulWidget {
  const ManagerList({super.key});

  @override
  State<ManagerList> createState() => _ManagerListState();
}

class _ManagerListState extends State<ManagerList> {
  List<Manager> managers = [];

  @override
  void initState() {
    super.initState();
    fetchManagers();
  }

  Future<void> fetchManagers() async {
    try {
      final managers = await ManagerService.fetchManagers();
      setState(() {
        this.managers = managers;
      });
    } catch (e) {
      print('Error fetching manager data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Managers'),
      ),
      body: managers.isNotEmpty
          ? ListView.builder(
        itemCount: managers.length,
        itemBuilder: (context, index) {
          final manager = managers[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: manager.picture != null
                  ? NetworkImage(manager.picture!)
                  : null,
              child: manager.picture == null
                  ? Text(manager.name![0].toUpperCase())
                  : null,
            ),
            title: Text(manager.name ?? ''),
            subtitle: Text(manager.email ?? ''),
          );
        },
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}