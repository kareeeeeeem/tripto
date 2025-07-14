import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:tripto/core/constants/CustomButton.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.14 // تقريبًا تعادل 110 على شاشة ارتفاعها ~800
          ),
          child: Column(
            children: [
              Text("Join us via phone number" ,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Duplet",
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Text("We will text a code to verify your phone" ,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Duplet",
                  color: Color(0xFF989898),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.08),
              Padding(
                padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04), // حوالي 4% من العرض
                child: IntlPhoneField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  initialCountryCode: 'SA',
                ),
              ),
              Padding(
                padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.025),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.878,
                  height: MediaQuery.of(context).size.height * 0.05875,

                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF002E70),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),

                    ),
                    onPressed: () {},
                    child: Text("Next" , style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Sakkal Majalla",
                      color: Colors.white,
                    )),
                  ),
                ),
              ),
            ]
          ),
        ),

      ),

    );
  }
}
