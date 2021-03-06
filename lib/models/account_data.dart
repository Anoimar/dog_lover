class AccountData {
  final String id;
  String avatarUrl;

  AccountData({this.id, this.avatarUrl});

  factory AccountData.fromJson(Map<String, dynamic> json) => AccountData(
        id: json['id'],
        avatarUrl: json['avatarUrl'],
      );
}
