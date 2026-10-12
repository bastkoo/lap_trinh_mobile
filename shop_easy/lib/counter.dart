import 'package:flutter/material.dart';

class MyCounter extends StatefulWidget {
  MyCounter({super.key});

  @override
  State<MyCounter> createState() => _MyCounterState();
}

class _MyCounterState extends State<MyCounter> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: Column(
        children: [
          Center(child: Text('Bộ đếm hiện tại là: $_counter')),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _counter++;
              });
              print('Bộ đếm hiện tại là: $_counter');
            },
            child: const Text('Tăng'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _counter--;
              });
              print('Bộ đếm hiện tại là: $_counter');
            },
            child: const Text('Giảm'),
          ),
        ],
      ),
    );
  }
}
