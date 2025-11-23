import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/task.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  List<Task> tasks = [];

  // Função para adicionar tarefa
  void _addTask(String title) {
    setState(() {
      tasks.add(Task(title: title));
      _sortTasks();
    });
  }

  // Função para remover tarefa
  void _removeTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  // Função para alternar concluída
  void _toggleTask(int index) {
    setState(() {
      tasks[index].completed = !tasks[index].completed;
      _sortTasks();
    });
  }

  // Ordenar tarefas: pendentes primeiro, concluídas depois, ambas em ordem alfabética
  void _sortTasks() {
    tasks.sort((a, b) {
      if (a.completed == b.completed) {
        return a.title.toLowerCase().compareTo(b.title.toLowerCase());
      }
      return a.completed ? 1 : -1;
    });
  }

  // Mostrar diálogo para adicionar tarefa
  void _showAddTaskDialog() {
    String newTask = '';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.purple[100], // fundo roxo pastel
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          'Adicionar Tarefa',
          style: TextStyle(color: Colors.purple[900], fontWeight: FontWeight.bold),
        ),
        content: TextField(
          autofocus: true,
          onChanged: (value) => newTask = value,
          decoration: InputDecoration(
            hintText: 'Digite o nome da tarefa',
            filled: true,
            fillColor: Colors.purple[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancelar',
              style: TextStyle(color: Colors.purple[900]),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (newTask.isNotEmpty) _addTask(newTask);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple[700],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Adicionar'),
          ),
        ],
      ),
    );
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Calendário de Tarefas'),
      backgroundColor: Colors.purple[700],
    ),
    backgroundColor: Colors.purple[50],
    floatingActionButton: FloatingActionButton(
      onPressed: _showAddTaskDialog,
      backgroundColor: Colors.purple[700],
      child: const Icon(Icons.add),
    ),
    body: Column(
  children: [
    // --- CALENDÁRIO AQUI ---
    TableCalendar(
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: DateTime.now(),
      calendarFormat: CalendarFormat.month,
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.purple[900],
        ),
      ),
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Colors.purple[300],
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: Colors.purple,
          shape: BoxShape.circle,
        ),
      ),
    ),

    const SizedBox(height: 10),

    // --- LISTA DE TAREFAS ---
    Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return Card(
            color: task.completed ? Colors.purple[200] : Colors.purple[100],
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              title: Text(
                task.title,
                style: TextStyle(
                  decoration: task.completed ? TextDecoration.lineThrough : null,
                  fontWeight: FontWeight.w500,
                  color: Colors.purple[900],
                ),
              ),
              leading: Checkbox(
                value: task.completed,
                onChanged: (_) => _toggleTask(index),
                activeColor: Colors.purple[700],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => _removeTask(index),
                color: Colors.purple[900],
              ),
            ),
          );
        },
      ),
    ),

    Container(
      padding: const EdgeInsets.all(12),
      color: Colors.purple[100],
      width: double.infinity,
      child: Text(
        'Feito por mim: Jess Alves <3',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.purple[900],
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ],
),
  );
}
}