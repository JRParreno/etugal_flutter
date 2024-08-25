import 'package:etugal_flutter/core/common/entities/list_response.dart';

class ListResponseModel extends ListResponse {
  const ListResponseModel({
    required super.count,
    required super.next,
    required super.previous,
  });

  factory ListResponseModel.fromJson(Map<String, dynamic> json) {
    return ListResponseModel(
      count: json["count"],
      next: json["next"],
      previous: json["previous"],
    );
  }
}
