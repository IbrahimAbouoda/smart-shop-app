import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../models/product_model.dart';
import '../service/backend/product_service.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> _products = [];
  int countQuntiy=0;

  void decCount(){
    countQuntiy--;
    notifyListeners();
  }
  void incCount(){
    countQuntiy++;
    notifyListeners();
  }
  List<ProductModel> get products => _products;
  //send data to api
  // void _submitProduct() {
  //   final newProduct = ProductModel(
  //     id: -1,
  //     // Use a temporary ID here, or modify the API to assign IDs
  //     storeId: 0,
  //     categoryId: 0,
  //     name: nameController!.text,
  //     price: double.parse(priceController!.text),
  //     quantity: int.parse(quantityController!.text),
  //     status: 'active',
  //     imageUrl: '',
  //   );
  // }
  String removeHtmlTags(String htmlString) {
    final unescape = HtmlUnescape();
    String noHtml = unescape.convert(htmlString); // Decode HTML entities
    return noHtml.replaceAll(RegExp(r'<[^>]*>'), '');}
  Future<void> fetchAndSetProducts() async {
    try {
      final products = ProductService();
      _products = products as List<ProductModel>;
      notifyListeners();
    } catch (error) {
      // Handle error
      print(error);
    }
  }

  void addToCart(BuildContext context, String name, String image, int quantity, double price, String color) async {
    if(quantity > 0){
      final CollectionReference cartCollection = FirebaseFirestore.instance.collection('Carts');

      // Check if the data already exists in Firestore
      final QuerySnapshot existingData = await cartCollection
          .where('name', isEqualTo: name)
          .where('color', isEqualTo: color)
          .where('quantity', isEqualTo: quantity)
          .where('price', isEqualTo: price)
          .get();

      if (existingData.docs.isNotEmpty) {
        // Data already exists, show a SnackBar
        onAlertWithStylePressed(context, "انتبه", "طلبك لهذه الكمية موجود مسبقا", "رجوع");
      } else {
        // Data doesn't exist, add the product data to Firestore
        final Map<String, dynamic> productData = {
          'name': name,
          'image': image,
          'quantity': quantity,
          'price': price,
          'color': color,
        };

        cartCollection.add(productData).then((value) {
          // Product added successfully
          // You can also show a confirmation message to the user if needed.
          // You may want to handle errors and edge cases as well.
        }).catchError((error) {
          // Handle errors if the product couldn't be added to the cart.
          // You can display an error message to the user.
          print("Error adding product to cart: $error");
        });
      }
      notifyListeners();
    }else{
onAlertWithStylePressed(context, "انتبه ", "لم تضف الكمية بعد !", "رجوع");
    }

  }
  onAlertWithStylePressed(context,String title,String dec,String btnText) {
    // Reusable alert style
    var alertStyle = AlertStyle(
        animationType: AnimationType.fromTop,
        isCloseButton: false,
        isOverlayTapDismiss: false,
        descStyle: TextStyle(fontWeight: FontWeight.bold),
        animationDuration: Duration(milliseconds: 200),
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
          side: BorderSide(
            color: Colors.grey,
          ),
        ),
        titleStyle: TextStyle(
          color: Colors.red,
        ),
        constraints: BoxConstraints.expand(width: 300),
        //First to chars "55" represents transparency of color
        overlayColor: Color(0x55000000),
        alertElevation: 0,
        alertAlignment: Alignment.topCenter);

    // Alert dialog using custom alert style
    Alert(
      context: context,
      style: alertStyle,
      type: AlertType.info,
      title: title,
      desc: dec,
      buttons: [
        DialogButton(
          child: Text(
            btnText,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color.fromRGBO(0, 179, 134, 1.0),
          radius: BorderRadius.circular(0.0),
        ),
      ],
    ).show();
  }

}
