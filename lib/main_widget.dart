import 'package:flutter/material.dart';

enum SquareSize { petit, grand }

class MainWidget extends StatefulWidget {
  const MainWidget({super.key});

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> with TickerProviderStateMixin {
  SquareSize currentSquareSize = SquareSize.grand;
  late AnimationController _controller;
  late Animation<double> _curve;
  late Animation<double> _tweenSize;
  late Animation<Color?> _tweenColor;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _curve = CurvedAnimation(parent: _controller, curve: Curves.bounceIn);

    _tweenSize = Tween(begin: 200.0, end: 50.0).animate(_curve);

    _tweenColor =
        ColorTween(begin: Colors.blue, end: Colors.red).animate(_curve);

    _tweenSize.addListener(() {
      setState(() {});
      print(_tweenSize.value);
    });
  }

  void switchSquare() {
    currentSquareSize == SquareSize.grand
        ? _controller.forward()
        : _controller.reverse();

    setState(() {
      currentSquareSize = currentSquareSize == SquareSize.grand
          ? SquareSize.petit
          : SquareSize.grand;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 60),
      alignment: Alignment.center,
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Container(
                height: _tweenSize != null ? _tweenSize.value : 200,
                width: _tweenSize != null ? _tweenSize.value : 200,
                color: _tweenColor != null ? _tweenColor.value : Colors.blue,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: switchSquare,
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.green)),
            child: const Text(
              'change size',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
