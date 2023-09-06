import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gaza_shop/providers/users_provider.dart';
import 'package:gaza_shop/views/users/cart_pay_user/payment/payment.dart';
import 'package:gaza_shop/views/users/cart_pay_user/payment/toggal_button.dart';
import 'package:provider/provider.dart';

import '../../../../../../components/widgets/general_widgets/app_bar1.dart';
import '../../../../../../components/widgets/general_widgets/buttonApp.dart';
import '../../../core/utils/constant.dart';
import 'card_widgets.dart';

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
    double totalPay = 0.0;
    return Consumer<UserProvider>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: const Text("سلة المشتريات"),
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
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text("No products in the cart."));
                  } else {
                    final cartDocs = snapshot.data!.docs;
                    totalPay =
                        0.0; // Reset totalPay to 0.0 before recalculating

                    final userProvider =
                        Provider.of<UserProvider>(context, listen: false);

                    if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                      final cartDocs = snapshot.data!.docs;
                      totalPay =
                          0.0; // Reset totalPay to 0.0 before recalculating

                      for (final doc in cartDocs) {
                        double price = doc['price']
                            as double; // Assuming 'price' is a double field in Firestore
                        totalPay += price; // Add the price to the totalPay
                      }

                      // Update the total in the UserProvider
                      userProvider.updateTotal(totalPay);

                      // Update the total in Firestore if needed
                      userProvider.updateTotalInFirestore();
                    }

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

                        double price = cartData['price']
                            as double; // Assuming 'price' is an integer field in Firestore
                        totalPay += 20; // Add the price to the totalPay

                        final userProvider =
                            Provider.of<UserProvider>(context, listen: false);
                        userProvider.updateTotal(totalPay);

                        // Update the total in Firestore
                        userProvider.updateTotalInFirestore();
                        // Now you can access cartData and display it in your widget
                        return CardPay(
                            cartData: cartData,
                            price: price,
                            backgroundColor: backgroundColor);
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
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ToggleScreen(),
                          )),
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
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 50,
                          margin: const EdgeInsets.all(8),
                          color: ConstantStayles.kPrimColor,
                          child: Consumer<UserProvider>(
                              builder: (context, userProvider, child) {
                            // Access the total from the provider
                            double total = userProvider.total;
                            return Text(
                              "اجمالي المبلغ $total",
                              style: ConstantStayles.styleLight,
                            );
                          }),
                        ),
                        GestureDetector(onTap: () async {
                      final userProvider =
                          Provider.of<UserProvider>(context, listen: false);
                      double total = userProvider.total;

                      // Add the total to Firestore
                      await addTotalToFirestore(total);
                    }, child: const Text("حجز")),
                      ],
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

Future<void> addTotalToFirestore(double total) async {
  final user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    final userId = user.uid;
    final userRef = FirebaseFirestore.instance.collection('Users').doc(userId);

    await userRef.update({
      'total': total,
    });
  }
}
