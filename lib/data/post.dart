import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()

class Post {
  int userId;
  int id;
  String title;
  String body;
  Post(this.userId, this.id, this.title, this.body);

  //不同的类使用不同的mixin即可
  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}
