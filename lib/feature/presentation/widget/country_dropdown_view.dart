import 'package:covid_task_sorigin/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class CountryDropdownView extends StatefulWidget {
  final List<String> list;
  Function(String) valueReturned;

  CountryDropdownView({Key key, this.list, this.valueReturned}) : super(key: key);

  @override
  _CountryDropdownViewState createState() => _CountryDropdownViewState();
}

class _CountryDropdownViewState extends State<CountryDropdownView> {
  String countrySelected = "Italy";
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: ScreenUtil.screenWidthDp / 2.1,
      child: DropdownButtonFormField<String>(
        dropdownColor: Colors.black,
          decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide:
                  BorderSide(color: kSecondaryColor))),
          isExpanded: true,
          focusColor: Colors.black,
          value: countrySelected,
          style: TextStyle(color: Colors.black),
          iconEnabledColor: kSecondaryColor,
          items: widget.list.map<DropdownMenuItem<String>>(
                  (String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                );
              }).toList(),
          hint: Text(
            "Please select country",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
          ),
          onChanged: (String value) {
            setState(() {
              countrySelected = value;
            });
            widget.valueReturned(value);
            FocusScope.of(context)
                .requestFocus(new FocusNode());
          },
          validator: (value) {
            if (countrySelected == "") {
              return 'Please select country';
            }
            return null;
          }),
    );
  }
}
