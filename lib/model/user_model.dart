class UserModel {
  String? uid;
  String? userName;
  String? email;
  String? photoUrl;

  UserModel({this.uid, this.userName, this.email, this.photoUrl});

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    userName = json['userName'];
    email = json['email'];
    photoUrl = json['photoUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['photoUrl'] = this.photoUrl;
    return data;
  }
}