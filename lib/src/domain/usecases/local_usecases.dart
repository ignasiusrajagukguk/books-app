
import 'package:books_app/src/data/datasources/local/local_storage.dart';
import 'package:books_app/src/data/models/result.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AddLikedBookUsecase {
  final LocalStorage localStorage;

  AddLikedBookUsecase({
    required this.localStorage,
  });

  Future<int> call(
      {required Result result}) async {
    return await localStorage.addLikedBook(result);
  }
}

@lazySingleton
class GetLikedBookUsecase {
  final LocalStorage localStorage;

  GetLikedBookUsecase({
    required this.localStorage,
  });

  Future<List<Result>?> call() async {
    return await localStorage.getLikedBook();
  }
}

@lazySingleton
class DeleteLikedBookUsecase {
  final LocalStorage localStorage;

  DeleteLikedBookUsecase({
    required this.localStorage,
  });

  Future<int> call(
      {required Result result}) async {
    return await localStorage.deleteLikedBook(result);
  }
}

@lazySingleton
class AddLocalBooksUsecase {
  final LocalStorage localStorage;

  AddLocalBooksUsecase({
    required this.localStorage,
  });

  Future<int> call(
      {required Result result}) async {
    return await localStorage.addLocalBooks(result);
  }
}


@lazySingleton
class GetLocalBooksUsecase {
  final LocalStorage localStorage;

  GetLocalBooksUsecase({
    required this.localStorage,
  });

  Future<List<Result>?>  call() async {
    return await localStorage.getLocalBooks();
  }
}
