class TransactionsModel {
  TransactionsModel({
    this.message,
    this.transactionsList,
  });

  String? message;
  List<SingleTransaction>? transactionsList;

  factory TransactionsModel.fromMap(Map<String, dynamic> json) => TransactionsModel(
        message: json["message"],
        transactionsList: List<SingleTransaction>.from(json["data"].map((x) => SingleTransaction.fromMap(x))),
      );
}

class SingleTransaction {
  SingleTransaction({
    this.transactionId,
    this.amount,
    this.type,
    this.status,
    this.transactionAt,
  });

  String? transactionId;
  double? amount;
  String? type;
  String? status;
  DateTime? transactionAt;

  factory SingleTransaction.fromMap(Map<String, dynamic> json) => SingleTransaction(
        transactionId: json["transaction_id"],
        amount: json["amount"].toDouble(),
        type: json["type"],
        status: json["status"],
        transactionAt: DateTime.parse(json["transaction_at"]),
      );
}
