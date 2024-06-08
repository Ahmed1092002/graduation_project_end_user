class LoginModel {
  int? refugeeId;
  int? personId;
  int? userId;
      int? countryId;
  String? countryName;
  String? cv;
  String? imagePath;

  LoginModel(
      {this.refugeeId,
        this.personId,
        this.userId,
        this.countryId,
        this.countryName,
        this.cv,
        this.imagePath});

  LoginModel.fromJson(Map<String, dynamic> json) {
    refugeeId = json['refugeeId'];
    personId = json['personId'];
    userId = json['userId'];
    countryId = json['countryId'];
    countryName = json['countryName'];
    cv = json['cv'];
    imagePath = json['imagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['refugeeId'] = this.refugeeId;
    data['personId'] = this.personId;
    data['userId'] = this.userId;
    data['countryId'] = this.countryId;
    data['countryName'] = this.countryName;
    data['cv'] = this.cv;
    data['imagePath'] = this.imagePath;
    return data;
  }
}
