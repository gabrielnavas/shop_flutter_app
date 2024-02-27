import 'package:flutter/material.dart';
import 'package:shop_flutter_app/providers/counter.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  @override
  Widget build(BuildContext context) {
    final CounterProvider? counterProvider = CounterProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text(
          'Exemplo contador',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Text(counterProvider!.counterState.value.toString()),
          IconButton(
            onPressed: () {
              setState(() {
                counterProvider.counterState.inc();
              });
              print(counterProvider.counterState.value);
            },
            icon: Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                counterProvider.counterState.dec();
              });
              print(counterProvider.counterState.value);
            },
            icon: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
