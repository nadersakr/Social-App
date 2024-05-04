
class UserModel {
  final String? firstName;
  final String? lastName;
  final String? mail;
  final String? userName;
  final String? uid;

  UserModel({
    this.firstName,
    this.lastName,
    this.mail,
    this.userName,
    this.uid,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      firstName: map['firstName'],
      lastName: map['lastName'],
      mail: map['email'],
      userName: map['username'],
      uid: map['uid'],
    );
  }
}
