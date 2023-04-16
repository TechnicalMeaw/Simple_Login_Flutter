import 'package:flutter/material.dart';
import 'package:test/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: Scaffold(
        appBar: AppBar(title: const Text("My app")),
        body: const SecondScreen(),
      ),
    );
  }
}

class MyRoot extends StatefulWidget {
  const MyRoot({super.key});

  @override
  State<MyRoot> createState() {
    return _MyRootState();
  }
}

class _MyRootState extends State<MyRoot> {
  ValueNotifier<int> count = ValueNotifier<int>(0);
  // int count = 0;
  void add() {
    count.value = count.value + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // setState(() {
            //   add();
            // });
            add();
          },
          child: const Icon(Icons.add),
        ),
        body: ValueListenableBuilder<int>(
          builder: (BuildContext context, value, Widget? child) {
            return Center(child: Text("the value is $value"));
          },
          valueListenable: count,
        ));
  }
}
