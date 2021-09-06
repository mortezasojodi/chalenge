import 'package:behtarino/Common/ErrorHandling.dart';
import 'package:behtarino/repository/Core/Repository.dart';
import 'package:behtarino/repository/Core/RepositoryMethod.dart';

class GetFirstLoginRepository implements RepositoryMethodBit {
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

      success = value.data["data"]["ok"] == true;

      return success;
    });
  }
}
