class JobModel {
  int? jobId;
  String? jobName;
  String? description;
  int? salary;
  String? country;
  String? location;
  String? publishDate;
  int? yearsOfExperience;
  bool? isView;

  JobModel(
      {this.jobId,
      this.jobName,
      this.description,
      this.salary,
      this.country,
      this.location,
      this.publishDate,
      this.yearsOfExperience,
      this.isView});

  JobModel.fromJson(Map<String, dynamic> json) {
    jobId = json['jobId'];
    jobName = json['jobName'];
    description = json['description'];
    salary = json['salary'];
    country = json['country'];
    location = json['location'];
    publishDate = json['publishDate'];
    yearsOfExperience = json['yearsOfExperience'];
    isView = json['isView'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jobId'] = this.jobId;
    data['jobName'] = this.jobName;
    data['description'] = this.description;
    data['salary'] = this.salary;
    data['country'] = this.country;
    data['location'] = this.location;
    data['publishDate'] = this.publishDate;
    data['yearsOfExperience'] = this.yearsOfExperience;
    data['isView'] = this.isView;
    return data;
  }
}
