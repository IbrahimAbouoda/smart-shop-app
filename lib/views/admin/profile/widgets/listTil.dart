import 'package:flutter/material.dart';

class ListTileProfiles extends StatelessWidget {
  const ListTileProfiles({
    super.key,
    required this.titel,
    required this.iconData,
    required this.onTap,
  });
  final String titel;
  final IconData iconData;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        leading: Icon(iconData),
        title: Text(titel),
      ),
    );
  }
}
