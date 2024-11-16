import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager_mobile/domian/entiy/task.dart';
import 'package:task_manager_mobile/interfaces/pages/task_information.dart';
import 'package:task_manager_mobile/interfaces/widgets/task_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _selectedImage;

  void onPickImage(File file) {}

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (pickedImage == null) {
      return;
    }
    setState(() {
      _selectedImage = File(pickedImage.path);
    });

    onPickImage(_selectedImage!);
  }

  final List<Task> _userTasks = [
    Task(
      id: 1,
      taskIdentifier: "fuckyou",
      taskType: "personal",
      taskName: "myTask",
      details: "some details",
      status: "NEW",
      dateTimeCreated: DateTime.now(),
      dateTimeAssigned: DateTime.now(),
      dateTimeDue: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    Task(
      id: 2,
      taskIdentifier: "fuckyou",
      taskType: "personal",
      taskName: "myTask again",
      details: "some details",
      status: "NEW",
      dateTimeCreated: DateTime.now(),
      dateTimeAssigned: DateTime.now(),
      dateTimeDue: DateTime.now().add(const Duration(hours: 1)),
    ),
    Task(
      id: 3,
      taskIdentifier: "fuckyou",
      taskType: "personal",
      taskName: "myTask again again again again",
      details:
          "some details adding more details to test if it looks great on the UI of flutter just keep on writing keep safe.",
      status: "NEW",
      dateTimeCreated: DateTime.now(),
      dateTimeAssigned: DateTime.now().subtract(const Duration(days: 1)),
      dateTimeDue: DateTime.now().add(const Duration(hours: 1)),
    ),
  ];

  void _removeTask(int id) {
    setState(() {
      _userTasks.removeWhere((tx) => tx.id == id);
    });
  }

  void _viewTaskInfo(int id) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => TaskInformation(_userTasks.elementAt(id - 1))),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      leading: Image.asset(
        'assets/icons/inventory.png',
        fit: BoxFit.fill,
        alignment: Alignment.center,
      ),
      title: const Text(
        'Task Manager',
        style: TextStyle(fontFamily: 'Open Sans'),
      ),
      actions: <Widget>[
        IconButton(onPressed: () => {}, icon: const Icon(Icons.add))
      ],
    );
    final txListWidget = SizedBox(
        height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.7,
        child: TaskList(_userTasks, _viewTaskInfo));
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            txListWidget,
          ],
        ),
      ),
    );
  }
}
