import 'package:flutter/material.dart';
import 'package:helloworld/other_screen.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});
  final counter = 1;

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        routerConfig: _router,
        title: 'GoRouter Example',
      );

  final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) =>
            const FirstScreen(),
        routes: <GoRoute>[
          GoRoute(
            path: 'second',
            builder: (BuildContext context, GoRouterState state) =>
                // ignore: prefer_const_constructors
                SecondScreen(label: 'a'),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => const ErrorScreen(),
  );
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My first app")),
      body: ListView(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.go('/second');
                  },
                  child: const Text('To second'),
                ),
                ...const [
                  HelloWord(),
                  HelloWorldPlus(-1),
                  HelloWorldPlus(-2, color: Colors.blue),
                  HelloWorldGenerator(3),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Text(
                      'Outer directionality',
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'Futura',
                        color: Colors.pinkAccent,
                      ),
                    ),
                  ),
                  Text(
                    'Inner direction',
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Futura',
                      color: Colors.pinkAccent,
                    ),
                  ),
                  StatefulSample(title: 'Sample title'),
                  TapBox(),
                  ParentWidget(),
                  MyRow(),
                  BlueBox(),
                  BlueBox(),
                  BlueBox(),
                  BlueBox(),
                  BlueBox(),
                  MyRow(),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StatefulSample extends StatefulWidget {
  final String title;
  const StatefulSample({super.key, required this.title});

  @override
  _StatefulSample createState() => _StatefulSample();
}

class _StatefulSample extends State<StatefulSample> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text('You have pressed this many times: '),
        Text(
          '$_counter',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        )
      ],
    );
  }
}

class HelloWord extends StatelessWidget {
  const HelloWord({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Hello World!!!",
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
    );
  }
}

class HelloWorldPlus extends StatelessWidget {
  final int number;
  final Color color;

  const HelloWorldPlus(this.number, {super.key, this.color = Colors.red});
  //const HelloWorldPlus(this.number, {this.color = Colors.red, Key? key})
  //  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Hello World $number",
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: color),
    );
  }
}

class HelloWorldGenerator extends StatelessWidget {
  final int count;
  const HelloWorldGenerator(this.count, {super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> childrenVar = [];
    for (int i = 0; i < count; i++) {
      childrenVar.add(HelloWorldPlus(i + 1,
          color:
              Color.fromRGBO(16 * i % 255, 32 * i % 255, 64 * i % 255, 1.0)));
    }
    return Column(children: childrenVar);
  }
}

class BlueBox extends StatelessWidget {
  const BlueBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all(),
      ),
    );
  }
}

class MyRow extends StatelessWidget {
  const MyRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            BlueBox(),
            SizedBox(
              width: 10,
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: BlueBox(),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 3,
              child: BlueBox(),
            ),
            SizedBox(
              width: 100,
              child: BlueBox(),
            ),
            Spacer(flex: 1),
            BlueBox(),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Icon(
              Icons.add_circle,
              size: 50,
              color: Colors.blue,
            ),
            Icon(
              Icons.widgets,
              size: 50,
              color: Colors.red,
            ),
          ],
        ),
        const Image(
          image: AssetImage('images/constellar.jpg'),
          height: 50,
        ),
        Image.network(
          'https://storage.googleapis.com/ygoprodeck.com/pics_artgame/29223325.jpg',
        ),
      ],
    );
  }
}

// Widget itself manages state
class TapBox extends StatefulWidget {
  const TapBox({super.key});

  @override
  State<TapBox> createState() => _TapBoxState();
}

class _TapBoxState extends State<TapBox> {
  bool _active = false;

  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        width: 100,
        height: 80,
        decoration: BoxDecoration(
          color: _active ? Colors.red : Colors.blue,
        ),
        child: Center(
          child: Text(
            _active ? 'W: Active' : 'W: Inactive',
            style: const TextStyle(fontSize: 16.0, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

// Parent manages state
class ParentWidget extends StatefulWidget {
  const ParentWidget({super.key});

  @override
  State<ParentWidget> createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  bool _active = false;

  void _handleTapboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChildrenWidget(
      active: _active,
      onChanged: _handleTapboxChanged,
    );
  }
}

class ChildrenWidget extends StatelessWidget {
  final bool active;
  final ValueChanged<bool> onChanged;

  const ChildrenWidget(
      {super.key, this.active = false, required this.onChanged});

  void _handleTap() {
    onChanged(!active);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        width: 100,
        height: 80,
        decoration: BoxDecoration(
          color: active ? Colors.red : Colors.blue,
        ),
        child: Center(
          child: Text(
            active ? 'P: Active' : 'P: Inactive',
            style: const TextStyle(fontSize: 16.0, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
