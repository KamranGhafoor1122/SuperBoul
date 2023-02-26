class PlayLotteryModel {
  bool? success;
  String? message;
  Data? data;

  PlayLotteryModel({this.success, this.message, this.data});

  PlayLotteryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? lotteryId;
  int? userId;
  int? ticketId;
  int? entry;
  String? number;

  Data({this.lotteryId, this.userId, this.ticketId, this.entry, this.number});

  Data.fromJson(Map<String, dynamic> json) {
    lotteryId = json['lottery_id'];
    userId = json['user_id'];
    ticketId = json['ticket_id'];
    entry = json['entry'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lottery_id'] = this.lotteryId;
    data['user_id'] = this.userId;
    data['ticket_id'] = this.ticketId;
    data['entry'] = this.entry;
    data['number'] = this.number;
    return data;
  }
}