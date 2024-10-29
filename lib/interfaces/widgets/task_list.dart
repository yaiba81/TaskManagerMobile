import 'package:flutter/material.dart';
import 'package:task_manager_mobile/domian/entiy/task.dart';
import 'package:intl/intl.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;
  final Function removeTask;

  const TaskList(this.tasks, this.removeTask, {super.key});

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
                    fit: BoxFit.cover,
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
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text('\$${tasks[index].taskType}'),
                      ),
                    ),
                  ),
                  title: Text(
                    tasks[index].taskName,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(tasks[index].dateTimeAssigned),
                  ),
                  trailing: MediaQuery.of(context).size.width > 360
                      ? TextButton.icon(
                          onPressed: () => removeTask(tasks[index].id),
                          icon: const Icon(Icons.update),
                          label: const Text('Update'))
                      : IconButton(
                          icon: const Icon(Icons.delete),
                          color: Theme.of(context).colorScheme.error,
                          onPressed: () => removeTask(tasks[index].id),
                        ),
                ),
              );
            },
            itemCount: tasks.length,
          );
  }
}
