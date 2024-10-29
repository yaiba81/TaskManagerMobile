import 'package:flutter/material.dart';
import 'package:task_manager_mobile/domian/entiy/task.dart';
import 'package:task_manager_mobile/interfaces/widgets/task_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Task> _userTasks = [];

  void _removeTask(int id) {
    setState(() {
      _userTasks.removeWhere((tx) => tx.id == id);
    });
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
        child: TaskList(_userTasks, _removeTask));
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
