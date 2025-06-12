class User {
  String? id;
  String? userName;
  String? userProfile;
  String? userEmail;

  User({this.id, this.userName, this.userProfile, this.userEmail});

  String get getId => id ?? '';
  String get getUserName => userName ?? 'Anonymous';
  String get getUserProfile => userProfile ?? '';
  String get getUserProfileOrDefault =>
      userProfile ?? 'assets/images/profile.jpg';
  String get getUserEmail => userEmail ?? 'No email';

  setId(String? value) {
    id = value;
  }

  setUserName(String? value) {
    userName = value;
  }

  setUserProfile(String? value) {
    userProfile = value;
  }

  setUserEmail(String? value) {
    userEmail = value;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String?,
      userName: json['userName'] as String?,
      userProfile: json['userProfile'] as String?,
      userEmail: json['userEmail'] as String?,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'userProfile': userProfile,
      'userEmail': userEmail,
    };
  }

  @override
  String toString() {
    return 'UserInfoModel{id: $id, userName: $userName, userProfile: $userProfile, userEmail: $userEmail}';
  }
}
