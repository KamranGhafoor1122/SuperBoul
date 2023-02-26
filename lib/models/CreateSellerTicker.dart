class CreateSellerTicket {
  bool? success;
  String? message;
  List<Data>? data;

  CreateSellerTicket({this.success, this.message, this.data});

  CreateSellerTicket.fromJson(Map<String, dynamic> json) {
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
  int? lotteryId;
  int? userId;
  String? name;
  int? ticketNo;
  int? entries;
  int? remainingEntries;
  int? amount;
  String? status;

  Data(
      {this.lotteryId,
        this.userId,
        this.name,
        this.ticketNo,
        this.entries,
        this.remainingEntries,
        this.amount,
        this.status});

  Data.fromJson(Map<String, dynamic> json) {
    lotteryId = json['lottery_id'];
    userId = json['user_id'];
    name = json['name'];
    ticketNo = json['ticket_no'];
    entries = json['entries'];
    remainingEntries = json['remaining_entries'];
    amount = json['amount'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lottery_id'] = this.lotteryId;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['ticket_no'] = this.ticketNo;
    data['entries'] = this.entries;
    data['remaining_entries'] = this.remainingEntries;
    data['amount'] = this.amount;
    data['status'] = this.status;
    return data;
  }
}