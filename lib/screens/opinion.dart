import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_opinion/wigets/tile_wiget.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class OpinionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<void> _showMyDialog() async {
      return showDialog<void>(
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Предложить вопрос'),
            content: SingleChildScrollView(
              child: TextField(),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('ОТМЕНА'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('ОТПРАВИТЬ'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
        context: context,
      );
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showMyDialog();
        },
        child: Icon(Icons.add),
        tooltip: 'Предложить вопрос',
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('Моё мнение'),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            color: Colors.white,
            onPressed: () {
              Share.share(
                  'Выскажи своё мнение: https://play.google.com/store/apps/details?id=ru.instantapp.anagram');
            },
          ),
        ],
      ),
      body: Body(),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference collectionPolls =
        FirebaseFirestore.instance.collection('polls');
    return Provider<CollectionReference>.value(
      value: collectionPolls,
      child: StreamBuilder<QuerySnapshot>(
        stream:
            collectionPolls.orderBy('timestamp', descending: true).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot doc) {
              return FutureBuilder<bool>(
                  future: isAnswerFun(
                    collectionReference: collectionPolls,
                    doc: doc,
                    user: context.watch<User>(),
                  ),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return TileWidget(
                        doc: doc,
                        isAnswer: snapshot.data,
                      );
                    } else
                      return Container();
                  });
            }).toList(),
          );
        },
      ),
    );
  }

  Future<bool> isAnswerFun(
      {required CollectionReference collectionReference,
      required User user,
      required DocumentSnapshot doc}) async {
    var docREF =
        collectionReference.doc(doc.id).collection('users').doc(user.uid);
    var documentSnapshot = await docREF.get();
    return documentSnapshot.exists;
  }
}
