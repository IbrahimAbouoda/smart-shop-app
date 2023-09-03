import 'package:flutter/material.dart';
import '../../../components/general_widgets.dart';
import '../../../core/utils/constant.dart';
import '../../../core/utils/general_style.dart';
import '../../../models/stores_model.dart';
import '../../../service/backend/store_servic.dart';
import '../add products/widgets/box_list_image.dart';
import '../add products/widgets/text_fiald.dart';


class AddStore extends StatefulWidget {
  const AddStore({super.key});

  @override
  State<AddStore> createState() => _AddStoreState();
}

class _AddStoreState extends State<AddStore> {

  TextEditingController?nameController;
  TextEditingController? decController;
  StoreService storeService = StoreService();
 @override
  void dispose() {
  nameController;
  decController;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

   // ignore: unused_element
   addStore(int id,String name,String notes,String status,String image)async{
     StoreModel newStore = StoreModel(
       id: id, // You might not need to specify the ID for a new store
       name:"ahmed",
       slug: "new-store",
       notes: "notes ahmed",
       status: "active",
       imageUrl: "image",
     );

     try {
       await storeService.postStore(newStore, "6|08V870V75qk98QDUEnxxu8JxbI4HgdqIug56dxSp");
     } catch (e) {
       print('Error posting store: $e');
     }
   }

    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(top: 40, bottom: 20, right: 10, left: 40),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "مرحبا بك في متجر غزة",
                style: GeneralStyle.tiltelStyle,
              ),
              const SizedBox(
                height: 7,
              ),
              Text(
                "قم بإنشاء متجرك الان",
                style: GeneralStyle.tiltelStyle,
              ),
              const SizedBox(
                height: 7,
              ),
              const BoxImageCont(hightBox: 150, widthBox: 150, radis: 30),
              const SizedBox(
                height: 15,
              ),
               TextFormProduct(maxline: 2, label: "اسم المتجر", width: 300, controller: nameController,),
              const SizedBox(
                height: 15,
              ),
               TextFormProduct(maxline: 8, label: "الوصف", width: 300,controller:decController ,),
              const SizedBox(
                height: 15,
              ),
              CustomButton(
                text: "دخول",
                onPressed: () {

                  Navigator.pushNamed(context, "/homeAdmin");
                },
                color: ConstantStayles.kPrimColor,
              )
            ],
          ),
        ),
      ),
    );
  }


}
