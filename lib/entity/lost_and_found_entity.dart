import 'package:data_plugin/bmob/table/bmob_object.dart';
import 'package:flutter_app/entity/user_entity.dart';

class LostAndFoundEntity extends BmobObject{
	User userEntity;
	String createdAt;
	String showName;
	List<String> goodsUrl;
	String title;
	int type;
	String content;
	String objectId;
	String updatedAt;

	LostAndFoundEntity({this.userEntity, this.createdAt, this.showName, this.goodsUrl, this.title, this.type, this.content, this.objectId, this.updatedAt});

	LostAndFoundEntity.fromJson(Map<String, dynamic> json) {
		userEntity = json['userEntity'] != null ? new User.fromJson(json['userEntity']) : null;
		createdAt = json['createdAt'];
		showName = json['showName'];
		goodsUrl = json['goodsUrl']?.cast<String>();
		title = json['title'];
		type = json['type'];
		content = json['content'];
		objectId = json['objectId'];
		updatedAt = json['updatedAt'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.userEntity != null) {
      data['userEntity'] = this.userEntity.toJson();
    }
		data['createdAt'] = this.createdAt;
		data['showName'] = this.showName;
		data['goodsUrl'] = this.goodsUrl;
		data['title'] = this.title;
		data['type'] = this.type;
		data['content'] = this.content;
		data['objectId'] = this.objectId;
		data['updatedAt'] = this.updatedAt;
		return data;
	}

  @override
  Map getParams() {
    return toJson();
  }
}

