import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class CovidDataEvent extends Equatable {
  const CovidDataEvent();
}

class LoadCovidDataEvent extends CovidDataEvent {
  final String countryName;
  final String date;

  LoadCovidDataEvent({@required this.countryName, @required this.date});

  @override
  List<Object> get props => [countryName,date];

  @override
  String toString() {
    return 'LoadCovidDataEvent{countryName: $countryName, date: $date}';
  }
}

class ChangeCountryEvent extends CovidDataEvent {
  final String countryName;

  ChangeCountryEvent({@required this.countryName});

  @override
  List<Object> get props => [countryName];

  @override
  String toString() {
    return 'ChangeCountryEvent{countryName: $countryName}';
  }
}

class ChangeDateEvent extends CovidDataEvent {
  final String date;

  ChangeDateEvent({@required this.date});

  @override
  List<Object> get props => [date];

  @override
  String toString() {
    return 'ChangeDateEvent{date: $date}';
  }
}

