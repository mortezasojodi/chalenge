import 'package:behtarino/Model/Home/Contact.dart';
import 'package:behtarino/repository/Core/RepositoryMethod.dart';

import 'package:behtarino/repository/Home/GetContactsRepository.dart';
import 'package:behtarino/repository/Login/GetFirstLoginRepository.dart';
import 'package:behtarino/repository/Login/GetFirstLoginRepository.dart';
import 'package:behtarino/repository/Login/GetLoginRepository.dart';

class Injector {
  static final Injector _singleton = new Injector._internal();

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  RepositoryMethod<Contact> get contactRepository {
    return new GetContactsRepository();
  }

  RepositoryMethodBit get LoginRepository {
    return new GetLoginRepository();
  }

  RepositoryMethodBit get FirstLoginRepository {
    return new GetFirstLoginRepository();
  }
  // ContactsRepository get CheckLoginRepository {
  //   return new CheckLoginRepository();
  // }
}
