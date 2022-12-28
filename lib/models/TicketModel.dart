class TicketModel {
  TicketModel({
    this.message,
    this.data,
  });

  String? message;
  Ticket? data;

  factory TicketModel.fromMap(Map<String, dynamic> json) => TicketModel(
        message: json["message"],
        data: Ticket.fromMap(json["data"]),
      );
}

class Ticket {
  Ticket({
    this.id,
    this.ticketNo,
    this.name,
    this.entries,
    this.remainingEntries,
    this.amount,
    this.ticketDate,
    this.status,
  });

  int? id;
  String? ticketNo;
  String? name;
  String? entries;
  String? remainingEntries;
  String? amount;
  DateTime? ticketDate;
  String? status;

  factory Ticket.fromMap(Map<String, dynamic> json) => Ticket(
        id: json["id"],
        ticketNo: json["ticket_no"],
        name: json["name"],
        entries: json["entries"],
        remainingEntries: json["remaining_entries"],
        amount: json["amount"],
        ticketDate: DateTime.parse(json["ticket_date"]),
        status: json["status"],
      );
}
