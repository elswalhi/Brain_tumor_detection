class Testmodel {
  String? result;
  int? response;

  Testmodel({this.result, this.response});

  Testmodel.fromJson(Map<String, dynamic> json) {
    result = json['Result'];
    response = json['response'];
  }
}
