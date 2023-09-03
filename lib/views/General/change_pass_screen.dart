import 'package:flutter/material.dart';

class ChangePass extends StatefulWidget {
  const ChangePass({Key? key}) : super(key: key);

  @override
  State<ChangePass> createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  @override
  Widget build(BuildContext context) {
    TextEditingController pass = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
                flex: 1, child: Image.asset("assets/images/changepass.png")),
            Expanded(
                flex: 1,
                child: Column(
                  children: [
                    TextFormField(
                      controller: pass,
                      decoration: const InputDecoration(
                        prefix: Icon(Icons.email_outlined, size: 20),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white10)),
                        hintText: "البريد الاكتروني",
                      ),
                    ),
                    TextFormField(
                      controller: pass,
                      decoration: const InputDecoration(
                        prefix: Icon(Icons.email_outlined, size: 20),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white10)),
                        hintText: "كلمة المرور",
                      ),
                    ),
                    TextFormField(
                      controller: pass,
                      decoration: const InputDecoration(
                        prefix: Icon(Icons.email_outlined, size: 20),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white10)),
                        hintText: "تاكيد كلمة المرور ",
                      ),
                    ),
                    const SizedBox(height: 100),
                    SizedBox(
                      width: 150,
                      child: TextButton(
                        onPressed: () {
                          setState(() {});
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue)),
                        child: const Text(
                          "انهاء",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
