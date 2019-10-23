import 'package:data_plugin/bmob/table/bmob_object.dart';
import 'package:flutter_app/entity/user_entity.dart';

class QyPictureEntity extends BmobObject {
  User userEntity;
  String createdAt;
  String pictureDesc;
  String pictureUrl;
  String location;
  String objectId;
  String updatedAt;

  QyPictureEntity(
      {this.userEntity,
      this.createdAt,
      this.pictureDesc,
      this.pictureUrl,
      this.location,
      this.objectId,
      this.updatedAt});

  QyPictureEntity.fromJson(Map<String, dynamic> json) {
    userEntity = json['userEntity'] != null
        ? new User.fromJson(json['userEntity'])
        : null;
    createdAt = json['createdAt'];
    pictureDesc = json['pictureDesc'];
    pictureUrl = json['pictureUrl'];
    location = json['location'];
    objectId = json['objectId'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userEntity != null) {
      data['userEntity'] = this.userEntity.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['pictureDesc'] = this.pictureDesc;
    data['pictureUrl'] = this.pictureUrl;
    data['location'] = this.location;
    data['objectId'] = this.objectId;
    data['updatedAt'] = this.updatedAt;
    return data;
  }

  @override
  Map getParams() {
    return toJson();
  }
}
