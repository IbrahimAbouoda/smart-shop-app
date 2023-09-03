import 'package:flutter/material.dart';
import '../../../../components/general_widgets.dart';
class Defin1 extends StatefulWidget {
  const Defin1({super.key});

  @override
  State<Defin1> createState() => _Defin1State();
}

class _Defin1State extends State<Defin1> {
  final List<String> imagePaths = [
    "assets/images/defin3.png",
    "assets/images/defin2.png",
    "assets/images/defin1.png"
  ];

  int currentIndex = 0;

  void onTap(BuildContext context) {
    currentIndex = (currentIndex + 1) % imagePaths.length;
    if (currentIndex == imagePaths.length - 1) {
      Navigator.pushNamed(context, "/login_signUp");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: double.infinity,
              height: 500,
              child: Image.asset(imagePaths[currentIndex]),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "احجز بضائعك بسهولة",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text("استعرض أهم الميزات"),
            const SizedBox(
              height: 20,
            ),
            if (currentIndex != imagePaths.length - 1)
              SizedBox(
                width: 150,
                child: CustomButton(
                  onPressed: () {
                    setState(() {
                      currentIndex = (currentIndex + 1) % imagePaths.length;
                      if (currentIndex == imagePaths.length - 1) {
                        Navigator.pushNamed(context, "/login_signUp");
                      }
                    });
                  }, // Disable the button
                  color: Colors.blue, text: 'متابعة',
                ),
              ),
          ],
        ),
      ),
    );
  }
}
