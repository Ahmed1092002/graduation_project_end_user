class JobAppliedModel {
  int? refugeeId;
  int? jobId;
  String? applyDate;
  int? jobStatus;

  JobAppliedModel({this.refugeeId, this.jobId, this.applyDate, this.jobStatus});

  JobAppliedModel.fromJson(Map<String, dynamic> json) {
    refugeeId = json['refugeeId'];
    jobId = json['jobId'];
    applyDate = json['applyDate'];
    jobStatus = json['jobStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['refugeeId'] = this.refugeeId;
    data['jobId'] = this.jobId;
    data['applyDate'] = this.applyDate;
    data['jobStatus'] = this.jobStatus;
    return data;
  }
}
