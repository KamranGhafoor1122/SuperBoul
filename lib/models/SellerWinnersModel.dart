class SellerWinnersModel {
  bool? success;
  String? message;
  List<Data>? data;

  SellerWinnersModel({this.success, this.message, this.data});

  SellerWinnersModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
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
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? userName;
  String? userPhone;
  List<String>? prizeNumber;
  String? prize;
  String? amount;

  Data(
      {this.userName,
        this.userPhone,
        this.prizeNumber,
        this.prize,
        this.amount});

  Data.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    userPhone = json['user_phone'];
    prizeNumber = json['prize_number'].cast<String>();
    prize = json['prize'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_name'] = this.userName;
    data['user_phone'] = this.userPhone;
    data['prize_number'] = this.prizeNumber;
    data['prize'] = this.prize;
    data['amount'] = this.amount;
    return data;
  }
}