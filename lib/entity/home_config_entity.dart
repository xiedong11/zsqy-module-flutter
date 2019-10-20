class HomeConfigEntity {
	List<HomeConfigBanner> banner;
	String notificationLabel;

	HomeConfigEntity({this.banner});

	HomeConfigEntity.fromJson(Map<String, dynamic> json) {
		notificationLabel = json['notificationLabel'];
		if (json['banner'] != null) {
			banner = new List<HomeConfigBanner>();(json['banner'] as List).forEach((v) { banner.add(new HomeConfigBanner.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['notificationLabel']=this.notificationLabel;
		if (this.banner != null) {
      data['banner'] =  this.banner.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class HomeConfigBanner {
	String bannerContentUrl;
	String bannerImgUrl;

	HomeConfigBanner({this.bannerContentUrl, this.bannerImgUrl});

	HomeConfigBanner.fromJson(Map<String, dynamic> json) {
		bannerContentUrl = json['bannerContentUrl'];
		bannerImgUrl = json['bannerImgUrl'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['bannerContentUrl'] = this.bannerContentUrl;
		data['bannerImgUrl'] = this.bannerImgUrl;
		return data;
	}
}
