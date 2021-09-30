import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ButtonsWiget extends StatelessWidget {
  final DocumentSnapshot doc;
  ButtonsWiget({
    required this.doc,
  });

  void increment(
      {required String answer,
      required CollectionReference collectionReference}) async {
    collectionReference
        .doc(doc.id)
        .update({answer: FieldValue.increment(1)}).onError(
            (error, stackTrace) => print(error));
  }

  void registrationUsersAnswer(
      {required User user,
      required String answer,
      required CollectionReference collectionReference}) {
    collectionReference
        .doc(doc.id)
        .collection('users')
        .doc(user.uid)
        .set({'answer': answer});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
          ),
          onPressed: () {
            // isAnswerFun(Provider.of<User>(context, listen: false).uid);
            increment(
              answer: 'no',
              collectionReference: context.read<CollectionReference>(),
            );
            registrationUsersAnswer(
              user: Provider.of<User>(context, listen: false),
              answer: 'no',
              collectionReference: context.read<CollectionReference>(),
            );
          },
          child: Text(
            '   НЕТ   ',
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.green),
          onPressed: () {
            increment(
              answer: 'yes',
              collectionReference: context.read<CollectionReference>(),
            );
            registrationUsersAnswer(
              user: Provider.of<User>(context, listen: false),
              answer: 'yes',
              collectionReference: context.read<CollectionReference>(),
            );
          },
          child: Text('    ДА    '),
        ),
      ],
    );
  }
}
