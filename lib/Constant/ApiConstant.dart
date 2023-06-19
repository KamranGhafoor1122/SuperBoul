import 'package:superlotto/models/language_model.dart';

class ApiConst {

  //static const String BASE_URL = 'https://superlotto.mabhattiltd.com/public/api/';
  static const String BASE_URL = 'https://brasshaiti.net/api/';
  static const String login = 'login';
  static const String signup = 'sign-up';
  static const String verify_code = 'verify-code';
  static const String update_progfile = 'user/profile/update';
  static const String get_profile = 'user/profile';
  static const String change_password = 'user/change-password';
  static const String set_pin = 'user/set-password';
  static const String sendOTP = 'send-otp';
  static const String getLottery = 'lottery';
  static const String drawEntry = 'draw-entry';
  static const String sellerPlayNumber = 'sellerPlayNumber';
  static const String addTicket = 'ticket/add';
  static const String addSellerTicket = 'sellerCreateTicket';
  static const String getTicket = 'ticket';
  static const String gettransactions = 'transactions';
  static const String getTicketsList = 'tickets';
  static const String getWinnings = 'get-winnings';
  static const String getSellerTickets = 'sellerGetAllTickets';
  static const String getSellerTransactions = 'sellerGetAllTransactions';
  static const String getSellerEntries = 'sellerGetAllEntries';
  static const String getSellerPendingBalance = 'sellerGetPendingBalance';
  static const String getBalanaceA = 'sellerGetAllTickets';
  static const String getSellerWinners = 'sellerGetWinners';
  static const String getEntriesList = 'entries?ticket_id=';
  static const String addcredit = 'credit';
  static const String createPayment = 'createPayment';
  static const String checkPaymentOrderStatus = 'checkOrderIdStatus';
  static const String getWalletPoints = 'getWalletPoints';
  static const String getUser = 'user/profile';

  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';
  static List<LanguageModel> languages = [
    LanguageModel(imageUrl: "assets/Images/united_kindom.png", languageName: 'English', countryCode: 'US', languageCode: 'en'),
    LanguageModel(imageUrl: "assets/Images/haiti.png", languageName: 'Haiti', countryCode: 'CR', languageCode: 'ht'),
  ];

}
