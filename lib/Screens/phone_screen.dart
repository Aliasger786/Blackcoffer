import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../Global/global.dart';
import '../Helpers/firebase.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class Phone extends StatefulWidget {
  const Phone({Key? key}) : super(key: key);

  @override
  State<Phone> createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  TextEditingController countryController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  var completePhoneNumber = "";

  @override
  void initState() {
    // TODO: implement initState
    countryController.text = "+91";
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    countryController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Global.bgColor,
      body: Container(
        margin: const EdgeInsets.only(left: 23, right: 23),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Lottie.network('https://firebasestorage.googleapis.com/v0/b/blackcoffer-6a4bd.appspot.com/o/lotties%2F88963-send-sms%20(1).json?alt=media&token=76c86aae-b7cd-41ac-862e-4d3960f69145'),
                height: 170,
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Verify Phone Number",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "We need to register your phone without getting started!",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              IntlPhoneField(
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                onChanged: (phone) {
                  setState(() {
                    completePhoneNumber = phone.completeNumber;
                  });
                },
                onCountryChanged: (country) {
                  print('Country changed to: ' + country.name);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        //backgroundColor: GlobalTraits.bgGlobalColorDark,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      FireHelp().fireLoginWithPhone(
                        number:
                        completePhoneNumber,
                        context: context,
                      );
                    },
                    child: const Text("Send code")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
