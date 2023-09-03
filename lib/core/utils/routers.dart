import 'package:flutter/cupertino.dart';
import '../../components/derwer_user.dart';
import '../../components/drewerAdmin.dart';
import '../../components/who_me.dart';
import '../../components/widgets/settings.dart';
import '../../views/General/change_pass_screen.dart';
import '../../views/General/defineing/presintation/define1_screen.dart';
import '../../views/General/forget_pass_screen.dart';
import '../../views/General/login/login_or_register.dart';
import '../../views/General/login/success.dart';
import '../../views/admin/add products/views/add_product_screen1.dart';
import '../../views/admin/add store/add_store_screen.dart';
import '../../views/admin/count bay/count_bay.dart';
import '../../views/admin/home/views/home_distrbute_screen.dart';
import '../../views/admin/notoficatios/notifictions.dart';
import '../../views/admin/profile/views/edit_profile.dart';
import '../../views/admin/profile/views/myProfile.dart';
import '../../views/admin/show users/list_show_user.dart';
import '../../views/admin/user requsts/view/requst_list.dart';
import '../../views/chats/list chating/presintation/views/chats.dart';
import '../../views/chats/messaging/presintation/views/messaging.dart';
import '../../views/users/home/views/homeUser.dart';
import '../../views/users/home/views/home_category.dart';
import '../../views/users/show admins/show_admins.dart';
import '../../views/users/show all products/car_pay_product.dart';
import '../../views/users/show all products/details_product.dart';

Map<String, Widget Function(BuildContext)> routes = {
  "/": (context) => const HomeCategory(),
  "/homeAdmin": (context) => const HomeAdmin(),
  "/AddStore": (context) => const AddStore(),
  "/AddProduct1": (context) => const AddProduct(),
  "/profile": (context) => Profile(),
  "/editProfile": (context) => EditProfile(),
  // "/myProfile": (context) => const MyProfil(),
  "/notofications": (context) => const NotifictionsApp(),
  "/chats": (context) => const Chats(),
  "/messageing": (context) => const ChatScreen(),
  "/menuAdmin": (context) => DrwerAdmin(),
  "/requstUser": (context) => const ListRequst(),
  "/showUser": (context) => ShowUsers(),
  "/counterBay": (context) => const CounterBay(),
  "/success": (context) => const SuccessLogin(),
  //-----------------------------------------
  "/login_signUp": (context) => const LoginAdminScreen(),
  "/homeUser": (context) => const HomeUser(),
  "/homeCategory": (context) => const HomeCategory(),
  "/showAdmin": (context) => ShowAdmins(),
  "/menuUser": (context) => DrewerUser(),
  "/details_product": (context) => const DetailsProduct(),
  "/carPay": (context) => const CarPayProduct(),
//-
  "/define": (context) => const Defin1(),
  "/changePass": (context) => const ChangePass(),
  "/forget": (context) => const Forget(),
  "/whome": (context) => const WhoME(),
  "/settings": (context) => const Settings(),

};
