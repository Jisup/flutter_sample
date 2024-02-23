import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/entity/photo.dart';
import 'package:flutter_sample/util/dio_instance.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

final photoListProvider = StateProvider((ref) => <Photo>[]);

class PageViewInfinityCarousel extends ConsumerStatefulWidget {
  const PageViewInfinityCarousel({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PageViewInfinityCarouselState();
}

class _PageViewInfinityCarouselState
    extends ConsumerState<PageViewInfinityCarousel> {
  late PageController _pageController;

  int startIdx = 0, endIdx = 5, pixed = 5;

  bool isLoading = false;

  Timer? timer;

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

  _PageViewInfinityCarouselState() {
    startIdx = 0;
    endIdx = 5;
    _fetchPhotos();
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1);
  }

  @override
  void dispose() {
    if (timer != null) {
      timer!.cancel();
    }
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final photoList = ref.watch(photoListProvider);

    return Scaffold(
        appBar: AppBar(),
        body: Stack(
          alignment: Alignment.center,
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: (value) {
                if (photoList.length - 3 < value) {
                  _fetchPhotos();
                }
              },
              children: photoList.isNotEmpty
                  ? photoList
                      .map((photo) => Container(
                            child: Image.network(photo.url!),
                          ))
                      .toList()
                  : [],
            ),
            photoList.isNotEmpty
                ? Positioned(
                    bottom: 10,
                    child: SmoothPageIndicator(
                      controller: _pageController,
                      count: photoList.length,
                      effect: ScrollingDotsEffect(),
                      onDotClicked: (index) => _pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.bounceInOut,
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          ],
        ));
  }
}
