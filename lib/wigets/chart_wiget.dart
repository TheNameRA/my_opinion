import 'package:flutter/material.dart';

class ChartWidget extends StatelessWidget {
  final int yes, no;
  ChartWidget({required this.yes, required this.no});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: no,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red.withAlpha(128),
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
              height: 36,
              child: Center(
                child: Text(
                  '${(no / (no + yes) * 100).round()}%',
                  softWrap: false,
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 1,
          ),
          Expanded(
            flex: yes,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.green.withAlpha(128),
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
              height: 36,
              child: Center(
                child: Text(
                  '${(yes / (no + yes) * 100).round()}%',
                  softWrap: false,
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
