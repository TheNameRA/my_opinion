import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_opinion/wigets/buttons_wiget.dart';
import 'package:my_opinion/wigets/chart_wiget.dart';

class TileWidget extends StatelessWidget {
  final DocumentSnapshot doc;
  final bool isAnswer;
  TileWidget({
    required this.doc,
    required this.isAnswer,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      color: isAnswer ? Colors.blueGrey[50] : null,
      margin: EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Column(
        children: [
          ListTile(
            title: Text(
              doc.get('question'),
              style: isAnswer
                  ? TextStyle(
                      color: Colors.black87,
                    )
                  : TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
            ),
          ),
          isAnswer
              ? ChartWidget(
                  yes: doc.get('yes') == 0 ? 1 : doc.get('yes'),
                  no: doc.get('no') == 0 ? 1 : doc.get('no'),
                )
              : ButtonsWiget(
                  doc: doc,
                ),
          SizedBox(
            height: 4,
          )
        ],
      ),
    );
  }
}
