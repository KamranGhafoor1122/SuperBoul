class TicketDetailsModel {
  String? message;
  List<Data>? data;

  TicketDetailsModel({this.message, this.data});

  TicketDetailsModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? lotteryName;
  String? ticketName;
  String? userName;
  String? userPhone;
  String? ticketNo;
  int? entry;
  List<int>? number;
  String? entryAt;

  Data(
      {this.id,
        this.lotteryName,
        this.ticketName,
        this.userName,
        this.userPhone,
        this.ticketNo,
        this.entry,
        this.number,
        this.entryAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lotteryName = json['lottery_name'];
    ticketName = json['ticket_name'];
    userName = json['user_name'];
    userPhone = json['user_phone'];
    ticketNo = json['ticket_no'];
    entry = json['entry'];
    number = json['number'].cast<int>();
    entryAt = json['entry_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lottery_name'] = this.lotteryName;
    data['ticket_name'] = this.ticketName;
    data['user_name'] = this.userName;
    data['user_phone'] = this.userPhone;
    data['ticket_no'] = this.ticketNo;
    data['entry'] = this.entry;
    data['number'] = this.number;
    data['entry_at'] = this.entryAt;
    return data;
  }
}