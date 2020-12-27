class UserAuth {
  String uSERNO;
  String sERIAL;

  UserAuth({this.uSERNO, this.sERIAL});

  UserAuth.fromJson(Map<String, dynamic> json) {
    uSERNO = json['USER_NO'] ;
    sERIAL = json['SERIAL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['USER_NO'] = this.uSERNO;
    data['SERIAL'] = this.sERIAL;
    return data;
  }
}
