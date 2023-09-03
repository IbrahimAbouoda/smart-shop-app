import 'package:flutter/material.dart';

class Forget extends StatefulWidget {
  const Forget({Key? key}) : super(key: key);

  @override
  State<Forget> createState() => _ForgetState();
}

class _ForgetState extends State<Forget> {
  @override
  Widget build(BuildContext context) {
    var pass = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Expanded(
          child: Column(
            children: [
              Expanded(flex: 1, child: Image.asset("assets/images/login.png")),
              Expanded(
                  flex: 1,
                  child: Expanded(
                    child: Column(
                      children: [
                        const Text(
                          "نسيان كلمة المرور",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                            "لاتقلق ! يحدث ذلكز الرجاء إدخال البريد الاكتروني لفحصه والتاكد منه"),
                        const SizedBox(
                          height: 10,
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
                              "ارسال",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
