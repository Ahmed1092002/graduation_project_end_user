class HelpingRequestModel {
  int? requestID;
  int? refugeeID;
  String? message;
  String? requestDate;
  bool? requestStatus;

  HelpingRequestModel(
      {this.requestID,
        this.refugeeID,
        this.message,
        this.requestDate,
        this.requestStatus});

  HelpingRequestModel.fromJson(Map<String, dynamic> json) {
    requestID = json['requestID'];
    refugeeID = json['refugeeID'];
    message = json['message'];
    requestDate = json['requestDate'];
    requestStatus = json['requestStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['requestID'] = this.requestID;
    data['refugeeID'] = this.refugeeID;
    data['message'] = this.message;
    data['requestDate'] = this.requestDate;
    data['requestStatus'] = this.requestStatus;
    return data;
  }
}
