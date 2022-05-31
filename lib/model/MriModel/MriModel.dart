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
  ProcessModel.FromJosn(Map<String,dynamic> json )
  {
    confidence=json['confidence'];
    name=json['name'];
    dateTime=json['date'];
    uId=json['uId'];
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
class PatientModel
{
  String? name;
  String? uId;
  String? dateTime;

  PatientModel({
    this.dateTime,
    this.name,
    this.uId,
  });
  PatientModel.FromJosn(Map<String,dynamic> json )
  {
    name=json['name'];
    dateTime=json['date'];
    uId=json['uId'];

  }
  Map<String,dynamic> toMap(){
    return{
      'name':name,
      'uId':uId,
      'date':dateTime,

    };
  }
}
class MriModel
{
  String? image;
  String? confidence;
  String? result;
  bool isSaved=false;

  MriModel({
    this.confidence,
    this.image,
    this.result,
  });
  MriModel.FromJosn(Map<String,dynamic> json )
  {
    confidence=json['confidence'];
    image=json['image'];
    result=json['result'];

  }
  Map<String,dynamic> toMap(){
    return{
      'image':image,
      'result':result,
      'confidence':confidence,
    };
  }
}
