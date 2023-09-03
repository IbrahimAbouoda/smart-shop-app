import 'package:flutter/material.dart';

import '../../../core/utils/app_images.dart';



class SuccessLogin extends StatelessWidget {
  const SuccessLogin({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 2),
      () {
          Navigator.pushNamed(context, "/AddStore");
      },
    );
    return Scaffold(
      backgroundColor: const Color(0xff526D82),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          width: 300,
          height: 300,
          decoration: BoxDecoration(
              color: const Color(0xffDDE6ED),
              borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              Container(
                  width: double.infinity,
                  alignment: Alignment.centerRight,
                  child: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.close))),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(Assets.success),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text("Congratulations!"),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("You have successfully login"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
