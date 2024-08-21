
class DepartmeantModel{
  final int id;
  final String title;



  DepartmeantModel({required this.id,required this.title});
  factory DepartmeantModel.fromJson(Map<String,dynamic> data){
    return DepartmeantModel(id: data['id'], title: data['title']);
  }

}