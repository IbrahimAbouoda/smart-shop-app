import 'package:flutter/material.dart';

import 'auth_text_f.dart';

class AnimatedCrossFadeBox extends StatelessWidget {
  const AnimatedCrossFadeBox({
    super.key,
    required TextEditingController nameController,
    required this.switched,
    required this.hint,
    required this.swith,
  }) : _nameController = nameController;

  final TextEditingController _nameController;
  final String switched;
  final String hint;
  final String swith;

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 400),
      reverseDuration: const Duration(milliseconds: 200),
      firstChild: Container(),
      secondChild: Column(
        children: [
          AuthTextField(
              hint: hint,
              controller: _nameController,
              keyboardType:
                  hint == "Name" ? null : TextInputType.visiblePassword),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
      crossFadeState: switched == swith
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
    );
  }
}
