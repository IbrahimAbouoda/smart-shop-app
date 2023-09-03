import 'package:flutter/material.dart';
import 'package:gaza_shop/core/utils/constant.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الاعدادات"),
      ),
      body: Column(children: [
        Card(
          shape: Border.all(),
          child: ListTile(
              leading: const Icon(Icons.translate),
              trailing: Text(
                "غير اللغة",
                style: ConstantStayles.style1,
              )),
        ),
        InkWell(
          onTap: () => Navigator.pushNamed(context, "/editProfile"),
          child: Card(
            shape: Border.all(),
            child: ListTile(
                leading: const Icon(Icons.edit),
                trailing: Text(
                  "معلومات الشخصية",
                  style: ConstantStayles.style1,
                )),
          ),
        ),
        InkWell(
          onTap: () => Navigator.pushNamed(context, "/editProfile"),
          child: Card(
            shape: Border.all(),
            child: ListTile(
                leading: const Icon(Icons.edit),
                trailing: Text(
                  " الوضع الليلي",
                  style: ConstantStayles.style1,
                )),
          ),
        ),
      ]),
    );
  }
}
