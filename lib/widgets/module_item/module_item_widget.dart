
import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/module_item/module_item_entity.dart';

class ModuleItemWidget extends StatelessWidget {
  ModuleItemEntity _moduleItemEntity;

  ModuleItemWidget(this._moduleItemEntity);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => _moduleItemEntity.nextPage));
      },
      child: Column(
        children: <Widget>[
          SizedBox(height: 5),
          Image.asset(
            _moduleItemEntity.imgPath,
            width: 40,
            height: 40,
          ),
          SizedBox(height: 5),
          Text(_moduleItemEntity.title)
        ],
      ),
    );
  }
}
