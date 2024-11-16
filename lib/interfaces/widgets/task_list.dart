import 'package:flutter/material.dart';
import 'package:task_manager_mobile/domian/entiy/task.dart';
import 'package:intl/intl.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;
  final Function taskInfo;

  const TaskList(this.tasks, this.taskInfo, {super.key});

  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                const Text('No task added yet!'),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: GestureDetector(
                  onTap: () => taskInfo(tasks[index].id),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: tasks[index]
                              .dateTimeDue
                              .isBefore(DateTime.now())
                          ? Colors.red
                          : DateFormat('yyyy-MM-dd')
                                  .parse(
                                      tasks[index].dateTimeAssigned.toString())
                                  .isAtSameMomentAs(DateFormat('yyyy-MM-dd')
                                      .parse(DateTime.now().toString()))
                              ? Colors.green
                              : Colors.amber,
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text(tasks[index]
                                  .dateTimeDue
                                  .isBefore(DateTime.now())
                              ? 'DUE'
                              : DateFormat('yyyy-MM-dd')
                                      .parse(tasks[index]
                                          .dateTimeAssigned
                                          .toString())
                                      .isAtSameMomentAs(DateFormat('yyyy-MM-dd')
                                          .parse(DateTime.now().toString()))
                                  ? 'NEW'
                                  : 'WARN'),
                        ),
                      ),
                    ),
                    title: Text(
                      tasks[index].taskName,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                ),
              );
            },
            itemCount: tasks.length,
          );
  }
}
