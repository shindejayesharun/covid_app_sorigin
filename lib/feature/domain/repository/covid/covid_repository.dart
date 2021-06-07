import 'package:covid_task_sorigin/feature/data/model/coviddata/CovidStatusModel.dart';
import 'package:dartz/dartz.dart';
import 'package:covid_task_sorigin/core/error/failure.dart';

abstract class CovidRepository {

  Future<Either<Failure, CovidStatusModel>> getCovidData(String countryName, String date);
}