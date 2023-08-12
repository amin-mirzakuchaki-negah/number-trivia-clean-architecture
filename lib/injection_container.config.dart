// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i5;
import 'package:number_trivia_clean_architecture/core/network/network_info.dart'
    as _i6;
import 'package:number_trivia_clean_architecture/core/util/input_convertor.dart'
    as _i4;
import 'package:number_trivia_clean_architecture/features/number_trivia/data/datasources/number_trivia_local_data_source.dart'
    as _i9;
import 'package:number_trivia_clean_architecture/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart'
    as _i7;
import 'package:number_trivia_clean_architecture/features/number_trivia/data/repositories/number_trivia_repository_impl.dart'
    as _i11;
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/repositories/number_trivia_repository.dart'
    as _i10;
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart'
    as _i12;
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/usecases/get_random_number_trivia.dart'
    as _i13;
import 'package:number_trivia_clean_architecture/features/number_trivia/presentation/bloc/number_trivia_bloc.dart'
    as _i14;
import 'package:number_trivia_clean_architecture/injection_container.dart'
    as _i15;
import 'package:shared_preferences/shared_preferences.dart' as _i8;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerHttpClient = _$RegisterHttpClient();
    final registerInternetConnectionChecker =
        _$RegisterInternetConnectionChecker();
    final registerSharedPreferences = _$RegisterSharedPreferences();
    gh.lazySingleton<_i3.Client>(() => registerHttpClient.client);
    gh.lazySingleton<_i4.InputConvertor>(() => _i4.InputConvertor());
    gh.lazySingleton<_i5.InternetConnectionChecker>(
        () => registerInternetConnectionChecker.checker);
    gh.lazySingleton<_i6.NetworkInfo>(
        () => _i6.NetworkInfoImpl(gh<_i5.InternetConnectionChecker>()));
    gh.lazySingleton<_i7.NumberTriviaRemoteDataSource>(
        () => _i7.NumberTriviaRemoteDataSourceImpl(client: gh<_i3.Client>()));
    await gh.lazySingletonAsync<_i8.SharedPreferences>(
      () => registerSharedPreferences.sh,
      preResolve: true,
    );
    gh.lazySingleton<_i9.NumberTriviaLocalDataSource>(() =>
        _i9.NumberTriviaLocalDataSourceImpl(
            sharedPreferences: gh<_i8.SharedPreferences>()));
    gh.lazySingleton<_i10.NumberTriviaRepository>(
        () => _i11.NumberTriviaRepositoryImpl(
              remoteDataSource: gh<_i7.NumberTriviaRemoteDataSource>(),
              localDataSource: gh<_i9.NumberTriviaLocalDataSource>(),
              networkInfo: gh<_i6.NetworkInfo>(),
            ));
    gh.lazySingleton<_i12.GetConcreteNumberTrivia>(
        () => _i12.GetConcreteNumberTrivia(gh<_i10.NumberTriviaRepository>()));
    gh.lazySingleton<_i13.GetRandomNumberTrivia>(
        () => _i13.GetRandomNumberTrivia(gh<_i10.NumberTriviaRepository>()));
    gh.factory<_i14.NumberTriviaBloc>(() => _i14.NumberTriviaBloc(
          getConcreteNumberTrivia: gh<_i12.GetConcreteNumberTrivia>(),
          getRandomNumberTrivia: gh<_i13.GetRandomNumberTrivia>(),
          inputConvertor: gh<_i4.InputConvertor>(),
        ));
    return this;
  }
}

class _$RegisterHttpClient extends _i15.RegisterHttpClient {}

class _$RegisterInternetConnectionChecker
    extends _i15.RegisterInternetConnectionChecker {}

class _$RegisterSharedPreferences extends _i15.RegisterSharedPreferences {}
