class TransactionsModel {
  String? message;
  List<Data>? data;

  TransactionsModel({this.message, this.data});

  TransactionsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? transactionId;
  int? amount;
  String? type;
  String? status;
  String? transactionAt;

  Data(
      {this.transactionId,
        this.amount,
        this.type,
        this.status,
        this.transactionAt});

  Data.fromJson(Map<String, dynamic> json) {
    transactionId = json['transaction_id'];
    amount = json['amount'];
    type = json['type'];
    status = json['status'];
    transactionAt = json['transaction_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transaction_id'] = this.transactionId;
    data['amount'] = this.amount;
    data['type'] = this.type;
    data['status'] = this.status;
    data['transaction_at'] = this.transactionAt;
    return data;
  }
}
