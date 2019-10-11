class EmptyClassRoomEntity {
	String xnxqid;
	List<EmptyClassRoomData> data;
	bool success;

	EmptyClassRoomEntity({this.xnxqid, this.data, this.success});

	EmptyClassRoomEntity.fromJson(Map<String, dynamic> json) {
		xnxqid = json['xnxqid'];
		if (json['data'] != null) {
			data = new List<EmptyClassRoomData>();(json['data'] as List).forEach((v) { data.add(new EmptyClassRoomData.fromJson(v)); });
		}
		success = json['success'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['xnxqid'] = this.xnxqid;
		if (this.data != null) {
      data['data'] =  this.data.map((v) => v.toJson()).toList();
    }
		data['success'] = this.success;
		return data;
	}
}

class EmptyClassRoomData {
	List<EmptyClassRoomDataJslist> jsList;
	String jxl;

	EmptyClassRoomData({this.jsList, this.jxl});

	EmptyClassRoomData.fromJson(Map<String, dynamic> json) {
		if (json['jsList'] != null) {
			jsList = new List<EmptyClassRoomDataJslist>();(json['jsList'] as List).forEach((v) { jsList.add(new EmptyClassRoomDataJslist.fromJson(v)); });
		}
		jxl = json['jxl'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.jsList != null) {
      data['jsList'] =  this.jsList.map((v) => v.toJson()).toList();
    }
		data['jxl'] = this.jxl;
		return data;
	}
}

class EmptyClassRoomDataJslist {
	String jzwmc;
	String jsid;
	int yxzws;
	int zws;
	String xqmc;
	String jzwid;
	String jsmc;
	String jsh;

	EmptyClassRoomDataJslist({this.jzwmc, this.jsid, this.yxzws, this.zws, this.xqmc, this.jzwid, this.jsmc, this.jsh});

	EmptyClassRoomDataJslist.fromJson(Map<String, dynamic> json) {
		jzwmc = json['jzwmc'];
		jsid = json['jsid'];
		yxzws = json['yxzws'];
		zws = json['zws'];
		xqmc = json['xqmc'];
		jzwid = json['jzwid'];
		jsmc = json['jsmc'];
		jsh = json['jsh'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['jzwmc'] = this.jzwmc;
		data['jsid'] = this.jsid;
		data['yxzws'] = this.yxzws;
		data['zws'] = this.zws;
		data['xqmc'] = this.xqmc;
		data['jzwid'] = this.jzwid;
		data['jsmc'] = this.jsmc;
		data['jsh'] = this.jsh;
		return data;
	}
}
