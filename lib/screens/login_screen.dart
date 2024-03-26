import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:rapido/screens/otp_screen.dart';

class PhoneHome extends StatefulWidget {
  const PhoneHome({Key? key}) : super(key: key);

  @override
  State<PhoneHome> createState() => PhoneHomeState();
}

class PhoneHomeState extends State<PhoneHome> {
  TextEditingController phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String counterText = '0';

  sendCode() async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${phoneNumberController.text}',
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          Get.snackbar('Error Occurred', e.code);
        },
        codeSent: (String vid, int? token) {
          Get.to(OtpPage(vid: vid));
        },
        codeAutoRetrievalTimeout: (vid) {},
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error Occurred', e.code);
    } catch (e) {
      Get.snackbar('Error Occurred', e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Image.asset(
                  'assets/images/logo1.png',
                  width: 90,
                  height: 70,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'What\'s your number?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Enter your phone number to proceed',
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 10),
              TextFormField(
                maxLength: 10,
                keyboardType: TextInputType.phone,
                controller: phoneNumberController,
                decoration: InputDecoration(
                  prefix: Text("+91 ") ,
                  prefixStyle: TextStyle(fontSize: 15),
                  prefixIcon: Icon(Icons.phone),
                  counterText: '$counterText / 10',
                  counterStyle: TextStyle(fontSize: 10),
                  labelText: 'Number',
                  hintText: 'Enter your phone number',
                  hintStyle: TextStyle(fontSize: 10, color: Colors.grey),
                ),
                onChanged: (value) {
                  setState(() {
                    counterText = value.length.toString();
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your phone number';
                  } else if (value.length != 10) {
                    return 'Phone number must be 10 digits';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Spacer(), // Move the button to the bottom of the screen
              ElevatedButton(
                onPressed: (counterText == '10')
                    ? () {
                        if (_formKey.currentState!.validate()) {
                          sendCode();
                        }
                      }
                    : null, // Disable button if phone number is not 10 digits
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 90),
                  child: Text(
                    'Received OTP',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
