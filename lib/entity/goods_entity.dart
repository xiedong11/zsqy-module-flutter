import 'package:data_plugin/bmob/table/bmob_object.dart';
import 'package:flutter_app/entity/user_entity.dart';

class GoodsEntity extends BmobObject{
	User goodsOwner;
	String ownerContactNum;
	String goodsContent;
	int tradeState;
	int goodsType;
	String goodsOwnerLocal;
	String createdAt;
	List<String> goodsUrl;
	String goodsPrice;
	String goodsTitle;
	String objectId;
	int tradeType;
	String updatedAt;

	GoodsEntity({this.goodsOwner, this.ownerContactNum, this.goodsContent, this.tradeState, this.goodsType, this.goodsOwnerLocal, this.createdAt, this.goodsUrl, this.goodsPrice, this.goodsTitle, this.objectId, this.tradeType, this.updatedAt});

	GoodsEntity.fromJson(Map<String, dynamic> json) {
		goodsOwner = json['goodsOwner'] != null ? new User.fromJson(json['goodsOwner']) : null;
		ownerContactNum = json['ownerContactNum'];
		goodsContent = json['goodsContent'];
		tradeState = json['tradeState'];
		goodsType = json['goodsType'];
		goodsOwnerLocal = json['goodsOwnerLocal'];
		createdAt = json['createdAt'];
		goodsUrl = json['goodsUrl']?.cast<String>();
		goodsPrice = json['goodsPrice'];
		goodsTitle = json['goodsTitle'];
		objectId = json['objectId'];
		tradeType = json['tradeType'];
		updatedAt = json['updatedAt'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.goodsOwner != null) {
      data['goodsOwner'] = this.goodsOwner.toJson();
    }
		data['ownerContactNum'] = this.ownerContactNum;
		data['goodsContent'] = this.goodsContent;
		data['tradeState'] = this.tradeState;
		data['goodsType'] = this.goodsType;
		data['goodsOwnerLocal'] = this.goodsOwnerLocal;
		data['createdAt'] = this.createdAt;
		data['goodsUrl'] = this.goodsUrl;
		data['goodsPrice'] = this.goodsPrice;
		data['goodsTitle'] = this.goodsTitle;
		data['objectId'] = this.objectId;
		data['tradeType'] = this.tradeType;
		data['updatedAt'] = this.updatedAt;
		return data;
	}

  @override
  Map getParams() {
    return toJson();
  }
}

