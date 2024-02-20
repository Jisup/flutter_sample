import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/entity/photo.dart';
import 'package:flutter_sample/util/dio_instance.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class InfinityScrollPaginationInfinityScroll extends ConsumerStatefulWidget {
  const InfinityScrollPaginationInfinityScroll({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _InfinityScrollPaginationInfinityScrollState();
}

class _InfinityScrollPaginationInfinityScrollState
    extends ConsumerState<InfinityScrollPaginationInfinityScroll> {
  late PagingController<int, Photo> _pagingController;

  int startIdx = 0, endIdx = 20, pixed = 20;

  late List<Photo> photoList = <Photo>[];

  bool isLoading = false;

  Future<void> _fetchPhotos(int pageKey) async {
    isLoading = true;
    Dio dio = DioInstance().dio;
    try {
      Response photoResponse = await dio.get('/photos');
      photoResponse.data.forEach((v) {
        photoList.add(Photo.fromJson(v));
      });

      final newPhotoList = photoList.getRange(startIdx, endIdx).toList();

      if (endIdx > 5000) {
        _pagingController.appendLastPage(newPhotoList);
      } else {
        final nextPageKey = pageKey + pixed;
        _pagingController.appendPage(newPhotoList, nextPageKey);
      }

      startIdx += pixed;
      endIdx += pixed;
      isLoading = false;
    } catch (e) {
      _pagingController.error = e;
    }
  }

  _InfinityScrollPaginationInfinityScrollState() {
    startIdx = 0;
    endIdx = 20;
  }

  @override
  void initState() {
    super.initState();
    _pagingController = PagingController(firstPageKey: 0);
    _pagingController.addPageRequestListener((pageKey) {
      if (!isLoading) {
        _fetchPhotos(pageKey);
      }
    });
  }

  @override
  void dispose() {
    startIdx = 0;
    endIdx = 20;
    photoList = [];
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          print('refresh');
        },
        child: PagedListView<int, Photo>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<Photo>(
            itemBuilder: (context, item, index) => Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${item.id.toString()} ${item.title}',
                          style: TextStyle(overflow: TextOverflow.ellipsis),
                        ),
                      ),
                    ],
                  ),
                  FractionallySizedBox(
                    widthFactor: 1,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Image.network(item.url!),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
