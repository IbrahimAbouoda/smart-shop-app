import 'package:flutter/material.dart';

import '../../../../core/utils/constant.dart';

class CardDetails extends StatelessWidget {
  const CardDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      height: 70,
      color: ConstantStayles.kPrimColor,
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "اجمالي المبلغ / 543",
                      style: TextStyle(color: Colors.white),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white)),
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 40,
                          ),
                          const Column(
                            children: [
                              Text("المتبقي",
                                  style: TextStyle(color: Colors.white)),
                              Text("500", style: TextStyle(color: Colors.white))
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            height: 40,
                            width: 2,
                            color: Colors.white,
                          ),
                          const Column(
                            children: [
                              Text("المدفوع",
                                  style: TextStyle(color: Colors.white)),
                              Text("200", style: TextStyle(color: Colors.white))
                            ],
                          ),
                        ],
                      ),
                    )
                  ]),
            ),
          ),
          const SizedBox(
            width: 4,
          ),
          const Expanded(
            child: LinearProgressIndicator(
              color: Colors.blue,
              value: 0.5,
            ),
          )
        ],
      ),
    );
  }
}
