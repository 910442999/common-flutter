import 'package:flutter/material.dart';

class YQMenuDialog extends StatelessWidget {
  List<String> nameItems;
  List<String> urlItems;
  Function onSelected;

  YQMenuDialog(this.nameItems, this.urlItems, this.onSelected);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      height: 200.0,
      child: Column(
        children: <Widget>[
          Expanded(
              child: Container(
            alignment: Alignment.center,
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 5.0,
                  childAspectRatio: 1.0),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      Navigator.pop(context);
                      onSelected(nameItems[index]);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                            child: Image.asset(
                              urlItems[index],
                              width: 50.0,
                              height: 50.0,
                              fit: BoxFit.fill,
                            )),
                        Text(nameItems[index])
                      ],
                    ));
              },
              itemCount: nameItems.length,
            ),
          )),
          Container(
            height: 5,
            color: Colors.grey[200],
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 60,
              alignment: Alignment.center,
              child: Text(
                '取  消',
                style: new TextStyle(fontSize: 20.0, color: Colors.black),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
