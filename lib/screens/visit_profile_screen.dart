// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';

// class VisitProfileScreen extends StatefulWidget {

//   const VisitProfileScreen({Key? key}) : super(key: key);

//   @override

//   _VisitProfileScreenState createState() => _VisitProfileScreenState();
// }

// class _VisitProfileScreenState extends State<VisitProfileScreen> {

//   TextEditingController nameController = TextEditingController();
//   TextEditingController phoneNumberController = TextEditingController();
//   TextEditingController emailController = TextEditingController();

//   String name = '';
//   String phoneNumber = '';
//   String email = '';
//   String gender = ''; // Default gender
//   DateTime? dob; // Date of Birth


//   bool isDataSaved = false; // To track if data is saved

//   final DatabaseReference _userRef = FirebaseDatabase.instance.reference().child('users');

//   @override

//   void initState() {
//     super.initState();
//     // Set initial values to controllers
//     nameController.text = name;
//     phoneNumberController.text = phoneNumber;
//     emailController.text = email;
//   }
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Visit Profile'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildProfileItem(Icons.person, 'Name', name, () {
              
//             }),
//             _buildProfileItem(Icons.phone, 'Phone Number', phoneNumber, () {
              
//             }),
//             _buildProfileItem(Icons.email, 'Email', email, () {
              
//             }),
//             _buildProfileItem(Icons.calendar_today, 'Date of Birth',
//                 dob != null ? dob.toString().substring(0, 10) : 'Select Date', () {
//               _selectDate(context);
//             }),
//             _buildProfileItem(Icons.person_outline, 'Gender', gender, () {
//               _showGenderDialog(context);
//             }),

//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 _saveUserData();
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: isDataSaved ? Colors.yellow : null,
//               ),
//               child: Text('Save'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildProfileItem(IconData icon, String label, String value, VoidCallback onTap) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Row(
//         children: [
//           Icon(icon),
//           SizedBox(width: 16),
//           Text(
//             label,
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           // Spacer(),
//           // Icon(Icons.navigate_next), // This is the ">" symbol
//         ],
//       ),
//       SizedBox(height: 8),
//         TextField(
//           controller: controller,
//           decoration: InputDecoration(
//             hintText: 'Enter $label',
//           ),
//           readOnly: label == 'Date of Birth' || label == 'Gender',
//           onTap: onTap,
//           onChanged: (newValue) {
//             _updateUserInfo(label, newValue); // Pass the field name and new value
//           },
//         ),
//       SizedBox(height: 8),
//       Divider(),
//     ],
//   );
// }

//   void _updateUserInfo(String fieldName, String newValue) {
//   setState(() {
//     // Update local state based on field name
//     switch (fieldName) {
//       case 'Name':
//         name = newValue;
//         break;
//       case 'Phone Number':
//         phoneNumber = newValue;
//         break;
//       case 'Email':
//         email = newValue;
//         break;
//       case 'Gender':
//         gender = newValue;
//         break;
//       default:
//         break;
//     }
//   });
// }


//   void _saveUserData() {
//     _userRef.child('userId').set({
//       'name': name,
//       'phoneNumber': phoneNumber,
//       'email': email,
//       'gender': gender,
      
//       // Add other fields as needed
//     }).then((_) {
//       setState(() {
//         isDataSaved = true;
//       });
//     });
//   }

//   // void _editProfileItem(String fieldName, String value) {
//   //   // Implement your logic to edit the profile item
//   //   print('Editing $fieldName: $value');
//   // }

//   void _showGenderDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Select Gender'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListTile(
//                 title: Text('Male'),
//                 onTap: () {
//                   setState(() {
//                     gender = 'Male';
//                   });
//                   Navigator.pop(context);
//                 },
//               ),
//               ListTile(
//                 title: Text('Female'),
//                 onTap: () {
//                   setState(() {
//                     gender = 'Female';
//                   });
//                   Navigator.pop(context);
//                 },
//               ),
//               ListTile(
//                 title: Text('Other'),
//                 onTap: () {
//                   setState(() {
//                     gender = 'Other';
//                   });
//                   Navigator.pop(context);
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: dob ?? DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime.now(),
//     );
//     if (picked != null && picked != dob) {
//       setState(() {
//         dob = picked;
//       });
//     }
//   }
// }


import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class VisitProfileScreen extends StatefulWidget {
  const VisitProfileScreen({Key? key}) : super(key: key);

  @override
  _VisitProfileScreenState createState() => _VisitProfileScreenState();
}

class _VisitProfileScreenState extends State<VisitProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  String name = '';
  String phoneNumber = '';
  String email = '';
  String gender = ''; // Default gender
  DateTime? dob; // Date of Birth

  bool isDataSaved = false; // To track if data is saved

  final DatabaseReference _userRef =
      FirebaseDatabase.instance.reference().child('users');

  @override
  void initState() {
    super.initState();
    // Set initial values to controllers
    nameController.text = name;
    phoneNumberController.text = phoneNumber;
    emailController.text = email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileItem(Icons.person, 'Name', nameController),
            _buildProfileItem(Icons.phone, 'Phone Number', phoneNumberController),
            _buildProfileItem(Icons.email, 'Email', emailController),
            _buildProfileItem(
                Icons.calendar_today,
                'Date of Birth',
                null,
                text: dob != null ? dob.toString().substring(0, 10) : 'Select Date',
                onTap: () => _selectDate(context),
              ),

            _buildProfileItem(
              Icons.person_outline,
              'Gender',
              null,
              text: gender.isNotEmpty ? gender : 'Select Gender',
              onTap: () => _showGenderDialog(context),
            ),

            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _saveUserData();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isDataSaved ? Colors.yellow : null,
              ),
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(
    IconData icon,
    String label,
    TextEditingController? controller,
    {String? text, VoidCallback? onTap}
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon),
            SizedBox(width: 16),
            Text(
              label,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 8),
        if (controller != null)
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Enter $label',
            ),
            onChanged: (newValue) {
              _updateUserInfo(label, newValue); // Pass the field name and new value
            },
          )
        else
          InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(text ?? ''),
            ),
          ),
        SizedBox(height: 8),
        Divider(),
      ],
    );
  }



  void _updateUserInfo(String fieldName, String newValue) {
    setState(() {
      // Update local state based on field name
      switch (fieldName) {
        case 'Name':
          name = newValue;
          break;
        case 'Phone Number':
          phoneNumber = newValue;
          break;
        case 'Email':
          email = newValue;
          break;
        case 'Gender':
          gender = newValue;
          break;
        default:
          break;
      }
    });
  }

  void _saveUserData() {
    _userRef.child('userId').set({
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'gender': gender,
      // Add other fields as needed
    }).then((_) {
      setState(() {
        isDataSaved = true;
      });
    });
  }

  void _showGenderDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Gender'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Male'),
                onTap: () {
                  setState(() {
                    gender = 'Male';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Female'),
                onTap: () {
                  setState(() {
                    gender = 'Female';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Other'),
                onTap: () {
                  setState(() {
                    gender = 'Other';
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dob ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != dob) {
      setState(() {
        dob = picked;
      });
    }
  }
}
