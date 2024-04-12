import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../DataModels/Project_details.dart';

class ProjectDetailsPage extends StatelessWidget {
  final String projectId;
  const ProjectDetailsPage({Key? key, required this.projectId}) : super(key: key);

  Future<ProjectDetails> fetchProjectDetails(String projectId) async {
    final response = await http.get(Uri.parse('https://b5mkgbw0-8000.inc1.devtunnels.ms/project/$projectId/project_details'));

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
        future: fetchProjectDetails(projectId),
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
            return data == null
                ? Center(child: Text('No project details found.'))
                : ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                if (data.sId != null)
                  Card(
                    child: ListTile(
                      title: Text('Project ID'),
                      trailing: Text(projectDetails.data?.first.sId ?? ''),
                    ),
                  ),
                if (data.name != null)
                  Card(
                    child: ListTile(
                      title: Text('Project Name'),
                      trailing: Text(projectDetails.data?.first.name ?? ''),
                    ),
                  ),
                if (data.overview != null)
                  Card(
                    child: ListTile(
                      title: Text('Overview'),
                      trailing: Text(projectDetails.data?.first.overview ?? ''),
                    ),
                  ),
                if (data.timeline != null)
                  Card(
                    child: ListTile(
                      title: Text('Timeline'),
                      trailing: Text(projectDetails.data?.first.timeline ?? ''),
                    ),
                  ),
                if (data.scope != null)
                  Card(
                    child: ListTile(
                      title: Text('Scope'),
                      trailing: Text(projectDetails.data?.first.scope ?? ''),
                    ),
                  ),
                if (data.startDate != null)
                  Card(
                    child: ListTile(
                      title: Text('Start Date'),
                      trailing: Text(projectDetails.data?.first.startDate ?? ''),
                    ),
                  ),
                if (data.status != null)
                  Card(
                    child: ListTile(
                      title: Text('Status'),
                      trailing: Text(projectDetails.data?.first.status ?? ''),
                    ),
                  ),
                if (data.budget?.type != null)
                  Card(
                    child: ListTile(
                      title: Text('Budget Type'),
                      trailing: Text(projectDetails.data?.first.budget?.type ?? ''),
                    ),
                  ),
                if (data.budget?.typeValue != null)
                  Card(
                    child: ListTile(
                      title: Text('Budget Value'),
                      trailing: Text(projectDetails.data?.first.budget?.typeValue ?? ''),
                    ),
                  ),
                if (data.stack?.label != null)
                  Card(
                    child: ListTile(
                      title: Text('Stack'),
                      trailing: Text(projectDetails.data?.first.stack?.label ?? ''),
                    ),
                  ),
                if (data.associatedManager?.name != null)
                  Card(
                    child: ListTile(
                      title: Text('Manager'),
                      trailing: Text(projectDetails.data?.first.associatedManager?.name ?? ''),
                    ),
                  ),
              ],
            );
          }
        },
      ),
    );
  }
}
