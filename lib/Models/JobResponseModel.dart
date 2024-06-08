class JobResponseModel {
  num? cV;
  String? country;
  String? description;
  num? finalscale;
  bool? isView;
  int? jobID;
  String? jobName;
  num? kNN;
  String? location;
  String? publishDate;
  num? salary;
  num? tFIDF;
  num? yearsOfExperience;

  JobResponseModel({
    this.cV,
    this.country,
    this.description,
    this.finalscale,
    this.isView,
    this.jobID,
    this.jobName,
    this.kNN,
    this.location,
    this.publishDate,
    this.salary,
    this.tFIDF,
    this.yearsOfExperience,
  });

  JobResponseModel.fromJson(Map<String, dynamic> json) {
    cV = json['CV'];
    country = json['Country'];
    description = json['Description'];
    finalscale = json['Final'];
    isView = json['IsView'];
    jobID = json['JobID'];
    jobName = json['JobName'];
    kNN = json['KNN'];
    location = json['Location'];
    publishDate = json['PublishDate'];
    salary = json['Salary'] != null ? double.parse(json['Salary']) : null; // Explicitly parse string to double
    tFIDF = json['TF-IDF'];
    yearsOfExperience = json['YearsOfExperience'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CV'] = this.cV;
    data['Country'] = this.country;
    data['Description'] = this.description;
    data['Final'] = this.finalscale;
    data['IsView'] = this.isView;
    data['JobID'] = this.jobID;
    data['JobName'] = this.jobName;
    data['KNN'] = this.kNN;
    data['Location'] = this.location;
    data['PublishDate'] = this.publishDate;
    data['Salary'] = this.salary;
    data['TF-IDF'] = this.tFIDF;
    data['YearsOfExperience'] = this.yearsOfExperience;
    return data;
  }
}
