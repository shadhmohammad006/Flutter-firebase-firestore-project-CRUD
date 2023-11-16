import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('donor');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Blood Donation App'),
          backgroundColor: Colors.red,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/add');
          },
          backgroundColor: Colors.red,
          child: Icon(
            Icons.add,
            size: 30,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: StreamBuilder(
            stream: donor.orderBy('name').snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot donorSnap =
                        snapshot.data.docs[index];
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 231, 227, 227),
                            borderRadius: BorderRadius.circular(20)),
                        height: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              child: CircleAvatar(
                                backgroundColor: Colors.red,
                                radius: 30,
                                child: Text(
                                  donorSnap['blood'],
                                  style: TextStyle(fontSize: 25),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  donorSnap['name'],
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  donorSnap['phone'].toString(),
                                  style: TextStyle(fontSize: 18),
                                )
                              ],
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/update',
                                      arguments: {
                                        'name': donorSnap['name'],
                                        'phone': donorSnap['phone'].toString(),
                                        'blood': donorSnap['blood'],
                                        'id': donorSnap.id,
                                      });
                                },
                                icon: Icon(
                                  Icons.edit,
                                  size: 30,
                                  color: Colors.blue,
                                )),
                            IconButton(
                                onPressed: () {
                                  deleteDonor(donorSnap.id);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  size: 30,
                                  color: Colors.red,
                                ))
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              return Container();
            }));
  }

  void deleteDonor(docId) {
    donor.doc(docId).delete();
  }
}
