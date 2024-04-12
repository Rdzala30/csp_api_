import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../DataModels/CreateProject.dart';
import 'HomePage.dart';

class CreateProjectPage extends StatefulWidget {
  const CreateProjectPage({Key? key}) : super(key: key);

  @override
  State<CreateProjectPage> createState() => _CreateProjectPageState();
}

class _CreateProjectPageState extends State<CreateProjectPage> {
  final _formKey = GlobalKey<FormState>();
  final _projectIdController = TextEditingController();
  final _projectNameController = TextEditingController();
  DateTime? _startDate;


  final List<String> projectStatusOptions = ['Completed', 'On-Going', 'Hold'];
  String? selectedProjectStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Project'),
      ),
      body: SingleChildScrollView( child:
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _projectIdController,
                decoration: InputDecoration(labelText: 'Project ID'),
              ),
              TextFormField(
                controller: _projectNameController,
                decoration: InputDecoration(labelText: 'Project Name'),
              ),

              DropdownButtonFormField<String>(
                value: selectedProjectStatus,
                onChanged: (newValue) {
                  setState(() {
                    selectedProjectStatus = newValue;
                  });
                },
                decoration: InputDecoration(labelText: 'Project Status'),
                items: projectStatusOptions.map((status) {
                  return DropdownMenuItem<String>(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select project status';
                  }
                  return null;
                },
              ),

              ListTile(
                title: Text('Project Start Date'),
                subtitle: _startDate != null
                    ? Text('${_startDate!.toLocal()}'.split(' ')[0])
                    : Text('Select Date'),
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null && picked != _startDate) {
                    setState(() {
                      _startDate = picked;
                    });
                  }
                },
              ),
              Container(
                constraints: BoxConstraints(maxWidth: 200),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      createProject();

                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Create Project',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )


            ],
          ),
        ),
      ),
      )
    );
  }

  Future<void> createProject() async {
    final projectModel = ProjectModel(
      id: _projectIdController.text,
      name: _projectNameController.text,
      associatedManager: ManagerModel(
        id: "auth0|660ea502a009dbb7b90c153e",
        name: "rajpal+manager@gmail.com",
        designation: 'Manager',
      ),
      status: selectedProjectStatus ?? '',
      startDate: _startDate != null ? _startDate!.toString() : '',
    );

    final url = Uri.parse('https://b5mkgbw0-8000.inc1.devtunnels.ms/addProject');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(projectModel.toJson());

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Project created successfully'),
          ),
        );


        Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to create project: ${response.statusCode}'),
          ),
        );}
    } catch (e) {
      // Handle error
      print('Error creating project: $e');
    }
  }
}
