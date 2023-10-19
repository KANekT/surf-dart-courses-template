import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter = 0;
  int _clickAdd = 0;
  int _clickRemove = 0;
  bool _lessThanZero = false;

  void _increment() {
    setState(() {
      _counter++;
      _clickAdd++;
      _lessThanZero = false;
    });
  }

  void _decrement() {
    setState(() {
      if (_counter > 0) {
        _counter--;
        _lessThanZero = false;
      } else {
        _lessThanZero = true;
      }
      _clickRemove++;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _increment,
              child: const Icon(Icons.add),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: _decrement,
              child: const Icon(Icons.remove),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(width: 16),
            Text('Текущее значение: $_counter'),
            const SizedBox(width: 16),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Нажато Прибавить: $_clickAdd'),
            const SizedBox(width: 16),
            Text('Нажато Отнять: $_clickRemove'),
          ],
        ),
        const SizedBox(height: 16),
        if (_lessThanZero) const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Значение должно быть больше нуля',
              style: TextStyle(color: Colors.deepOrange),),
          ],
        )
      ],
    );
  }
}

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Counter(),
        ),
      ),
    ),
  );
}