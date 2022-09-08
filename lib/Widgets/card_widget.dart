// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class buildCard extends StatelessWidget {
  String city = '';
  String jobType = '';
  String postText = '';
  DateTime postDate;

  buildCard({
    Key? key,
    required this.city,
    required this.jobType,
    required this.postText,
    required this.postDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // String result = DateFormat('MMM, dd').format(postDate);

    return Card(
        elevation: 4.0,
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(),
              title: Text(jobType),
              subtitle: Text(city),
              trailing: Icon(Icons.favorite_outline),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.centerLeft,
              child: Text(postText),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                children: [
                  Text(calculateDifference(postDate).toString()),
                  ButtonBar(
                    children: [
                      TextButton(
                        child: const Text('CONTACT AGENT'),
                        onPressed: () {/* ... */},
                      ),
                      TextButton(
                        child: const Text('LEARN MORE'),
                        onPressed: () {/* ... */},
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ));
  }

  calculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    int result = DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;

    String resultado = result.abs().toString() + ' dias';
    if (result < -2) {
      return resultado;
    } else {
      return null;
    }
  }
}
