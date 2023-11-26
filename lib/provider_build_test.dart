import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: CounterProvderModel(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            // useMaterial3: true,
          ),
          home: const MyHomePage(),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    print('first build');
    final _counter = Provider.of<CounterProvderModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Provider demo 一级页面'),
      ),
      body: Center(
        child: Column(
          children: [
            ///展示资源中的数据
            ///
            Consumer(
                builder: (context, counter, _) =>
                    Text('Counter: ${_counter.counter}')),

            ///

            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SecondPage()));
                },
                child: Text('进入二级页面'))
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    print('second build');
    // final _counter = Provider.of<CounterProvderModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider demo 二级页面'),
      ),
      body: Center(
        child: Column(
          children: [
            ///展示资源中的数据
            Consumer<CounterProvderModel>(
                builder: (context, CounterProvderModel counter, _) =>
                    Text('Counter: ${counter.counter}')),

            Consumer<CounterProvderModel>(
                builder: (context, CounterProvderModel counter, _) {
              return ElevatedButton(
                  onPressed: () {
                    counter.increment();
                  },
                  child: const Icon(Icons.add));
            }),

            const TestView()
          ],
        ),
      ),
    );
  }
}

class TestView extends StatelessWidget {
  const TestView({super.key});

  @override
  Widget build(BuildContext context) {
    print('Test view build');
    return Container(width: 100, height: 100, color: Colors.red);
  }
}

class CounterProvderModel with ChangeNotifier {
  int _count = 0;
  int get counter => _count;
  void increment() {
    _count++;
    notifyListeners();
  }
}
