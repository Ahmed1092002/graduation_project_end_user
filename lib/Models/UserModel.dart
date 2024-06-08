class UserModel {
  int? userId;
  int? personId;
  String? userName;
  String? password;
  bool? isBlocked;
  String? createdAt;

  UserModel(
      {this.userId,
        this.personId,
        this.userName,
        this.password,
        this.isBlocked,
        this.createdAt});

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    personId = json['personId'];
    userName = json['userName'];
    password = json['password'];
    isBlocked = json['isBlocked'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['personId'] = this.personId;
    data['userName'] = this.userName;
    data['password'] = this.password;
    data['isBlocked'] = this.isBlocked;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
