/// country : "Italy"
/// provinces : [{"province":"Italy","confirmed":110574,"recovered":16847,"deaths":13155,"active":80572}]
/// latitude : 41.87194
/// longitude : 12.56738
/// date : "2020-04-01"

class CovidStatusModel {
  String _country;
  List<Provinces> _provinces;
  double _latitude;
  double _longitude;
  String _date;

  String get country => _country;
  List<Provinces> get provinces => _provinces;
  double get latitude => _latitude;
  double get longitude => _longitude;
  String get date => _date;

  CovidStatusModel({
    String country,
    List<Provinces> provinces,
    double latitude,
    double longitude,
    String date}){
    _country = country;
    _provinces = provinces;
    _latitude = latitude;
    _longitude = longitude;
    _date = date;
  }

  CovidStatusModel.fromJson(dynamic json) {
    _country = json["country"];
    if (json["provinces"] != null) {
      _provinces = [];
      json["provinces"].forEach((v) {
        _provinces.add(Provinces.fromJson(v));
      });
    }
    _latitude = json["latitude"];
    _longitude = json["longitude"];
    _date = json["date"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["country"] = _country;
    if (_provinces != null) {
      map["provinces"] = _provinces.map((v) => v.toJson()).toList();
    }
    map["latitude"] = _latitude;
    map["longitude"] = _longitude;
    map["date"] = _date;
    return map;
  }

}

/// province : "Italy"
/// confirmed : 110574
/// recovered : 16847
/// deaths : 13155
/// active : 80572

class Provinces {
  String _province;
  int _confirmed;
  int _recovered;
  int _deaths;
  int _active;

  String get province => _province;
  int get confirmed => _confirmed;
  int get recovered => _recovered;
  int get deaths => _deaths;
  int get active => _active;

  Provinces({
    String province,
    int confirmed,
    int recovered,
    int deaths,
    int active}){
    _province = province;
    _confirmed = confirmed;
    _recovered = recovered;
    _deaths = deaths;
    _active = active;
  }

  Provinces.fromJson(dynamic json) {
    _province = json["province"];
    _confirmed = json["confirmed"];
    _recovered = json["recovered"];
    _deaths = json["deaths"];
    _active = json["active"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["province"] = _province;
    map["confirmed"] = _confirmed;
    map["recovered"] = _recovered;
    map["deaths"] = _deaths;
    map["active"] = _active;
    return map;
  }

}