import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatefulWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WealthAppTest - Simple Todo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.indigo,
      ),
      themeMode: _themeMode,
      home: HomePage(onToggleTheme: _toggleTheme),
    );
  }
}

class Task {
  String title;
  String? note;
  bool done;

  Task({required this.title, this.note, this.done = false});

  factory Task.fromJson(Map<String, dynamic> j) => Task(
        title: j['title'] as String,
        note: j['note'] as String?,
        done: j['done'] as bool? ?? false,
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'note': note,
        'done': done,
      };
}

class HomePage extends StatefulWidget {
  final VoidCallback onToggleTheme;
  const HomePage({Key? key, required this.onToggleTheme}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> _tasks = [];
  bool _loading = true;
  final _prefsKey = 'wealthapptest.tasks';

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    setState(() => _loading = true);
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_prefsKey);
    if (raw != null) {
      try {
        final arr = jsonDecode(raw) as List<dynamic>;
        _tasks = arr.map((e) => Task.fromJson(e as Map<String, dynamic>)).toList();
      } catch (e) {
        _tasks = [];
      }
    } else {
      _tasks = [];
    }
    setState(() => _loading = false);
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = jsonEncode(_tasks.map((t) => t.toJson()).toList());
    await prefs.setString(_prefsKey, raw);
  }

  void _addOrEditTask({Task? task, int? index}) async {
    final titleController = TextEditingController(text: task?.title ?? '');
    final noteController = TextEditingController(text: task?.note ?? '');

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(task == null ? 'Add task' : 'Edit task'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              autofocus: true,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: noteController,
              decoration: const InputDecoration(labelText: 'Note (optional)'),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          ElevatedButton(onPressed: () {
            final title = titleController.text.trim();
            if (title.isEmpty) return;
            if (task == null) {
              setState(() {
                _tasks.add(Task(title: title, note: noteController.text.trim()));
              });
            } else {
              setState(() {
                _tasks[index!] = Task(title: title, note: noteController.text.trim(), done: task.done);
              });
            }
            _saveTasks();
            Navigator.pop(context, true);
          }, child: const Text('Save')),
        ],
      ),
    );

    if (result == true) {
      // saved
    }
  }

  void _toggleDone(int index) {
    setState(() {
      _tasks[index].done = !_tasks[index].done;
    });
    _saveTasks();
  }

  void _removeTask(int index) {
    showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete task'),
        content: const Text('Are you sure you want to delete this task?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          ElevatedButton(onPressed: () {
            setState(() {
              _tasks.removeAt(index);
            });
            _saveTasks();
            Navigator.pop(context, true);
          }, child: const Text('Delete')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Todo'),
        actions: [
          IconButton(onPressed: widget.onToggleTheme, icon: const Icon(Icons.brightness_2)),
          IconButton(onPressed: _loadTasks, icon: const Icon(Icons.refresh)),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _tasks.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('No tasks yet', style: TextStyle(fontSize: 18)),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () => _addOrEditTask(),
                        child: const Text('Add your first task'),
                      )
                    ],
                  ),
                )
              : ListView.separated(
                  itemCount: _tasks.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, i) {
                    final t = _tasks[i];
                    return ListTile(
                      leading: Checkbox(value: t.done, onChanged: (_) => _toggleDone(i)),
                      title: Text(
                        t.title,
                        style: TextStyle(
                          decoration: t.done ? TextDecoration.lineThrough : TextDecoration.none,
                        ),
                      ),
                      subtitle: t.note == null || t.note!.isEmpty ? null : Text(t.note!),
                      trailing: PopupMenuButton<String>(
                        onSelected: (v) {
                          if (v == 'edit') _addOrEditTask(task: t, index: i);
                          if (v == 'delete') _removeTask(i);
                        },
                        itemBuilder: (_) => [
                          const PopupMenuItem(value: 'edit', child: Text('Edit')),
                          const PopupMenuItem(value: 'delete', child: Text('Delete')),
                        ],
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addOrEditTask(),
        child: const Icon(Icons.add),
      ),
    );
  }
}