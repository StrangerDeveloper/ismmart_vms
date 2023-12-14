class BankDetailsModel {

  String? bankName;
  String? accountTitle;
  String? accountNoOrIban;

  BankDetailsModel({this.accountNoOrIban, this.accountTitle, this.bankName});

  BankDetailsModel.fromJson(Map<String, dynamic> json) {
    bankName = json['bankName'];
    accountTitle = json['accountTitle'];
    accountNoOrIban = json['accountNoOrIban'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bankName'] = bankName;
    data['accountTitle'] = accountTitle;
    data['accountNoOrIban'] = accountNoOrIban;
    return data;
  }
}