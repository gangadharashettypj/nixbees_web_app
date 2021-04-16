/*
 * @Author GS
 */

class Response {
  int code;
  bool status;
  String errorMessage;
  String message;

  Response({
    this.code,
    this.status,
    this.errorMessage,
    this.message,
  });
}
