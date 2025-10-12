import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tripto/bloc&repo/ContactUs/ContactIs_state.dart';
import 'package:tripto/bloc&repo/ContactUs/ContactUs_Event.dart';
import 'package:tripto/bloc&repo/ContactUs/ContactUs_bloc.dart';
import 'package:tripto/core/models/ContactUs_Model.dart';
import 'package:tripto/l10n/app_localizations.dart';
import 'package:tripto/presentation/pages/NavBar/SideMenu/Contact-Us.dart';
import 'package:tripto/presentation/pages/NavBar/SideMenu/SideMenu.dart';

class Report extends StatefulWidget {
  const Report({super.key});

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  final TextEditingController reportController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocListener<ContactusBloc, ContactUsState>(
      listener: (context, state) {
        //... your existing listener
        if (state is ContactLoading) {
          setState(() => isLoading = true);
        } else {
          setState(() {
            isLoading = false;
          });

          if (state is ContactSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const SideMenu()),
            );
          } else if (state is ContactFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Error: ${state.error}"),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          // elevation: 0,
          // scrolledUnderElevation: 0,
          scrolledUnderElevation: 0,

          centerTitle: true,
          title: Text(
            AppLocalizations.of(context)!.report,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const SideMenu()),
                (route) => false,
              );
            },
            icon: Icon(
              Localizations.localeOf(context).languageCode == 'ar'
                  ? Icons
                      .keyboard_arrow_right_outlined // في العربي: سهم لليمين
                  : Icons
                      .keyboard_arrow_left_outlined, // في الإنجليزي: سهم لليسار
              size: 35,
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // الصورة فوق
                ClipRRect(
                  child: Image.asset(
                    "assets/images/issue.png",
                    width: screenWidth * 0.9, // 80% من عرض الشاشة
                    height: screenHeight * 0.20, // 25% من طول الشاشة
                    fit: BoxFit.fitHeight, // يملأ المساحة مع الحفاظ على النسب
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                // Row(
                //   children: [
                //     Icon(Icons.report, color: const Color(0xFF002E70), size: 12),
                //     SizedBox(width: MediaQuery.of(context).size.width * 0.02),

                //     buildLabel(AppLocalizations.of(context)!.report),
                //   ],
                // ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.878,
                  child: TextFormField(
                    controller: reportController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 100, // هنا حددت 6 أسطر
                    minLines: 6, // أقل حاجة 3 أسطر
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.issue,
                      hintStyle: GoogleFonts.markaziText(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black45,
                      ),
                      // labelText: AppLocalizations.of(context)!.report,
                      // labelStyle: TextStyle(color: Color(0xFF002E70)),
                      // fillColor: const Color(0xFFD9D9D9).withOpacity(0.2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Colors.black45,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Color(0xFF002E70),
                          width: 2,
                        ),
                      ),
                      // prefixIcon: Icon(Icons.message),
                    ),
                  ),
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.10),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.878,
                  height: MediaQuery.of(context).size.height * 0.05875,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF002E70),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      final model = ContactusModel(
                        name: "k", // هيتم تجاهلهم في حالة الـ report
                        email: "k",
                        phone: "k",
                        messagebody: reportController.text,
                        subject: "Report",
                      );

                      // خلي بالك هنا لازم تكون نفس اسم الباراميتر في الـ Event
                      context.read<ContactusBloc>().add(
                        SubmitContactUs(
                          contactusModel: model,
                          pagetype: "report", // صح مش pagetype
                        ),
                      );
                    },
                    child: Text(
                      AppLocalizations.of(context)!.sendreport,
                      style: GoogleFonts.markaziText(
                        fontSize: 23,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.04),

                // //////////////////////////////////////////////////////////////////////////////////////
                Padding(
                  padding: EdgeInsets.all(
                    MediaQuery.of(context).size.width *
                        0.2, // 10% من عرض الشاشة
                  ),
                  child: Container(
                    width: 400,
                    height: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/Logo.png"),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLabel(String text) => Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 6),
      child: Text(
        text,
        style: GoogleFonts.markaziText(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.left,
      ),
    ),
  );
}
