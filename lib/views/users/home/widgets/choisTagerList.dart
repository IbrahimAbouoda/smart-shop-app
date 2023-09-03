import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';

import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/constant.dart';
import '../../../../models/stores_model.dart';
import '../../../../service/backend/store_servic.dart';

class ChoisListTager extends StatelessWidget {
  String removeHtmlTags(String htmlString) {
    final unescape = HtmlUnescape();
    String noHtml = unescape.convert(htmlString); // Decode HTML entities
    return noHtml.replaceAll(RegExp(r'<[^>]*>'), ''); // Remove HTML tags
  }

  final Function()? onTap;
  const ChoisListTager({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    List nameCategoris = ["أطفالي", "حريمي", "رجالي"];
    List imageCategoris = [Assets.children, Assets.harim, Assets.manCategor];
    final StoreService storeService = StoreService();
    final Future<List<StoreModel>> storis = storeService.getStores();
    return SizedBox(
      height: 170,
      width: double.infinity,
      child: Column(
        children: [
          Container(
            alignment: Alignment.topRight,
            height: 30,
            child: const Expanded(
              flex: 1,
              child: Text(
                "اختر القسم",
                style: TextStyle(fontSize: 25),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: FutureBuilder<List<StoreModel>>(
              future: storis,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: imageCategoris.length,
                    itemBuilder: (context, index) {
                      StoreModel store = snapshot.data![index];
                      String note = removeHtmlTags(store.notes);
                      return CardChoisNameTager(
                        name: nameCategoris[index],
                        image: imageCategoris[index],
                        onTap: () =>
                            Navigator.pushNamed(context, "/homeCategory"),
                      );
                    },
                  );
                } else {
                  return const Center(child: Text("No data available"));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CardChoisNameTager extends StatelessWidget {
  const CardChoisNameTager({
    super.key,
    required this.onTap,
    required this.name,
    required this.image,
  });

  final Function()? onTap;

  final String name;

  final String image;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              Image.asset(
                image,
                width: 100,
                height: 80,
              ),
              Text(
                name,
                style: ConstantStayles.style1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
