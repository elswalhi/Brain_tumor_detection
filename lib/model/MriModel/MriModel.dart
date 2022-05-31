class ProcessModel
{
  String? name;
  String? uId;
  String? image;
  String? dateTime;
  String? confidence;
  String? result;
  bool isSaved=false;

  ProcessModel({
    this.dateTime,
    this.confidence,
    this.name,
    this.uId,
    this.image,
    this.result,
  });
  ProcessModel.fromJson(Map<String,dynamic> json )
  {
    confidence=json['confidence'];
    name=json['name'];
    dateTime=json['date'];
    image=json['image'];
    result=json['result'];

  }
  Map<String,dynamic> toMap(){
    return{
      'name':name,
      'uId':uId,
      'image':image,
      'date':dateTime,
      'result':result,
      'confidence':confidence,

    };
  }
}
// class PatientModel
// {
//   String? name;
//   String? dateTime;
//
//   PatientModel({
//     this.dateTime,
//     this.name,
//   });
//   PatientModel.fromJson(Map<String,dynamic> json )
//   {
//     name=json['name'];
//     dateTime=json['date'];
//
//   }
//   Map<String,dynamic> toMap(){
//     return{
//       'name':name,
//       'date':dateTime,
//
//     };
//   }
// }
// class MriModel
// {
//   String? image;
//   String? confidence;
//   String? result;
//   bool isSaved=false;
//
//   MriModel({
//     this.confidence,
//     this.image,
//     this.result,
//   });
//   MriModel.fromJson(Map<String,dynamic> json )
//   {
//     confidence=json['confidence'];
//     image=json['image'];
//     result=json['result'];
//
//   }
//   Map<String,dynamic> toMap(){
//     return{
//       'image':image,
//       'result':result,
//       'confidence':confidence,
//     };
//   }
// }


class PatientModel{
  String? name;
  String? dId;
  String? date;
  MriModel? mriModel;

  PatientModel({
    this.name,
    this.dId,
    this.date,
  });
  PatientModel.fromJson(Map<String, dynamic>? json){
    name = json!['name'];
    dId = json['dId'];
    date = json['date'];
    mriModel = MriModel.fromJson(json['data']);
  }

  Map<String, dynamic> toMap(){
    return {
      'name':name,
      'dId':dId,
      'date':date,
    };
  }
}

class MriModel{
  String? image;
  String? result;
  double? confidence;
  bool? isSaved;
  MriModel({
    this.image,
    this.result,
    this.confidence,
    this.isSaved,
  });
  MriModel.fromJson(Map<String, dynamic>? json){
    image = json!['image'];
    result = json['result'];
    confidence = json['confidence'];
    isSaved = json['isSaved'];
  }

  Map<String, dynamic> toMap(){
    return {
      'image':image,
      'result':result,
      'confidence':confidence,
      'isSaved':isSaved,
    };
  }
}



