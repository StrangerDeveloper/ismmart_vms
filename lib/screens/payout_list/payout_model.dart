class PayoutModel {
  String? sId;
  String? requestedDate;
  int? amount;
  String? method;
  String? status;
  Bank? bank;
  String? vendor;
  bool? deleted;
  String? createdAt;
  String? updatedAt;
  int? iV;

  PayoutModel(
      {this.sId,
        this.requestedDate,
        this.amount,
        this.method,
        this.status,
        this.bank,
        this.vendor,
        this.deleted,
        this.createdAt,
        this.updatedAt,
        this.iV});

  PayoutModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    requestedDate = json['requestedDate'];
    amount = json['amount'];
    method = json['method'];
    status = json['status'];
    bank = json['bank'] != null ? new Bank.fromJson(json['bank']) : null;
    vendor = json['vendor'];
    deleted = json['deleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['requestedDate'] = this.requestedDate;
    data['amount'] = this.amount;
    data['method'] = this.method;
    data['status'] = this.status;
    if (this.bank != null) {
      data['bank'] = this.bank!.toJson();
    }
    data['vendor'] = this.vendor;
    data['deleted'] = this.deleted;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Bank {
  String? sId;
  String? name;
  String? title;
  String? iban;

  Bank({this.sId, this.name, this.title, this.iban});

  Bank.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    title = json['title'];
    iban = json['iban'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['title'] = this.title;
    data['iban'] = this.iban;
    return data;
  }
}
