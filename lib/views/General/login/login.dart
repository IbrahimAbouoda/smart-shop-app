// import 'package:fproject/core/utils/app_images.dart';
// import 'package:fproject/core/utils/constant.dart';
// import 'package:go_router/go_router.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class LoginScreen extends StatefulWidget {
//   static const id = "/login";
//   const LoginScreen({super.key});

//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   String? email;
//   String? passwrod;
//   bool showSpinner = false;
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   var dialog = Dialog(
//       child: Container(
//           margin: const EdgeInsets.all(8.0),
//           child: Form(
//               child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
//             TextFormField(
//                 decoration: const InputDecoration(
//                     labelText: "Insira o número de telefone",
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(2.0)))))
//           ]))));

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: showSpinner
//           ? const Center(
//               child: CircularProgressIndicator(
//               color: ConstantStayles.kPrimColor,
//             ))
//           : Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 24.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: <Widget>[
//                   SizedBox(
//                     height: 200.0,
//                     child: Image.asset(Assets.imagesLogo),
//                   ),
//                   const SizedBox(
//                     height: 48.0,
//                   ),
//                   TextField(
//                     onChanged: (value) {
//                       email = value;
//                       //Do something with the user input.
//                     },
//                     decoration: const InputDecoration(
//                       hintText: 'Enter your email',
//                       contentPadding: EdgeInsets.symmetric(
//                           vertical: 10.0, horizontal: 20.0),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(32.0)),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                             color: ConstantStayles.kPrimColor, width: 1.0),
//                         borderRadius: BorderRadius.all(Radius.circular(32.0)),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                             color: ConstantStayles.kPrimColor, width: 2.0),
//                         borderRadius: BorderRadius.all(Radius.circular(32.0)),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 8.0,
//                   ),
//                   TextField(
//                     onChanged: (value) {
//                       passwrod = value;
//                       //Do something with the user input.
//                     },
//                     decoration: const InputDecoration(
//                       hintText: 'Enter your password.',
//                       contentPadding: EdgeInsets.symmetric(
//                           vertical: 10.0, horizontal: 20.0),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(32.0)),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                             color: ConstantStayles.kPrimColor, width: 1.0),
//                         borderRadius: BorderRadius.all(Radius.circular(32.0)),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                             color: ConstantStayles.kPrimColor, width: 2.0),
//                         borderRadius: BorderRadius.all(Radius.circular(32.0)),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 24.0,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 16.0),
//                     child: Material(
//                       color: ConstantStayles.kPrimColor,
//                       borderRadius:
//                           const BorderRadius.all(Radius.circular(30.0)),
//                       elevation: 5.0,
//                       child: MaterialButton(
//                         onPressed: () async {
//                           if (email != null && passwrod != null && mounted) {
//                             try {
//                               final newUser =
//                                   await _auth.signInWithEmailAndPassword(
//                                       email: email!, password: passwrod!);
//                               // ignore: unnecessary_null_comparison
//                               if (newUser != null) {
//                                 // ignore: use_build_context_synchronously

//                                 // ignore: use_build_context_synchronously
//                                 context.go("/AddStore");
//                                 // ignore: use_build_context_synchronously
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                     SnackBar(
//                                         content: Text(
//                                             "login user ${newUser.user!.email}")));
//                               } else {
//                                 // ignore: use_build_context_synchronously

//                                 ScaffoldMessenger(
//                                     child: Text(newUser.credential.toString()));
//                               }
//                             } catch (e) {
//                               ScaffoldMessenger(child: Text(e.toString()));
//                             }
//                           } else {
//                             print('email or password null');

//                             //Implement registration functionality.
//                           }
//                           //Implement login functionality.
//                         },
//                         minWidth: 200.0,
//                         height: 42.0,
//                         child: const Text(
//                           'Log In',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }
// }
