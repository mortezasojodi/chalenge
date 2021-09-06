import 'dart:convert';

import 'package:behtarino/Common/ErrorHandling.dart';
import 'package:behtarino/Common/Helper/LocalStorage.dart';
import 'package:behtarino/Model/Home/Contact.dart';
import 'package:behtarino/repository/Core/Repository.dart';
import 'package:behtarino/repository/Core/RepositoryMethod.dart';
import 'package:dio/dio.dart';

class GetContactsRepository implements RepositoryMethod<Contact> {
  Future<List<Contact>> fetchList({String? Url}) async {
    List<Contact> contactLst = [];
    var token = await localStorageGet("Token");
    return MsaGet(Url, header: {"Authorization": "Token $token"}).then((value) {
      if (value == null ||
          value.statusCode! < 200 ||
          value.statusCode! >= 300) {
        throw new FetchDataException("خطایی رخ داد");
      }
      final List contactItems = value.data["data"];
      contactLst = contactItems
          .map((contactRaw) => new Contact.fromMap(contactRaw))
          .toList();
      return contactLst;
    });
  }
}
