import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_manager_mobile/domian/entiy/task.dart';
import 'package:task_manager_mobile/interfaces/widgets/forms/update_task_form.dart';

class TaskInformation extends StatefulWidget {
  final Task task;

  const TaskInformation(this.task, {super.key});

  @override
  State<TaskInformation> createState() => _TaskInformationState();
}

class _TaskInformationState extends State<TaskInformation> {
  void _updateTask(
      String status, String remarks, String image, DateTime updatedDateTime) {}

  void _showUpdateTaskForm(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior.opaque,
              child: UpdateTaskForm(_updateTask));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Information'),
        actions: <Widget>[
          IconButton(
              onPressed: () => _showUpdateTaskForm(context),
              icon: const Icon(Icons.update)),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            children: <Widget>[
              Card(
                  elevation: 5,
                  child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                          top: 20, left: 10, right: 10, bottom: 20),
                      child: Text(
                        'Title: ${widget.task.taskName}',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ))),
              Card(
                  elevation: 5,
                  child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                          top: 20, left: 10, right: 10, bottom: 20),
                      child: Text(
                        'Type: ${widget.task.taskType}',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ))),
              Card(
                  elevation: 5,
                  child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                          top: 20, left: 10, right: 10, bottom: 20),
                      child: Text(
                        widget.task.dateTimeDue.isBefore(DateTime.now())
                            ? 'Status: DUE'
                            : DateFormat('yyyy-MM-dd')
                                    .parse(
                                        widget.task.dateTimeAssigned.toString())
                                    .isAtSameMomentAs(DateFormat('yyyy-MM-dd')
                                        .parse(DateTime.now().toString()))
                                ? 'Status: NEW'
                                : 'Status: WARNING',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ))),
              Card(
                  elevation: 5,
                  child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                          top: 20, left: 10, right: 10, bottom: 20),
                      child: Text(
                        'Details: ${widget.task.details}',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ))),
              Card(
                  elevation: 5,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                        top: 20, left: 10, right: 10, bottom: 20),
                    child: Text(
                      'Date Time Assigned: ${widget.task.dateTimeAssigned}',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
              Card(
                  elevation: 5,
                  child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                          top: 20, left: 10, right: 10, bottom: 20),
                      child: Text(
                        'Date Time Due: ${widget.task.dateTimeDue}',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
