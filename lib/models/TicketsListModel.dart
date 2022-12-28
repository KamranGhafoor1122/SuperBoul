class TicketsListModel {
  TicketsListModel({
    this.message,
    this.data,
  });

  String? message;
  List<SingleTicketModel>? data;

  factory TicketsListModel.fromMap(Map<String, dynamic> json) => TicketsListModel(
        message: json["message"],
        data: List<SingleTicketModel>.from(json["data"].map((x) => SingleTicketModel.fromMap(x))),
      );
}

class SingleTicketModel {
  SingleTicketModel({
    this.id,
    this.lotteryName,
    this.ticketName,
    this.ticketNo,
    this.entries,
    this.remainingEntries,
    this.amount,
    this.status,
    this.createdAt,
  });

  int? id;
  String? lotteryName;
  String? ticketName;
  String? ticketNo;
  String? entries;
  String? remainingEntries;
  String? amount;
  String? status;
  DateTime? createdAt;

  factory SingleTicketModel.fromMap(Map<String, dynamic> json) => SingleTicketModel(
        id: json["id"],
        lotteryName: json["lottery_name"],
        ticketName: json["ticket_name"],
        ticketNo: json["ticket_no"],
        entries: json["entries"],
        remainingEntries: json["remaining_entries"],
        amount: json["amount"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
      );
}
