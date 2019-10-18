import 'package:data_plugin/bmob/table/bmob_object.dart';
import 'package:flutter_app/entity/user_entity.dart';

class HeartShare extends BmobObject {
  String createdAt;
  bool isAnonymous;
  String userFaculty;
  User author;
  String userGender;
  List<String> dynamicImgUrl;
  String contentType;
  String content;
  String objectId;
  int commentCount;
  String updatedAt;
  String username;

  HeartShare(
      {this.createdAt,
      this.isAnonymous,
      this.userFaculty,
      this.author,
      this.userGender,
      this.dynamicImgUrl,
      this.contentType,
      this.content,
      this.objectId,
      this.commentCount,
      this.updatedAt,
      this.username});

  HeartShare.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    isAnonymous = json['isAnonymous'];
    userFaculty = json['userFaculty'];
    author = json['author'] != null ? new User.fromJson(json['author']) : null;
    userGender = json['userGender'];
    dynamicImgUrl = json['dynamicImgUrl']?.cast<String>();
    contentType = json['contentType'];
    content = json['content'];
    objectId = json['objectId'];
    commentCount = json['commentCount'];
    updatedAt = json['updatedAt'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['isAnonymous'] = this.isAnonymous;
    data['userFaculty'] = this.userFaculty;
    if (this.author != null) {
      data['author'] = this.author.toJson();
    }
    data['userGender'] = this.userGender;
    data['dynamicImgUrl'] = this.dynamicImgUrl;
    data['contentType'] = this.contentType;
    data['content'] = this.content;
    data['objectId'] = this.objectId;
    data['commentCount'] = this.commentCount;
    data['updatedAt'] = this.updatedAt;
    data['username'] = this.username;
    return data;
  }

  @override
  Map getParams() {
    return toJson();
  }
}
