
import 'package:flutter/material.dart';

import '../../../../../../core/utils/constant.dart';

class DataDetailsText extends StatelessWidget {
  const DataDetailsText({
    super.key,
    required this.productDetails,
  });

  final String productDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,

      alignment: Alignment.bottomRight,
      child:  Text(
        "${productDetails}, ",style: ConstantStayles.styleDark,
        textAlign: TextAlign.right,
      ),
    );
  }
}
