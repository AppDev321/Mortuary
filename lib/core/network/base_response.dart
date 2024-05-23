class BaseResponse<T> {

  final String message;
  final T? data;

  BaseResponse(this.message, this.data,);

  factory BaseResponse.fromJson(Map<String, dynamic> json, T Function(dynamic) fromJson) {

    return BaseResponse(
      json['message'] as String,
      json.containsKey('data') ? fromJson(json['data']) : null,

    );
  }

  @override
  String toString() {
    return 'ApiResponse{message: $message, data: $data}';
  }
}
