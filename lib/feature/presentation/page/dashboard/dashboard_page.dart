import 'dart:io';

import 'package:covid_task_sorigin/config/constants.dart';
import 'package:covid_task_sorigin/feature/data/model/coviddata/CovidStatusModel.dart';
import 'package:covid_task_sorigin/feature/presentation/bloc/coviddata/bloc.dart';
import 'package:covid_task_sorigin/feature/presentation/widget/country_dropdown_view.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:covid_task_sorigin/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid_task_sorigin/feature/presentation/widget/widget_failure_message.dart';
import 'package:covid_task_sorigin/injection_container.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  int _selectedIndex = 1;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final covidDataBloc = sl<CovidDataBloc>();
  final refreshIndicatorState = GlobalKey<RefreshIndicatorState>();
  String countrySelected = "India";
  DateTime selectedDate = DateTime(2020, 4,1);


  @override
  void initState() {
    _controller = TabController(length: 3, vsync: this);
    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
      print("Selected Index: " + _controller.index.toString());
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      covidDataBloc.add(
        LoadCovidDataEvent(countryName: "Italy", date: "2020-04-01"),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "Covid Updates",
          style: Theme.of(context)
              .textTheme
              .headline5
              .copyWith(color: Colors.white),
        ),
        bottom: TabBar(
          controller: _controller,
          indicatorColor: kPrimaryColor,
          indicator: ShapeDecoration(
              color: Colors.transparent, shape: RoundedRectangleBorder()),
          labelColor: kPrimaryColor,
          unselectedLabelColor: Colors.white,
          tabs: [
            Tab(
              text: "Your Status",
              icon: SvgPicture.asset(
                "assets/images/ic_status.svg",
                color: _selectedIndex == 0 ? kPrimaryColor : Colors.white,
              ),
            ),
            Tab(
              text: "Updates",
              icon: SvgPicture.asset(
                "assets/images/ic_updates.svg",
                color: _selectedIndex == 1 ? kPrimaryColor : Colors.white,
              ),
            ),
            Tab(
              text: "Vaccination",
              icon: SvgPicture.asset(
                "assets/images/ic_vaccination.svg",
                color: _selectedIndex == 2 ? kPrimaryColor : Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: BlocProvider<CovidDataBloc>(
        create: (context) => covidDataBloc,
        child: BlocListener<CovidDataBloc, CovidDataState>(
          listener: (context, state) {
            if (state is FailureCovidDataState) {
            } else if (state is LoadedCovidDataState) {}
          },
          child: ValueListenableBuilder(
            valueListenable: Hive.box('settings').listenable(),
            builder: (context, box, widget) {
              return Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  SafeArea(
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        vertical: 24.h,
                      ),
                      child: covidDataPage(),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime(2020, 4,1),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Widget covidDataPage() {
    return BlocBuilder<CovidDataBloc, CovidDataState>(
      builder: (context, state) {
        CovidStatusModel covidDataModel = null;
        if (state is LoadedCovidDataState) {
          covidDataModel = state.covidModel;
        }
        return Stack(
          children: <Widget>[
            TabBarView(
              controller: _controller,
              children: [
                Container(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        decoration: BoxDecoration(
                            color: kSecondaryColor,
                            borderRadius: BorderRadius.circular(16)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "CASES OVERTIME",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(
                                      color: Colors.white.withOpacity(0.4)),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CountryDropdownView(
                                  list: countryList,
                                  valueReturned: (value) {
                                    setState(() {
                                      countrySelected = value;
                                    });
                                  },
                                ),
                                TextButton(
                                  child: Text(
                                    "${DateFormat('yyyy-MM-dd').format(selectedDate)}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle
                                        .copyWith(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    _selectDate(context);
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RaisedButton(
                          color: kPrimaryColor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 16),
                            child: Text(
                              "Submit",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          onPressed: () {
                            covidDataBloc.add(
                              LoadCovidDataEvent(
                                  countryName: countrySelected,
                                  date: DateFormat('yyyy-MM-dd')
                                      .format(selectedDate)),
                            );
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        decoration: BoxDecoration(
                            color: kSecondaryColor,
                            borderRadius: BorderRadius.circular(16)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "DETAILS",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(
                                      color: Colors.white.withOpacity(0.4)),
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "Active",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subhead
                                          .copyWith(color: kPrimaryColor),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                        "${covidDataModel != null ? covidDataModel.provinces.first.active : ""}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle.copyWith(color: CupertinoColors.white)),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "Recovered",
                                      style:
                                          Theme.of(context).textTheme.subhead.copyWith(color: CupertinoColors.white),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                        "${covidDataModel != null ? covidDataModel.provinces.first.recovered : ""}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle.copyWith(color: CupertinoColors.white)),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "Deceased",
                                      style:
                                          Theme.of(context).textTheme.subhead.copyWith(color: CupertinoColors.white),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                        "${covidDataModel != null ? covidDataModel.provinces.first.deaths : ""}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle.copyWith(color: CupertinoColors.white)),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "Confirmed",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subhead
                                          .copyWith(color: kPrimaryColor),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                        "${covidDataModel != null ? covidDataModel.provinces.first.confirmed : ""}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle.copyWith(color: CupertinoColors.white)),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 24,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(),
              ],
            ),
            if (state is LoadingCovidDataState) ...[
              Center(
                child: CircularProgressIndicator(),
              ),
            ],
          ],
        );
      },
    );
  }
}
