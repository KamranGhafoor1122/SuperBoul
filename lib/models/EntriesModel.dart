class EntriesModel {
  EntriesModel({
    this.message,
    this.entriesList,
  });

  String? message;
  List<Entry>? entriesList;

  factory EntriesModel.fromMap(Map<String, dynamic> json) => EntriesModel(
        message: json["message"],
        entriesList: List<Entry>.from(json["data"].map((x) => Entry.fromMap(x))),
      );
}

class Entry {
  Entry({
    this.id,
    this.lotteryName,
    this.ticketName,
    this.ticketNo,
    this.entry,
    this.number,
    this.entryAt,
    this.total_tickets,
    this.amount,
    this.prize,
    this.date,
  });

  int? id;
  String? lotteryName;
  String? ticketName;
  String? ticketNo;
  int? entry;
  // int? number;
  List<dynamic>? number;
  DateTime? entryAt;
  DateTime? date;
  dynamic total_tickets;
  dynamic amount;
  dynamic prize;

  factory Entry.fromMap(Map<String, dynamic> json) => Entry(
        id: json["id"],
        lotteryName: json["lottery_name"],
        ticketName: json["ticket_name"],
        ticketNo: json["ticket_no"],
        entry: json["entry"],
        number: json["number"],
    prize: json["prize"],
          // number = (json['number'] as List?)?.map((dynamic e) => e as int).toList(),
         amount: json["amount"],
    total_tickets: json["total_tickets"],
        entryAt: json["entry_at"]!=null?DateTime.parse(json["entry_at"]):null,
    date: json["date"]!=null?DateTime.parse(json["date"]):null,
      );
}
