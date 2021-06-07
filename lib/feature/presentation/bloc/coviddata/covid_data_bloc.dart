import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:covid_task_sorigin/core/error/failure.dart';
import 'package:covid_task_sorigin/feature/domain/usecase/getcovidstatus/get_covid_status.dart';
import 'package:meta/meta.dart';

import './bloc.dart';

class CovidDataBloc extends Bloc<CovidDataEvent, CovidDataState> {
  final GetCovidData getCovidData;

  CovidDataBloc({
    @required this.getCovidData,
  })  : assert(getCovidData != null);

  @override
  CovidDataState get initialState => InitialCovidDataState();

  @override
  Stream<CovidDataState> mapEventToState(CovidDataEvent event)async* {
    if (event is LoadCovidDataEvent) {
      yield* _mapLoadTopHeadlinesNewsEventToState(event);
    } else if (event is ChangeCountryEvent) {
    } else if (event is ChangeDateEvent) {
    }
  }

  Stream<CovidDataState> _mapLoadTopHeadlinesNewsEventToState(LoadCovidDataEvent event) async* {
    yield LoadingCovidDataState();
    var response = await getCovidData(ParamsCovidData(countryName: event.countryName,date: event.date));
    yield response.fold(
      // ignore: missing_return
          (failure) {
        if (failure is ServerFailure) {
          return FailureCovidDataState(errorMessage: failure.errorMessage);
        } else if (failure is ConnectionFailure) {
          return FailureCovidDataState(errorMessage: failure.errorMessage);
        }
      },
          (data) => LoadedCovidDataState(covidModel: data),
    );
  }

}
