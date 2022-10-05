import 'package:flutter/material.dart';
import 'package:helloworld/calculator.dart';

class Factorial extends StatefulWidget {
  //Update only connection with parent, NO STRONG COUPLING WITH CALC
  final Function update;
  const Factorial(this.update, {Key? key}) : super(key: key);

  @override
  _FactorialState createState() => _FactorialState();
}

class _FactorialState extends State<Factorial> {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w500,
            color: Colors.blue,
          ),
          controller: myController,
        ),
        TextButton(
          style: buttonStyle,
          onPressed: () {
            //widget.update is Factorial object property update!!!
            widget.update(
              factorial(
                int.parse(myController.text),
              ),
            );
            myController.clear();
          },
          child: const Text("FACTORIAL"),
        )
      ],
    );
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }
}

var buttonStyle = TextButton.styleFrom(
  primary: Colors.white,
  backgroundColor: Colors.greenAccent,
);

/* 
STATELESS
class Factorial extends StatelessWidget {
  final Function update;
  final myController = TextEditingController();
  Factorial(this.update, {Key? key}) : super(key: key);

  void calculateFactorial(int n) {
    int res = factorial(n);
    //I need to send the res to the parent, parent passes an update function
    update(res);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextField(
          textAlign: TextAlign.center,
          controller: myController,
        ),
        TextButton(
          onPressed: () {
            calculateFactorial(int.parse(myController.text));
          },
          child: const Text("FACTORIAL"),
        ),
      ],
    );
  }
}

*/