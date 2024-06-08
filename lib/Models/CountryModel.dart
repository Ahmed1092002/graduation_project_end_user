class CountryModel {
  int? countryId;
  String? countryName;

  CountryModel({this.countryId, this.countryName});

  CountryModel.fromJson(Map<String, dynamic> json) {
    countryId = json['countryId'];
    countryName = json['countryName'];
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CountryModel && other.countryId == countryId;
  }

  @override
  int get hashCode => countryId.hashCode;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['countryId'] = this.countryId;
    data['countryName'] = this.countryName;
    return data;
  }
}
