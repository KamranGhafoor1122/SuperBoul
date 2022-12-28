class WalletPoints {
  bool? success;
  String? walletPoints;
  String? message;

  WalletPoints({this.success, this.walletPoints, this.message});

  WalletPoints.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    walletPoints = json['wallet_points'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['wallet_points'] = this.walletPoints;
    data['message'] = this.message;
    return data;
  }
}