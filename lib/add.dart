import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('donor');
  final BloodGroups = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
  String? SelectedGroup;
  TextEditingController donorName = TextEditingController();
  TextEditingController donorPhone = TextEditingController();

  void addDonor() {
    final data = {
      'name': donorName.text,
      'phone': donorPhone.text,
      'blood': SelectedGroup
    };
    donor.add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('add donor'),
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
                  addDonor();
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all(Size(double.infinity, 50)),
                    backgroundColor: MaterialStateProperty.all(Colors.red)),
                child: Text(
                  'Submit',
                  style: TextStyle(fontSize: 20),
                ))
          ],
        ),
      ),
    );
  }
}
