import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RotationExampleAnimatedBuilder extends ConsumerStatefulWidget {
  const RotationExampleAnimatedBuilder({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RotationExampleAnimatedBuilderState();
}

class _RotationExampleAnimatedBuilderState
    extends ConsumerState<RotationExampleAnimatedBuilder>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
              const Text('애니메이션 자동 재생'),
              FractionallySizedBox(
                widthFactor: 1,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: AnimatedBuilder(
                      animation: _animationController,
                      child: Center(
                        child: Image.asset(
                          'lib/page/animation/assets/flutter_logo.png',
                          // 'lib/page/animation/assets/sample.png',
                          fit: BoxFit.contain,
                          width: MediaQuery.of(context).size.width / 4,
                          // width: MediaQuery.of(context).size.width / 2,
                        ),
                      ),
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: _animationController.value * 2.0 * math.pi,
                          child: child,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
