import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  int count = 0;

  void decrement() {
    setState(() {
      count--;
    });

    print('decrement');
  }

  void increment() {
    setState(() {
      count++;
    });
    print('increment');
  }
  bool get isEmpty => count == 0;
  bool get isFull => count == 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.red,
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('image/body.jpg'), fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isFull ? 'Lotado':'Pode entrar',
                style: TextStyle(
                    fontSize: 30,
                    color: isFull? Colors.red: Colors.white,
                    fontWeight: FontWeight.w700),
              ),
              Padding(
                padding: const EdgeInsets.all(50),
                child: Text(
                  count.toString(),
                  style: TextStyle(
                    fontSize: 100,
                    color: isFull ? Colors.red: (isEmpty? Colors.blue: Colors.white),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: isEmpty? null:  decrement,
                    style: TextButton.styleFrom(
                        backgroundColor: isEmpty? Colors.white.withOpacity(0.2): Colors.white,
                        fixedSize: const Size(100, 100),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24))),
                    child: const Text(
                      'Saiu',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 32,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: isFull? Colors.white.withOpacity(0.2): Colors.white,
                        fixedSize: const Size(100, 100),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24))),
                    onPressed: isFull? null: increment,
                    child: const Text(
                      'Entrou',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
