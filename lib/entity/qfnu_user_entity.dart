class QfnuUserEntity {
	String userdwmc;
	String userrealname;
	bool success;
	String usertype;
	QfnuUserUser user;
	String token;

	QfnuUserEntity({this.userdwmc, this.userrealname, this.success, this.usertype, this.user, this.token});

	QfnuUserEntity.fromJson(Map<String, dynamic> json) {
		userdwmc = json['userdwmc'];
		userrealname = json['userrealname'];
		success = json['success'];
		usertype = json['usertype'];
		user = json['user'] != null ? new QfnuUserUser.fromJson(json['user']) : null;
		token = json['token'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['userdwmc'] = this.userdwmc;
		data['userrealname'] = this.userrealname;
		data['success'] = this.success;
		data['usertype'] = this.usertype;
		if (this.user != null) {
      data['user'] = this.user.toJson();
    }
		data['token'] = this.token;
		return data;
	}
}

class QfnuUserUser {
	String userdwmc;
	String scsj;
	String sjyzm;
	String usertype;
	String useraccount;
	String userpasswd;
	String username;

	QfnuUserUser({this.userdwmc, this.scsj, this.sjyzm, this.usertype, this.useraccount, this.userpasswd, this.username});

	QfnuUserUser.fromJson(Map<String, dynamic> json) {
		userdwmc = json['userdwmc'];
		scsj = json['scsj'];
		sjyzm = json['sjyzm'];
		usertype = json['usertype'];
		useraccount = json['useraccount'];
		userpasswd = json['userpasswd'];
		username = json['username'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['userdwmc'] = this.userdwmc;
		data['scsj'] = this.scsj;
		data['sjyzm'] = this.sjyzm;
		data['usertype'] = this.usertype;
		data['useraccount'] = this.useraccount;
		data['userpasswd'] = this.userpasswd;
		data['username'] = this.username;
		return data;
	}
}
