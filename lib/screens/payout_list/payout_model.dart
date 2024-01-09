// class PayoutModel {
//   String? sId;
//   String? requestedDate;
//   int? amount;
//   String? method;
//   String? status;
//   Bank? bank;
//   String? vendor;
//   bool? deleted;
//   String? createdAt;
//   String? updatedAt;
//   int? iV;
//
//   PayoutModel(
//       {this.sId,
//       this.requestedDate,
//       this.amount,
//       this.method,
//       this.status,
//       this.bank,
//       this.vendor,
//       this.deleted,
//       this.createdAt,
//       this.updatedAt,
//       this.iV});
//
//   PayoutModel.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     requestedDate = json['requestedDate'];
//     amount = json['amount'];
//     method = json['method'];
//     status = json['status'];
//     bank = json['bank'] != null ? Bank.fromJson(json['bank']) : null;
//     vendor = json['vendor'];
//     deleted = json['deleted'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     iV = json['__v'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['_id'] = sId;
//     data['requestedDate'] = requestedDate;
//     data['amount'] = amount;
//     data['method'] = method;
//     data['status'] = status;
//     if (bank != null) {
//       data['bank'] = bank!.toJson();
//     }
//     data['vendor'] = vendor;
//     data['deleted'] = deleted;
//     data['createdAt'] = createdAt;
//     data['updatedAt'] = updatedAt;
//     data['__v'] = iV;
//     return data;
//   }
// }
//
// class Bank {
//   String? sId;
//   String? name;
//   String? title;
//   String? iban;
//
//   Bank({this.sId, this.name, this.title, this.iban});
//
//   Bank.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     name = json['name'];
//     title = json['title'];
//     iban = json['iban'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['_id'] = sId;
//     data['name'] = name;
//     data['title'] = title;
//     data['iban'] = iban;
//     return data;
//   }
// }
