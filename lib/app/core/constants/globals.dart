class Constants {
  static const bool isProduction = false;

  static const String devUrl = "http://10.3.21.22:7200/App/";
  static const String testingUrl = "http://10.3.20.230:7200/App/";
  static const String uatUrl = "https://10.107.201.107/ebrdmgw/App/";

  static const String baseUrl =
      uatUrl; // change this to devUrl, testingUrl, uatUrl
  static const String getNotificationHistory = "GetNotificationHistory";
  static const String registerFCMTokenPath = 'AssignFCMToken';
  static const String viewAccount = 'ViewAccount';
  static const String getEventsList = 'GetEvents';
  static const String fcmTopic =
      'broadcast-uat'; // broadcast fcm for testing "broadcast-testing" for uat "broadcast-uat"
  static const String verstionNumber = 'v1.6.1';
}
