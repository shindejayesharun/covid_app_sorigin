import 'package:covid_task_sorigin/feature/data/model/coviddata/CovidStatusModel.dart';
import 'package:covid_task_sorigin/feature/domain/repository/covid/covid_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:covid_task_sorigin/core/error/failure.dart';
import 'package:meta/meta.dart';
import 'package:covid_task_sorigin/core/usecase/usecase.dart';

class GetCovidData implements UseCase<CovidStatusModel, ParamsCovidData> {
  final CovidRepository newsRepository;

  GetCovidData({@required this.newsRepository});

  @override
  Future<Either<Failure, CovidStatusModel>> call(ParamsCovidData params) async {
    return await newsRepository.getCovidData(params.countryName, params.date);
  }
}

class ParamsCovidData extends Equatable {
  final String countryName;
  final String date;

  ParamsCovidData({@required this.countryName,@required this.date});

  @override
  List<Object> get props => [countryName,date];

  @override
  String toString() {
    return 'ParamsCovidData{name: $countryName,date: $date}';
  }
}