import 'package:flutter/material.dart';

int type = 0;

class MakeOrder extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PageState();
}

class PageState extends State<MakeOrder> {
  TextEditingController _editingController = TextEditingController();
  static List<TypeItemEntity> _typeList = [
    TypeItemEntity("取快递", 0),
    TypeItemEntity("取快递", 1),
    TypeItemEntity("代买饭", 2),
    TypeItemEntity("取快递", 3),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      children: <Widget>[
        Card(
          elevation: 5.0,
          margin: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  controller: _editingController,
                  keyboardType: TextInputType.number,
                  decoration: new InputDecoration(
                      contentPadding: const EdgeInsets.all(10.0),
                      icon: new Icon(Icons.directions_bike,
                          color: Colors.redAccent),
                      labelText: "请输入要帮跑的任务",
                      helperText: "输入你要让帮手帮你完成的任务"),
                  onChanged: (String str) {},
                ),
              ),
              TypeItemWidget(_typeList),
              SizedBox(height: 20.0)
            ],
          ),
        ),
        SizedBox(height: 20),
        RaisedButton(
          color: Colors.orangeAccent,
          onPressed: () {
            print(_editingController.text.toString() +
                '--------------' +
                type.toString());
          },
          child: Text(
            "去下单",
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }
}

class TypeItemEntity {
  String title;
  int index;

  TypeItemEntity(this.title, this.index);
}

class TypeItemWidget extends StatefulWidget {
  List<TypeItemEntity> _typeItemEntity;

  TypeItemWidget(this._typeItemEntity);

  @override
  State<StatefulWidget> createState() {
    return TypeItemWidgetState();
  }
}

class TypeItemWidgetState extends State<TypeItemWidget> {
  var _selectedStyle = BoxDecoration(color: Colors.orangeAccent);
  var _normalStyle = BoxDecoration(color: Colors.black12);
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.all(10.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10.0,
        childAspectRatio: 1.5,
        crossAxisSpacing: 10.0,
      ),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          child: Container(
            alignment: Alignment.center,
            decoration: widget._typeItemEntity[index].index == _currentIndex
                ? _selectedStyle
                : _normalStyle,
            child: GestureDetector(
              child: Text(widget._typeItemEntity[index].title),
            ),
          ),
          onTap: () {
            this.setState(() {
              _currentIndex = widget._typeItemEntity[index].index;
              type = widget._typeItemEntity[index].index;
            });
          },
        );
        ;
      },
      itemCount: widget._typeItemEntity.length,
    );
  }
}
