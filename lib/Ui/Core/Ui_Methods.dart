abstract class Errors {
  void showError();
}

abstract class UiMethods<T> implements Errors {
  void showContactlst(List<T> items);
}

abstract class UiMethodsBit implements Errors {
  void IsSuccess(bool t);
}
