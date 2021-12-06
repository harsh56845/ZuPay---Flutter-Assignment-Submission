class UserModel {
  late String name;
  late String email;
  late String uid;

  late int timestamp;
  UserModel(
      {required this.name,
      required this.email,
      required this.timestamp,
      required this.uid});
  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    uid = json['uid'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['uid'] = uid;
    data['timestamp'] = timestamp;
    return data;
  }
}
