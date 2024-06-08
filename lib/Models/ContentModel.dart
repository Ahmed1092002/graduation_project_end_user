class ContentModel {
  String? ContentId;
  String? title;
  String? description;



  ContentModel({this.title, this.description, this.ContentId});

  ContentModel.fromJson(Map<String, dynamic> json, String id) {
    title = json['title'];
    this.ContentId = id;
    description = json['description'];



  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;

    data['description'] = this.description;

    return data;
  }
}