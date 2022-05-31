class Testmodel {
  int? response;
  String? result;

  Testmodel({this.response, this.result});

  Testmodel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    result = json['result'];
  }


}
