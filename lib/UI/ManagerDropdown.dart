import 'package:flutter/material.dart';
import '../DataModels/Manager.dart';
import '../Services/ManagerService.dart';

class ManagerDropdown extends StatefulWidget {
  @override
  _ManagerDropdownState createState() => _ManagerDropdownState();
}

class _ManagerDropdownState extends State<ManagerDropdown> {
  String? _selectedManager;
  List<Manager> _managers = [];

  @override
  void initState() {
    super.initState();
    fetchManagers();
  }

  Future<void> fetchManagers() async {
    try {
      final managers = await ManagerService.fetchManagers();
      setState(() {
        _managers = managers;
      });
    } catch (e) {
      print('Error fetching managers: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Manager>(
      value: _managers.isNotEmpty ? _managers.first : null,
      onChanged: (newValue) {
        setState(() {
          _selectedManager = newValue?.name;
        });
      },
      decoration: InputDecoration(
        labelText: 'Select Manager',
        border: OutlineInputBorder(),
      ),
      items: _managers.map((manager) {
        return DropdownMenuItem<Manager>(
          value: manager,
          child: Text(manager.name ?? ''),
        );
      }).toList(),
    );
  }
}