import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class updateUser extends StatefulWidget {
  const updateUser({super.key});

  @override
  State<updateUser> createState() => _updateUserState();
}

class _updateUserState extends State<updateUser> {
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('donor');
  final BloodGroups = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
  String? SelectedGroup;
  TextEditingController donorName = TextEditingController();
  TextEditingController donorPhone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    donorName.text = args['name'];
    donorPhone.text = args['phone'];
    SelectedGroup = args['blood'];
    final docId = args['id'];
    return Scaffold(
      appBar: AppBar(
        title: Text('update donor'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: donorName,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Donor Name'),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: donorPhone,
              keyboardType: TextInputType.number,
              maxLength: 10,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Mobile Number'),
            ),
            DropdownButtonFormField(
                value: SelectedGroup,
                decoration: InputDecoration(
                    label: Text('select blood group'),
                    border: OutlineInputBorder()),
                items: BloodGroups.map((e) => DropdownMenuItem(
                      child: Text(e),
                      value: e,
                    )).toList(),
                onChanged: (val) {
                  SelectedGroup = val as String?;
                }),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  updateDonor(docId);
                  
                },
                style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all(Size(double.infinity, 50)),
                    backgroundColor: MaterialStateProperty.all(Colors.red)),
                child: Text(
                  'update',
                  style: TextStyle(fontSize: 20),
                ))
          ],
        ),
      ),
    );
  }

  void updateDonor(docId) {
    final data = {
      'name': donorName.text,
      'phone': donorPhone.text,
      'blood': SelectedGroup
    };
    donor.doc(docId).update(data).then((value) => Navigator.pop(context));
  }
}
