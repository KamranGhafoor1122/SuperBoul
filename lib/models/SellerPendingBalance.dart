class SellerPendingBalance {
bool? success;
int? pendingBalance;
String? message;

SellerPendingBalance({this.success, this.pendingBalance, this.message});

SellerPendingBalance.fromJson(Map<String, dynamic> json) {
success = json['success'];
pendingBalance = json['pending_balance'];
message = json['message'];
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['success'] = this.success;
  data['pending_balance'] = this.pendingBalance;
  data['message'] = this.message;
  return data;
}
}
