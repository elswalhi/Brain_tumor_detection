class ResponseData {
  int? response;
  Result? result;

  ResponseData({this.response, this.result});

  ResponseData.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    result =
    json['result'] != null ? Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response'] = response;
    return data;
  }
}

class Result {
  double? resultImg;

  Result({this.resultImg});

  Result.fromJson(Map<String, dynamic> json) {
    resultImg = json['resultImg'];
  }

}
