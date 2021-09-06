import 'dart:convert';

import 'package:behtarino/Model/Home/Contact.dart';
import 'package:behtarino/Ui/Core/Ui_Methods.dart';
import 'package:behtarino/di/Injection.dart';
import 'package:behtarino/repository/Core/RepositoryMethod.dart';

class LoginPresenter {
  UiMethodsBit _view;

  RepositoryMethodBit? _repository;

  LoginPresenter(this._view) {
    _repository = new Injector().LoginRepository;
  }

  void load({String? username, String? password}) {
    // assert(_view != null);

    _repository!
        .fetchBit(
          Url: '/api/v1/token_sign/',
          body: {
            'username': '$username',
            'password': '$password',
          },
        )
        .then((isLogin) => _view.IsSuccess(isLogin))
        .catchError((onError) {
          print(onError);
          _view.showError();
        });
  }
}
