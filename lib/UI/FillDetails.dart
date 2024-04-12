import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../DataModels/Project_details.dart';
import 'ManagerDropdown.dart';

class FillDetailsPage extends StatefulWidget {
  final String projectId;
   FillDetailsPage({Key? key, required this.projectId}) : super(key: key);


  @override
  _FillDetailsPageState createState() => _FillDetailsPageState();


}

class _FillDetailsPageState extends State<FillDetailsPage> {


  TextEditingController _overviewController = TextEditingController();
  TextEditingController _budgetTypeController = TextEditingController();
  TextEditingController _budgetValueController = TextEditingController();
  TextEditingController _timelineController = TextEditingController();
  TextEditingController _scopeController = TextEditingController();

  @override
  void dispose() {
    _overviewController.dispose();
    _budgetTypeController.dispose();
    _budgetValueController.dispose();
    _timelineController.dispose();
    _scopeController.dispose();
    super.dispose();
  }

  void submitDataToAPI(String projectId) async {

    Map<String, dynamic> postData = {
      'overview': _overviewController.text,
      'budgetType': _budgetTypeController.text,
      'budgetValue': _budgetValueController.text,
      'timeline': _timelineController.text,
      'scope': _scopeController.text,
    };

    // Convert the data to JSON
    String jsonData = jsonEncode(postData);


    try {
      final response = await http.post(
        Uri.parse('https://b5mkgbw0-8000.inc1.devtunnels.ms/project/$projectId/project_details'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonData,
      );


      if (response.statusCode == 200) {

        print('Data submitted successfully');
      } else {

        print('Failed to submit data. Error code: ${response.statusCode}');
      }
    } catch (e) {

      print('Exception occurred while submitting data: $e');
    }
  }
  
  Future<ProjectDetails> fetchProjectDetails(String projectId) async {
    final response = await http.get(Uri.parse(
        'https://b5mkgbw0-8000.inc1.devtunnels.ms/project/$projectId/project_details'));

    if (response.statusCode == 200) {
      return ProjectDetails.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load project details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Project Details'),
      ),
      body: FutureBuilder<ProjectDetails>(
        future: fetchProjectDetails(widget.projectId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final projectDetails = snapshot.data!;
            final data = projectDetails.data?.first;
            if (data != null) {}
            return data == null
                ? Center(child: Text('No project details found.'))
                : ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                if (data.sId != null)
                  Card(
                    color: Colors.blue[100],
                    child: ListTile(
                      title: Text(
                        projectDetails.data?.first.sId ?? '',
                        style: TextStyle(fontSize: 12),
                      ),
                      leading: Text(
                        projectDetails.data?.first.name ?? '',
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ),


                SizedBox(height: 16),
                ManagerDropdown(),
                SizedBox(height: 16),
                TextFormField(
                  controller: _overviewController,
                  decoration: InputDecoration(
                    labelText: 'Overview',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _budgetTypeController,
                  decoration: InputDecoration(
                    labelText: 'Budget Type',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _budgetValueController,
                  decoration: InputDecoration(
                    labelText: 'Budget Value',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _timelineController,
                  decoration: InputDecoration(
                    labelText: 'Timeline',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _scopeController,
                  decoration: InputDecoration(
                    labelText: 'Scope',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    submitDataToAPI(widget.projectId);
                  },
                  child: Text('Submit'),
                ),
              ],
            );
          }
        },
      ),
    );
  }



}