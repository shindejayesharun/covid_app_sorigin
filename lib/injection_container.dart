import 'package:covid_task_sorigin/feature/data/datasource/news/covid_remote_data_source.dart';
import 'package:covid_task_sorigin/feature/data/repository/covid/covid_repository_impl.dart';
import 'package:covid_task_sorigin/feature/domain/repository/covid/covid_repository.dart';
import 'package:covid_task_sorigin/feature/domain/usecase/getcovidstatus/get_covid_status.dart';
import 'package:covid_task_sorigin/feature/presentation/bloc/coviddata/bloc.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:covid_task_sorigin/config/constant_config.dart';
import 'package:covid_task_sorigin/config/flavor_config.dart';
import 'package:covid_task_sorigin/core/network/network_info.dart';
import 'package:covid_task_sorigin/core/util/dio_logging_interceptor.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /**
   * ! Features
   */
  // Bloc
  sl.registerFactory(
        () => CovidDataBloc(
      getCovidData: sl(),
    ),
  );

  // Use Case
  sl.registerLazySingleton(() => GetCovidData(newsRepository: sl()));

  // Repository
  sl.registerLazySingleton<CovidRepository>(() => CovidRepositoryImpl(covidRemoteDataSource: sl(), networkInfo: sl()));


  // Data Source
  sl.registerLazySingleton<CovidRemoteDataSource>(() => CovidRemoteDataSourceImpl(dio: sl(), constantConfig: sl()));

  /**
   * ! Core
   */
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  /**
   * ! External
   */
  sl.registerLazySingleton(() {
    final dio = Dio();
    dio.options.baseUrl = FlavorConfig.instance.values.baseUrl;
    dio.interceptors.add(DioLoggingInterceptor());
    return dio;
  });
  sl.registerLazySingleton(() => ConstantConfig());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
