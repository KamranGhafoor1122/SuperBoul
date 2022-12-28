class OrderStatusModel {
  bool? success;
  String? paymentStatus;
  String? message;

  OrderStatusModel({this.success, this.paymentStatus, this.message});

  OrderStatusModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    paymentStatus = json['payment_status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['payment_status'] = this.paymentStatus;
    data['message'] = this.message;
    return data;
  }
}