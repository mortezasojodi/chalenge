import 'package:behtarino/Model/Home/Contact.dart';
import 'package:behtarino/Ui/Core/Ui_Methods.dart';
import 'package:behtarino/di/Injection.dart';
import 'package:behtarino/repository/Core/RepositoryMethod.dart';

class HomePresenter {
  UiMethods _view;

  RepositoryMethod<Contact>? _repository;

  HomePresenter(this._view) {
    _repository = new Injector().contactRepository;
  }

  Future<List<Contact>> loadContacts() async {
    // assert(_view != null);
    List<Contact> cl = [];

    try {
      var temp =
          await _repository!.fetchList(Url: "/utils/challenge/contact_list/");
      cl.addAll(temp);
    } catch (e) {}

    return cl;
  }
}
