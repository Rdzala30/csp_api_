import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../DataModels/CreateProject.dart';
import '../DataModels/Manager.dart';
import '../DataModels/Project_details.dart';
import '../DataModels/project.dart';
import '../Services/ManagerService.dart';
import '../Services/ProjectService.dart';
import 'FillDetails.dart';
import 'ProjectDetails.dart';
import 'SideNavigationDrawer.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Projects> projects = [];
  List<Manager> managers = [];
  String? selectedManager;

  Future<void> fetchProjects() async {
    try {
      final projects = await ProjectService.fetchProjects();
      setState(() {
        this.projects = projects;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> fetchManagers() async {
    try {
      final managers = await ManagerService.fetchManagers();
      setState(() {
        this.managers = managers;
        selectedManager = managers.isNotEmpty ? managers.first.name : null;
      });
    } catch (e) {
      print('Error fetching manager data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchProjects();
    fetchManagers();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchProjects();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('API Data'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'All Projects'),
              Tab(text: 'On-Going'),
              Tab(text: 'Completed'),
              Tab(text: 'Hold'),
            ],
          ),
        ),
        drawer: SideNavigationDrawer(),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [
                  ProjectList(projects: projects),
                  ProjectList(projects: projects.where((project) => project.status == 'On-Going').toList()),
                  ProjectList(projects: projects.where((project) => project.status == 'Completed').toList()),
                  ProjectList(projects: projects.where((project) => project.status == 'Hold').toList()),
                ],
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}



class ProjectList extends StatelessWidget {
  final List<Projects> projects;

  const ProjectList({required this.projects});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: projects.length,
      itemBuilder: (context, index) {
        final project = projects[index];
        return Card(
          elevation: 2,
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: ListTile(
            title: Text(project.name),
            subtitle: Text(project.status),
            trailing: Text(project.date),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Confirmation'),
                    content: Text('Do you want to view project details or fill details?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => FillDetailsPage(projectId: project.id)));
                        },
                        child: Text('Fill Details'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProjectDetailsPage(projectId: project.id),
                            ),
                          );
                        },
                        child: Text('View Details'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
