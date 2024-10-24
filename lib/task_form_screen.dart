// lib/task_form_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'task.dart';
import 'task_provider.dart';

class TaskFormScreen extends StatelessWidget {
  final Task? task;

  const TaskFormScreen({super.key, this.task});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: task?.title);
    final descriptionController = TextEditingController(text: task?.description);

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.orange.shade400,
        title: Text(task == null ? 'Add Task' : 'Edit Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Task Title'),
            ),
            TextField( 
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () {
                final newTask = Task(
                  id: task?.id ?? DateTime.now().toString(),
                  title: titleController.text,
                  description: descriptionController.text,
                );

                if (task == null) {
                  Provider.of<TaskProvider>(context, listen: false).addTask(newTask);
                } else {
                  Provider.of<TaskProvider>(context, listen: false).updateTask(newTask);
                }

                Navigator.pop(context);
              },
              child:const Text('Save'),
              
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}
