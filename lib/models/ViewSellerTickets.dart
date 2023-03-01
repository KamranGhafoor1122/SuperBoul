class ViewSellerTickets {
  String? message;
  List<Data>? data;

  ViewSellerTickets({this.message, this.data});

  ViewSellerTickets.fromJson(Map<String, dynamic> json) {
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
  String? userName;
  String? userPhone;
  String? ticketName;
  String? ticketNo;
  String? entries;
  String? remainingEntries;
  String? amount;
  String? status;
  String? createdAt;

  Data(
      {this.id,
        this.lotteryName,
        this.userName,
        this.userPhone,
        this.ticketName,
        this.ticketNo,
        this.entries,
        this.remainingEntries,
        this.amount,
        this.status,
        this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lotteryName = json['lottery_name'];
    userName = json['user_name'];
    userPhone = json['user_phone'];
    ticketName = json['ticket_name'];
    ticketNo = json['ticket_no'];
    entries = json['entries'];
    remainingEntries = json['remaining_entries'];
    amount = json['amount'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lottery_name'] = this.lotteryName;
    data['user_name'] = this.userName;
    data['user_phone'] = this.userPhone;
    data['ticket_name'] = this.ticketName;
    data['ticket_no'] = this.ticketNo;
    data['entries'] = this.entries;
    data['remaining_entries'] = this.remainingEntries;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}