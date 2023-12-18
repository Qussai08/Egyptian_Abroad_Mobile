class AppResponse {
  bool status;
  int? statusCode;
  dynamic data;
  String? errorCode;
  String? errorMessage;
  dynamic error;

  AppResponse({
    required this.status,
    this.statusCode,
    this.data,
    this.errorCode,
    this.errorMessage,
    this.error,
  });
}
