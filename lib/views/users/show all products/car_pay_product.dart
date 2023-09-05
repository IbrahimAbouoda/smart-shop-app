import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gaza_shop/providers/users_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../../components/widgets/general_widgets/app_bar1.dart';
import '../../../../../../components/widgets/general_widgets/buttonApp.dart';
import '../../../core/utils/constant.dart';

class CarPayProduct extends StatefulWidget {
  const CarPayProduct({Key? key}) : super(key: key);

  @override
  _CarPayProductState createState() => _CarPayProductState();
}

class _CarPayProductState extends State<CarPayProduct> {
  late Stream<QuerySnapshot> cartStream;

  @override
  void initState() {
    super.initState();
    // Initialize the stream to listen for changes in the "Carts" collection
    cartStream = FirebaseFirestore.instance.collection('Carts').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    double totalPay = Provider.of<UserProvider>(context,).total;
    return Consumer<UserProvider>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text("سلة المشتريات"),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
              flex: 8,
              child: StreamBuilder<QuerySnapshot>(
                stream: cartStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (!snapshot.hasData ||
                      snapshot.data!.docs.isEmpty) {
                    return Center(child: Text("No products in the cart."));
                  } else {
                    final cartDocs = snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: cartDocs.length,
                      itemBuilder: (context, index) {
                        Map<String, Color> colorMap = {
                          'orange': Colors.orange,
                          'purpleAccent': Colors.purpleAccent,
                          'limeAccent': Colors.limeAccent,
                          'blueAccent': Colors.blueAccent,
                          'black': Colors.black,
                          // Add more color mappings as needed
                        };

                        final cartData =
                        cartDocs[index].data() as Map<String, dynamic>;
                        String colorName = cartData['color'];
                        Color backgroundColor =
                            colorMap[colorName] ?? Colors.black;

                          double price = cartData['price'] as double; // Assuming 'price' is an integer field in Firestore
                          totalPay += 20; // Add the price to the totalPay


                        // Now you can access cartData and display it in your widget
                        return Container(
                          margin: EdgeInsets.all(15),
                          height: 100,
                          decoration: BoxDecoration(
                            color: Color(0xff9ca9c7),
                            borderRadius: BorderRadius.circular(5),
                            border:
                            Border.all(color: ConstantStayles.kPrimColor),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text("قطعة: ${cartData['quantity']}"),
                                  Text("\$${price}"),
                                ],
                              ),
                              Column(
                                children: [
                                  // Image.network(cartData['image']),
                                  Text(
                                    cartData['name'],
                                    style: ConstantStayles.styleDark,
                                  ),
                                  Image.network(
                                    cartData['image'],
                                    height: 50,
                                    width: 50,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      // Handle delete action here
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      size: 30,
                                    ),
                                  ),
                                  CircleAvatar(
                                    radius: 15,
                                    backgroundColor: backgroundColor,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      margin: const EdgeInsets.all(8),
                      color: ConstantStayles.kPrimColor,
                      child: Text(
                        "شراء الان",
                        style: ConstantStayles.styleLight,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      margin: const EdgeInsets.all(8),
                      color: ConstantStayles.kPrimColor,
                      child: Text(
                        "اجمالي المبلغ $totalPay",
                        style: ConstantStayles.styleLight,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: ButtonAppBar1(
                onTapHome: () => Navigator.pushNamed(context, "/homeUser"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
