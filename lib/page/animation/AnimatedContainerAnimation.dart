import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnimatedContainerAnimation extends ConsumerStatefulWidget {
  const AnimatedContainerAnimation({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AnimatedContainerAnimationState();
}

class _AnimatedContainerAnimationState
    extends ConsumerState<AnimatedContainerAnimation> {
  int containerType = 1;
  List<dynamic> containerInfo = [
    {'type': 1, 'text': '300, 300,\nred, topLeft'},
    {'type': 2, 'text': '200, 200,\nyellow, topRight'},
    {'type': 3, 'text': '100, 100,\nblue, bottomLeft'},
    {'type': 4, 'text': '50, 50,\ngreen, center'},
  ];

  void buttonClick({required int type}) {
    if (containerType != type) {
      setState(() {
        containerType = type;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('버튼을 클릭하면 위젯 변화'),
              FractionallySizedBox(
                widthFactor: 1,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(
                      child: AnimatedContainer(
                        width: switch (containerType) {
                          1 => 300,
                          2 => 200,
                          3 => 100,
                          4 => 50,
                          _ => 0,
                        },
                        height: switch (containerType) {
                          1 => 300,
                          2 => 200,
                          3 => 100,
                          4 => 50,
                          _ => 0,
                        },
                        alignment: switch (containerType) {
                          1 => Alignment.topLeft,
                          2 => Alignment.topRight,
                          3 => Alignment.bottomLeft,
                          4 => Alignment.center,
                          _ => Alignment.center,
                        },
                        color: switch (containerType) {
                          1 => Colors.red,
                          2 => Colors.yellow,
                          3 => Colors.blue,
                          4 => Colors.green,
                          _ => Colors.black,
                        },
                        duration: const Duration(seconds: 1),
                        curve: Curves.fastOutSlowIn,
                        child: Image.asset(
                          'lib/page/animation/assets/flutter_logo.png',
                          fit: BoxFit.contain,
                          width: MediaQuery.of(context).size.width / 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Wrap(
                children: containerInfo.map((info) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width / 2.25,
                    child: TextButton(
                        onPressed: () => buttonClick(type: info['type']),
                        child: Text(
                          info['text'],
                          textAlign: TextAlign.center,
                        )),
                  );
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
