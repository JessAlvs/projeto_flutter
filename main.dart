import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/calendar_screen.dart';

void main() {
  runApp(const GerenciadorTarefasApp());
}

class GerenciadorTarefasApp extends StatelessWidget {
  const GerenciadorTarefasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gerenciador de Tarefas',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/calendar': (context) => const CalendarScreen(),
      },
    );
  }
}
