import 'dart:convert';

import 'package:covid_task_sorigin/feature/data/model/coviddata/CovidStatusModel.dart';
import 'package:dio/dio.dart';
import 'package:covid_task_sorigin/config/constant_config.dart';
import 'package:meta/meta.dart';

abstract class CovidRemoteDataSource {
  /// Calls the [baseUrl]//report/country/name?name=:countryName&date=:date
  ///
  /// Throws a [DioError] for all error codes.
  Future<CovidStatusModel> getCovidData(String countryName, String date);
}

class CovidRemoteDataSourceImpl implements CovidRemoteDataSource {
  final Dio dio;
  final ConstantConfig constantConfig;

  CovidRemoteDataSourceImpl({
    @required this.dio,
    @required this.constantConfig,
  });


  @override
  Future<CovidStatusModel> getCovidData(String countryName, String date) async {
    var response = await dio.get(
      '/report/country/name',
      queryParameters: {
        'name': countryName,
        'date': date,
      },
      options: Options(headers: {
        'x-rapidapi-key': constantConfig.keyCovidToken,
        'x-rapidapi-host': constantConfig.keyHost,
        'useQueryString': true,
      },responseType: ResponseType.plain),

    );
    if (response.statusCode == 200) {
      var res = response.data.toString();
      var data = List<CovidStatusModel>.from(json.decode(res).map((x) => CovidStatusModel.fromJson(x)));
      var covidStatusModel = data.first;
      return covidStatusModel;
    } else {
      throw DioError();
    }
  }
}
