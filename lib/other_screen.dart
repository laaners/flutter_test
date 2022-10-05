import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Error page"),
      ),
      body: const Center(
        child: Text("Errore!!"),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  final String label;
  const SecondScreen({super.key, required this.label});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route asdsss'),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    context.go('/');
                  },
                  child: Text('Go back! $label'),
                ),
              ),
              Container(
                width: 50,
                height: 1000,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border.all(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ScreenArguments {
  final String title;
  final String message;

  ScreenArguments(this.title, this.message);
}

class ExtractArgumentsScreen extends StatelessWidget {
  const ExtractArgumentsScreen({super.key});
  static const routeName = '/extractArguments';
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(args.title),
      ),
      body: Center(
        child: Text(args.message),
      ),
    );
  }
}
