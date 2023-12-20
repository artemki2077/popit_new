import 'package:equatable/equatable.dart';


class User extends Equatable{
  final int id;
  final String name;
  final int score;

  const User({
    required this.id,
    required this.name,
    required this.score
  });


  factory User.fromJson(Map json){
    return User(
      id: json['id'], 
      name: json['name'], 
      score: json['score']
    );
  }

  toJson(){
    return {
      "id": id,
      "name": name,
      "score": score
    };
  }

  @override
  String toString() {
    return 'User(id=$id, name=$name, score=$score)';
  }
  
  @override
  // TODO: implement props
  List<Object?> get props => [id, name, score];
}