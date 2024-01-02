class BankModel {
  String? sId;
  String? user;
  String? name;
  String? title;
  String? iban;
  String? accountNumber;

  BankModel(
      {this.sId,
        this.user,
        this.name,
        this.title,
        this.iban,
        this.accountNumber});

  BankModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'];
    name = json['name'];
    title = json['title'];
    iban = json['iban'];
    accountNumber = json['accountNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user'] = this.user;
    data['name'] = this.name;
    data['title'] = this.title;
    data['iban'] = this.iban;
    data['accountNumber'] = this.accountNumber;
    return data;
  }
}
