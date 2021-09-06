abstract class RepositoryMethod<T> {
  Future<List<T>> fetchList({String Url});
}

abstract class RepositoryMethodBit<T> {
  Future<bool> fetchBit({Object body, String Url});
}
