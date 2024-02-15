import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/util/dio_instance.dart';

class Photo {
  int? albumId;
  int? id;
  String? title;
  String? url;
  String? thumbnailUrl;

  Photo({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

  Photo.fromJson(Map<String, dynamic> json) {
    albumId = json['albumId'];
    id = json['id'];
    title = json['title'];
    url = json['url'];
    thumbnailUrl = json['thumbnailUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['albumId'] = this.albumId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['url'] = this.url;
    data['thumbnailUrl'] = this.thumbnailUrl;
    return data;
  }
}

final photoListProvider = StateProvider((ref) => <Photo>[]);

class ListViewInfinityScroll extends ConsumerStatefulWidget {
  const ListViewInfinityScroll({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ListViewInfinityScrollState();
}

class _ListViewInfinityScrollState
    extends ConsumerState<ListViewInfinityScroll> {
  double pullHeight = 0.0;
  double contentHeight = 200.0;
  double scrollVelocity = 2.4;

  late ScrollController _scrollController;

  int startIdx = 0, endIdx = 20, pixed = 20;

  late List<Photo> photoList = <Photo>[];

  bool isLoading = false;

  Future<void> _fetchPhotos() async {
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

  _ListViewInfinityScrollState() {
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

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
  }

  @override
  void dispose() {
    startIdx = 0;
    endIdx = 20;
    photoList = [];
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final photoList = ref.watch(photoListProvider);

    return Listener(
      onPointerMove: (event) {
        if (event.delta.dy >= 0) return;
        if (_scrollController.position.maxScrollExtent - contentHeight <
            _scrollController.position.pixels) return;
        setState(() {
          pullHeight += -event.delta.dy;
        });
      },
      onPointerUp: (event) async {
        if (pullHeight > contentHeight && !isLoading) {
          setState(() {
            pullHeight = contentHeight;
          });
          await _fetchPhotos();
          Timer(Duration(milliseconds: 1000), () {
            setState(() {
              pullHeight = 0;
            });
          });
        } else {
          setState(() {
            pullHeight = 0;
          });
        }
      },
      child: Scaffold(
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
                                style:
                                    TextStyle(overflow: TextOverflow.ellipsis),
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
      ),
    );
  }
}
