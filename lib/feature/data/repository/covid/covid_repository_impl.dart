import 'package:covid_task_sorigin/feature/data/datasource/news/covid_remote_data_source.dart';
import 'package:covid_task_sorigin/feature/data/model/coviddata/CovidStatusModel.dart';
import 'package:covid_task_sorigin/feature/domain/repository/covid/covid_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:covid_task_sorigin/core/error/failure.dart';
import 'package:covid_task_sorigin/core/network/network_info.dart';
import 'package:meta/meta.dart';

class CovidRepositoryImpl implements CovidRepository {
  final CovidRemoteDataSource covidRemoteDataSource;
  final NetworkInfo networkInfo;

  CovidRepositoryImpl({
    @required this.covidRemoteDataSource,
    @required this.networkInfo,
  });


  @override
  Future<Either<Failure, CovidStatusModel>> getCovidData(String countryName, String date) async {
    var isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        var response = await covidRemoteDataSource.getCovidData(countryName, date);
        return Right(response);
      } catch (error) {
        return Left(ServerFailure(error.message));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}
