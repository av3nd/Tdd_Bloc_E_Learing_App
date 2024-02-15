import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tdd_tutorial_flutter/core/errors/exceptions.dart';
import 'package:tdd_tutorial_flutter/core/utils/constants.dart';
import 'package:tdd_tutorial_flutter/core/utils/typedef.dart';
import 'package:tdd_tutorial_flutter/src/authetication/data/models/user_model.dart';

abstract class AuthenticationRemoteDataSource {
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });
  Future<List<UserModel>> getUsers();
}

const kCreateUserEndpoint = '/test-api/users';
const kGetUsersEndpoint = '/test-api/users';

class AuthRemoteDataSrcImpl implements AuthenticationRemoteDataSource {
  final http.Client _client;
  const AuthRemoteDataSrcImpl(this._client);
  @override
  Future<void> createUser(
      {required String createdAt,
      required String name,
      required String avatar}) async {
    try {
      final response = await _client.post(
          Uri.https(kBaseUrl,kCreateUserEndpoint),
          body: jsonEncode(
              {'createdAt': createdAt, 'name': name, avatar: avatar}),
              headers: {  
                'Content-Type':'application/json'
              });
              
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<List<UserModel>> getUsers() async {
   try{
     final response = await _client.get(
      Uri.https(kBaseUrl, kGetUsersEndpoint),
      );
    if(response.statusCode != 200){
      throw APIException(message: response.body,statusCode: response.statusCode);
    }
    return List<DataMap>.from(jsonDecode(response.body) as List)
        .map((userData) => UserModel.fromMap(userData))
        .toList();
   }on APIException{
    rethrow;
   }catch(e){
    throw APIException(message: e.toString(), statusCode: 505);
   
   }

  }
}
