import 'package:dio/dio.dart';
import 'package:flutter_sample/demo/infinityScroll/ListView_infinityScroll.dart';
import 'package:flutter_sample/util/dio_instance.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Dio dio = DioInstance().dio;

  test('should get a list of photos from jsonplaceholder', () async {
    // arrange
    // act
    final result = await dio.get('/photos');
    // assert
    final photos = <Photo>[];
    result.data.forEach((v) {
      photos.add(new Photo.fromJson(v));
    });
    print(photos);
  });
}
