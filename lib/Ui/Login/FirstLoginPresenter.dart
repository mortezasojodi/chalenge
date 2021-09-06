import 'dart:convert';

import 'package:behtarino/Model/Home/Contact.dart';
import 'package:behtarino/Ui/Core/Ui_Methods.dart';
import 'package:behtarino/di/Injection.dart';
import 'package:behtarino/repository/Core/RepositoryMethod.dart';

class FirstLoginPresenter {
  UiMethodsBit _view;

  RepositoryMethodBit? _repository;

  FirstLoginPresenter(this._view) {
    _repository = new Injector().FirstLoginRepository;
  }

  void load({
    String? phone,
  }) {
    // assert(_view != null);

    _repository!
        .fetchBit(
          Url: '/api/v1/users/phone_verification/',
          body: {
            'phone': '$phone',
          },
        )
        .then((isLogin) => _view.IsSuccess(isLogin))
        .catchError((onError) {
          print(onError);
          _view.showError();
        });
  }
}
