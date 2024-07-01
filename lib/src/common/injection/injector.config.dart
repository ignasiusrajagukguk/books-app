// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i6;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/datasources/local/local_storage.dart' as _i3;
import '../../data/datasources/remote/books_datasource.dart' as _i5;
import '../../domain/usecases/local_usecases.dart' as _i4;
import '../../domain/usecases/remote_usecases.dart' as _i8;
import '../../presentation/screens/book_detail/bloc/book_detail_bloc.dart'
    as _i10;
import '../../presentation/screens/home/bloc/home_bloc.dart' as _i9;
import '../../presentation/screens/liked/bloc/liked_bloc.dart' as _i7;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt $initGetIt({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i3.LocalStorage>(() => _i3.LocalStorageImplementationc());
    gh.lazySingleton<_i4.AddLikedBookUsecase>(
        () => _i4.AddLikedBookUsecase(localStorage: gh<_i3.LocalStorage>()));
    gh.lazySingleton<_i4.GetLikedBookUsecase>(
        () => _i4.GetLikedBookUsecase(localStorage: gh<_i3.LocalStorage>()));
    gh.lazySingleton<_i4.DeleteLikedBookUsecase>(
        () => _i4.DeleteLikedBookUsecase(localStorage: gh<_i3.LocalStorage>()));
    gh.lazySingleton<_i4.AddLocalBooksUsecase>(
        () => _i4.AddLocalBooksUsecase(localStorage: gh<_i3.LocalStorage>()));
    gh.lazySingleton<_i4.GetLocalBooksUsecase>(
        () => _i4.GetLocalBooksUsecase(localStorage: gh<_i3.LocalStorage>()));
    gh.lazySingleton<_i5.BooksDataSource>(
        () => _i5.BooksDataSourceImplementation(client: gh<_i6.Client>()));
    gh.factory<_i7.LikedBloc>(() => _i7.LikedBloc(
          addLikedBookUsecase: gh<_i4.AddLikedBookUsecase>(),
          getLikedBookUsecase: gh<_i4.GetLikedBookUsecase>(),
          deleteLikedBookUsecase: gh<_i4.DeleteLikedBookUsecase>(),
          addLocalBooksUsecase: gh<_i4.AddLocalBooksUsecase>(),
          getLocalBooksUsecase: gh<_i4.GetLocalBooksUsecase>(),
        ));
    gh.lazySingleton<_i8.GetBooksListUsecase>(() =>
        _i8.GetBooksListUsecase(booksDataSource: gh<_i5.BooksDataSource>()));
    gh.lazySingleton<_i8.GetBooksDetailUsecase>(() =>
        _i8.GetBooksDetailUsecase(booksDataSource: gh<_i5.BooksDataSource>()));
    gh.factory<_i9.HomeBloc>(() => _i9.HomeBloc(
          getBooksListUsecase: gh<_i8.GetBooksListUsecase>(),
          addLikedBookUsecase: gh<_i4.AddLikedBookUsecase>(),
          getLikedBookUsecase: gh<_i4.GetLikedBookUsecase>(),
          deleteLikedBookUsecase: gh<_i4.DeleteLikedBookUsecase>(),
          addLocalBooksUsecase: gh<_i4.AddLocalBooksUsecase>(),
          getLocalBooksUsecase: gh<_i4.GetLocalBooksUsecase>(),
        ));
    gh.factory<_i10.BookDetailBloc>(() => _i10.BookDetailBloc(
          getBooksDetailUsecase: gh<_i8.GetBooksDetailUsecase>(),
          getBooksListUsecase: gh<_i8.GetBooksListUsecase>(),
          addLikedBookUsecase: gh<_i4.AddLikedBookUsecase>(),
          getLikedBookUsecase: gh<_i4.GetLikedBookUsecase>(),
          deleteLikedBookUsecase: gh<_i4.DeleteLikedBookUsecase>(),
          addLocalBooksUsecase: gh<_i4.AddLocalBooksUsecase>(),
          getLocalBooksUsecase: gh<_i4.GetLocalBooksUsecase>(),
        ));
    return this;
  }
}
