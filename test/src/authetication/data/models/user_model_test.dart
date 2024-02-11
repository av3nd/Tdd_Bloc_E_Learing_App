import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_tutorial_flutter/core/utils/typedef.dart';
import 'package:tdd_tutorial_flutter/src/authetication/data/models/user_model.dart';
import 'package:tdd_tutorial_flutter/src/authetication/domain/entities/user.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tModel = UserModel.empty();

  test('should be subclass of [User] entity', () {
    //Arrange

    //Act

    //Assert
    expect(tModel, isA<User>());
  });

  final tJson = fixture('user.json');
  final tMap = jsonDecode(tJson) as DataMap;
  group('fromMap', () {
    test('should return a [UserModel] with the right data', () {
      final result = UserModel.fromMap(tMap);
      expect(result, equals(tModel));
    });
  });

  group('fromJson', () {
    test('should return a [UserModel] with the right data', () {
      final result = UserModel.fromJson(tJson);
      expect(result, equals(tModel));
    });
  });

  group('toMap', () {
    test('Should return a [Map] with the right data', () {
      final result = tModel.toMap();
      expect(result, equals(tMap));
    });
  });

  group('toJson', () {
    test('Should return a [Json] String with the right data', () {
      final result = tModel.toJson();
      final tJson = jsonEncode({
        "id": "1",
        "avatar": "_empty.avatar",
        "createdAt": "_empty.createdAt",
        "name": "_empty.name"
      });
      expect(result, tJson);
    });
  });

  group('copyWith', () {
    test('should return a [UserModel] with different data', () {
      final result = tModel.copyWith(name: 'Paul');
      expect(result.name, equals('Paul'));
      // expect(result.name, not(tModel));

    });
  });
}
