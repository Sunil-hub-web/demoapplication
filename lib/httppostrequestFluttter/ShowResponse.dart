import 'dart:convert';

List<ShowResponse> userModelDataFromJson(String str) =>
    List<ShowResponse>.from(json.decode(str).map((x) => ShowResponse.fromJson(x)));

String userModelDataToJson(List<ShowResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShowResponse {
  String? name;
  String? job;
  String? id;
  String? createdAt;

  ShowResponse({this.name, this.job, this.id, this.createdAt});

  ShowResponse.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    job = json['job'];
    id = json['id'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['job'] = job;
    data['id'] = id;
    data['createdAt'] = createdAt;
    return data;
  }
}