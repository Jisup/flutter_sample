import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/entity/photo.dart';
import 'package:flutter_sample/util/dio_instance.dart';

final photoListProvider = StateProvider((ref) => <Photo>[]);

class ScrollControllerInfinifyScroll extends ConsumerStatefulWidget {
  const ScrollControllerInfinifyScroll({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ScrollControllerInfinifyScrollState();
}

class _ScrollControllerInfinifyScrollState
    extends ConsumerState<ScrollControllerInfinifyScroll> {
  double pullHeight = 0.0;
  double contentHeight = 200.0;
  double scrollVelocity = 2.4;

  late ScrollController _scrollController;

  int startIdx = 0, endIdx = 20, pixed = 20;

  bool isLoading = false;

  Future<void> _fetchPhotos() async {
    List<Photo> photoList = <Photo>[];

    isLoading = true;
    Dio dio = DioInstance().dio;
    try {
      Response photoResponse = await dio.get('/photos');
      photoResponse.data.forEach((v) {
        photoList.add(Photo.fromJson(v));
      });

      ref.read(photoListProvider.notifier).update((state) =>
          [...state, ...photoList.getRange(startIdx, endIdx).toList()]);

      startIdx += pixed;
      endIdx += pixed;
      isLoading = false;
    } catch (e) {
      throw Error();
    }
  }

  _ScrollControllerInfinifyScrollState() {
    startIdx = 0;
    endIdx = 20;
    _fetchPhotos();
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() async {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    // if (maxScroll != currentScroll) {
    if (maxScroll - currentScroll < contentHeight) {
      if (!isLoading) {
        setState(() {
          pullHeight = contentHeight;
        });
        await _fetchPhotos();
      }
      setState(() {
        pullHeight = 0;
      });
    }
  }

  @override
  void dispose() {
    startIdx = 0;
    endIdx = 20;
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final photoList = ref.watch(photoListProvider);

    return Scaffold(
      appBar: AppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          print('refresh');
        },
        child: ListView.builder(
          controller: _scrollController,
          physics: ClampingScrollPhysics(),
          itemCount: photoList.length,
          itemBuilder: (context, index) {
            return index >= photoList.length - 1
                ? AnimatedContainer(
                    height: pullHeight,
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      color: Colors.red,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  )
                : Container(
                    child: Column(children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${photoList[index].id.toString()} ${photoList[index].title}',
                              style: TextStyle(overflow: TextOverflow.ellipsis),
                            ),
                          ),
                        ],
                      ),
                      FractionallySizedBox(
                          widthFactor: 1,
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Image.network(photoList[index].url!),
                          )),
                    ]),
                  );
          },
        ),
      ),
    );
  }
}
