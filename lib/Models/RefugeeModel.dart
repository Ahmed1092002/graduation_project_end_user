class RefugeeModel {
  int? refugeeId;
  int? refugeeJobId;
  int? userId;
  String? refugeeCardNo;
  int? countryId;
  int? nationaltyId;
  String? cv;
  String? imagePath;
  String? cardStartDate;
  String? cardEndDate;
  String? deviceToken;

  RefugeeModel(
      {this.refugeeId,
        this.refugeeJobId,
        this.userId,
        this.refugeeCardNo,
        this.countryId,
        this.nationaltyId,
        this.cv,
        this.imagePath,
        this.cardStartDate,
        this.cardEndDate,
        this.deviceToken});

  RefugeeModel.fromJson(Map<String, dynamic> json) {
    refugeeId = json['refugeeId'];
    refugeeJobId = json['refugeeJobId'];
    userId = json['userId'];
    refugeeCardNo = json['refugeeCardNo'];
    countryId = json['countryId'];
    nationaltyId = json['nationaltyId'];
    cv = json['cv'];
    imagePath = json['imagePath'];
    cardStartDate = json['cardStartDate'];
    cardEndDate = json['cardEndDate'];
    deviceToken = json['deviceToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['refugeeId'] = this.refugeeId;
    data['refugeeJobId'] = this.refugeeJobId;
    data['userId'] = this.userId;
    data['refugeeCardNo'] = this.refugeeCardNo;
    data['countryId'] = this.countryId;
    data['nationaltyId'] = this.nationaltyId;
    data['cv'] = this.cv;
    data['imagePath'] = this.imagePath;
    data['cardStartDate'] = this.cardStartDate;
    data['cardEndDate'] = this.cardEndDate;
    data['deviceToken'] = this.deviceToken;
    return data;
  }
}
