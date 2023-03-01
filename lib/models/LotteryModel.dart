class LottteryModel {
  LottteryModel({
    this.message,
    this.data,
  });

  String? message;
  Data? data;

  factory LottteryModel.fromMap(Map<String, dynamic> json) => LottteryModel(
        message: json["message"],
        data: json["data"].isEmpty ? null : Data.fromMap(json["data"]),
      );
}

class Data {
  Data({
    this.id,
    this.name,
    this.liveOn,
    this.expireOn,
    this.description,
    this.winning_amount,
    this.canCreateTicket,
    this.numbers,
    this.first_price,
    this.first_prize,
    this.second_price,
    this.second_prize,
    this.third_price,
    this.third_prize
  });

  int? id;
  String? name;
  dynamic winning_amount;
  dynamic first_prize;
  dynamic first_price;
  dynamic second_prize;
  dynamic second_price;
  dynamic third_prize;
  dynamic third_price;
  DateTime? liveOn;
  DateTime? expireOn;
  String? description;
  bool? canCreateTicket;
  List<int>? numbers;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
         winning_amount: json["winning_amount"],
        liveOn: DateTime.parse(json["live_on"]),
        expireOn: DateTime.parse(json["expire_on"]),
        description: json["description"],
        first_prize: json["first_prize"],
        first_price: json["first_price"],
        second_prize: json["second_prize"],
        second_price: json["second_price"],
        third_prize: json["third_prize"],
        third_price: json["third_price"],
        canCreateTicket: json["can_create_ticket"],
        numbers: List<int>.from(json["numbers"].map((x) => x)),
      );
}
