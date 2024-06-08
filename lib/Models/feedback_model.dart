class FeedbackModel {
  int? feedbackID;
  int? refugeeID;
  int? rating;
  String? message;
  String? feedbackDate;

  FeedbackModel(
      {this.feedbackID,
        this.refugeeID,
        this.rating,
        this.message,
        this.feedbackDate});

  FeedbackModel.fromJson(Map<String, dynamic> json) {
    feedbackID = json['feedbackID'];
    refugeeID = json['refugeeID'];
    rating = json['rating'];
    message = json['message'];
    feedbackDate = json['feedbackDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['feedbackID'] = this.feedbackID;
    data['refugeeID'] = this.refugeeID;
    data['rating'] = this.rating;
    data['message'] = this.message;
    data['feedbackDate'] = this.feedbackDate;
    return data;
  }
}
