import 'package:flutter/material.dart';
import 'package:flutter_app/entity/heart_share_entity.dart';

class SocialListItem extends StatefulWidget {
  HeartShare _heartShare;

  SocialListItem(this._heartShare);

  @override
  State<StatefulWidget> createState() => SocialListItemState();
}

class SocialListItemState extends State<SocialListItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(color: Color(0xffeeeeee), height: 10),
        Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        ClipOval(
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: widget._heartShare.author.headImgUrl == null
                                ? Image.asset(
                                    "lib/img/ic_default_header_img.png",
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    widget._heartShare.author.headImgUrl,
                                    fit: BoxFit.cover),
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget._heartShare.username,
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                            Text(
                              "${widget._heartShare.createdAt} ${widget._heartShare.userFaculty}",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.black54),
                            )
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, top: 10, right: 10),
                      child: Text(
                        widget._heartShare.content,
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    widget._heartShare.dynamicImgUrl == null ||
                            widget._heartShare.dynamicImgUrl.length == 0
                        ? Text("")
                        : Container(
                            height: 120,
                            child: Padding(
                              padding:
                                  EdgeInsets.only(left: 10, top: 5, right: 10),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    widget._heartShare.dynamicImgUrl.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child: SizedBox(
                                        height: 110,
                                        width: 140,
                                        child: Image.network(
                                          widget
                                              ._heartShare.dynamicImgUrl[index],
                                          fit: BoxFit.cover,
                                        ),
                                      ));
                                },
                              ),
                            ),
                          ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 10),
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 25,
                            height: 25,
                            child: Image.asset(
                              "lib/img/share_likes.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text("9"),
                          SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            width: 25,
                            height: 25,
                            child: Image.asset("lib/img/share_reply.png",
                                fit: BoxFit.cover),
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text("0"),
                        ],
                      ),
                    )
                  ],
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: Container(
                    height: 20,
                    width: 80,
                    child: Center(
                        child: Text(
                      "#${widget._heartShare.contentType}#",
                      style: TextStyle(fontSize: 12, color: Colors.black87),
                    )),
                    decoration: BoxDecoration(
                      color: Color(0xffeeeeee),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
