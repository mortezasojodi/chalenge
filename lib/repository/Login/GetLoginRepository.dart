import 'package:behtarino/Common/ErrorHandling.dart';
import 'package:behtarino/Common/Extentions/StringExtentions.dart';
import 'package:behtarino/Common/Helper/LocalStorage.dart';
import 'package:behtarino/repository/Core/Repository.dart';
import 'package:behtarino/repository/Core/RepositoryMethod.dart';

class GetLoginRepository implements RepositoryMethodBit {
  Future<bool> fetchBit({Object? body, String? Url}) {
    bool success = false;
    return MsaPost(
      Url,
      body: body,
      header: {
        "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
      },
    ).then((value) {
      if (value == null ||
          value.statusCode! < 200 ||
          value.statusCode! >= 300) {
        throw new FetchDataException("خطایی رخ داد");
      }
      try {
        success = !value.data["data"]["token"].toString().isNullOrEmpty();
        localStorageSet("Token", value.data["data"]["token"].toString());
        localStorageSet("TokenExpire", value.data["data"]["expiry"].toString());
      } catch (e) {}

      return success;
    });
  }
}
