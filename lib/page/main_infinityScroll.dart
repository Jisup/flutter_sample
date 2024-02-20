import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/config/static_list_config.dart';
import 'package:go_router/go_router.dart';

class MainInfinityScroll extends ConsumerWidget {
  const MainInfinityScroll({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(builder:
            (BuildContext childContext, BoxConstraints viewportConstraint) {
          return ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: viewportConstraint.maxWidth,
                minHeight: viewportConstraint.maxHeight,
              ),
              child: Container(
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Wrap(
                    runSpacing: 25,
                    children: StaticListConfig.InfinityScrollDemoList.map(
                      (demo) => GestureDetector(
                        onTap: () => context.push(demo['path']),
                        child: FractionallySizedBox(
                          widthFactor: 1,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(demo['text']),
                          ),
                        ),
                      ),
                    ).toList(),
                  ),
                ),
              ));
        }),
      ),
    );
  }
}
