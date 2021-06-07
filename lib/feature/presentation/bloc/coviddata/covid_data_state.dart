import 'package:covid_task_sorigin/feature/data/model/coviddata/CovidStatusModel.dart';
import 'package:equatable/equatable.dart';

abstract class CovidDataState extends Equatable {
  const CovidDataState();

  @override
  List<Object> get props => [];
}

class InitialCovidDataState extends CovidDataState {}

class LoadingCovidDataState extends CovidDataState {}

class LoadedCovidDataState extends CovidDataState {
  final CovidStatusModel covidModel;

  LoadedCovidDataState({this.covidModel});

  @override
  List<Object> get props => [covidModel];

  @override
  String toString() {
    return 'LoadedCovidDataState{covidModel: $covidModel}';
  }
}

class FailureCovidDataState extends CovidDataState {
  final String errorMessage;

  FailureCovidDataState({this.errorMessage});

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() {
    return 'FailureCovidDataState{errorMessage: $errorMessage}';
  }
}

class ChangedCountryCovidDataState extends CovidDataState {
  final String countryName;

  ChangedCountryCovidDataState({this.countryName});

  @override
  List<Object> get props => [countryName];

  @override
  String toString() {
    return 'ChangedCountryCovidDataState{countryName: $countryName}';
  }
}
class ChangedDateCovidDataState extends CovidDataState {
  final String date;

  ChangedDateCovidDataState({this.date});

  @override
  List<Object> get props => [date];

  @override
  String toString() {
    return 'ChangedDateCovidDataState{date: $date}';
  }
}