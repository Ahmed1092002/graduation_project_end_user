class PersonModel {
  int? personId;
  String? firstName;
  String? lastName;
  String? gender;
  String? address;
  String? phone1;
  Null? phone2;
  String? dateOfBirth;
  String? email;

  PersonModel(
      {this.personId,
        this.firstName,
        this.lastName,
        this.gender,
        this.address,
        this.phone1,
        this.phone2,
        this.dateOfBirth,
        this.email});

  PersonModel.fromJson(Map<String, dynamic> json) {
    personId = json['personId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    gender = json['gender'];
    address = json['address'];
    phone1 = json['phone1'];
    phone2 = json['phone2'];
    dateOfBirth = json['dateOfBirth'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['personId'] = this.personId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['gender'] = this.gender;
    data['address'] = this.address;
    data['phone1'] = this.phone1;
    data['phone2'] = this.phone2;
    data['dateOfBirth'] = this.dateOfBirth;
    data['email'] = this.email;
    return data;
  }
}
