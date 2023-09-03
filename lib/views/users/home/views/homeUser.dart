import 'package:flutter/material.dart';
import '../../../../../components/widgets/general_widgets/buttonApp.dart';
import '../../../../components/general_widgets_user.dart/app_bar_user.dart';
import '../widgets/categoris_list.dart';
import '../widgets/choisTagerList.dart';
import '../widgets/new_products.dart';

class HomeUser extends StatelessWidget {
  static const String id = "/homeUser";
  const HomeUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBarUserPages(
          onPressed: () => Navigator.pushNamed(context, "/menuUser"),
        ),
      ),
      body: Column(
        children: [
          ChoisListTager(onTap: () {
            Navigator.pushNamed(context, "/homeCategory");
          }),
          Expanded(
            child: ListView(
              children: const [
                NewListCategoris(title: "أضيفت حديثا"),
                SizedBox(height: 10),
                NewListCategoris(title: "مهتم بها"),
              ],
            ),
          ),
          ButtonAppBar1(
            onTapHome: () => Navigator.pushNamed(context, "/homeUser"),
          ),
        ],
      ),
    );
  }
}
