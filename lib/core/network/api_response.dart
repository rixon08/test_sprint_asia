class ApiResponse<T> {
  final int code;
  final bool status;
  final String message;
  final T? data;

  ApiResponse({
    this.code = 0,
    required this.status,
    required this.message,
    this.data,
  });

  factory ApiResponse.fromJson(
      Map<String, dynamic> json, T Function(dynamic) fromJsonT) {
    return ApiResponse(
      code: json["code"] ?? 0,
      status: json["status"] ?? false,
      message: json["message"] ?? "Unknown error",
      data: json["data"] != null ? fromJsonT(json["data"]) : null,
    );
  }

  bool get isSuccess => status;
}