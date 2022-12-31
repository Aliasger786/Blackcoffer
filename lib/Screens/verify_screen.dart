import 'package:blackcoffer1/Helpers/firebase.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:lottie/lottie.dart';
import '../Global/global.dart';

class Otp extends StatefulWidget {
  const Otp({Key? key}) : super(key: key);

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  String pinCode = '';
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as List<String>;

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
                "Verify OTP",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Verify OTP to get started!",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              Pinput(
                length: 6,
                showCursor: true,
                onChanged: (value) {
                  pinCode = value;
                },
                onCompleted: (value) {
                  pinCode = value;
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
                      final uid = FireHelp()
                          .fireReceiveCodeAndLogin(args[0], pinCode)
                          .then((value) => Navigator.pushNamedAndRemoveUntil(
                                context,
                                'home',
                                (route) => false,
                                arguments: [value],
                              ))
                          .catchError((e) {
                        return e.toString();
                      });
                    },
                    child: const Text("Verify")),
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        FireHelp().fireLoginWithPhone(
                          number:
                          args[1],
                          context: context,
                        );
                      },
                      child: const Text(
                        "Did'nt receive code ? resend code",
                        style: TextStyle(color: Colors.black),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
