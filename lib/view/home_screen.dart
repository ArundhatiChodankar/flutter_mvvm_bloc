import 'package:flutter/material.dart';
import 'package:flutter_mvvm_bloc/services/session_manager/session_controller.dart';
import 'package:flutter_mvvm_bloc/utils/routes/routes_name.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: ()async{
           await SessionController().removeUserFromPreference();
           Navigator.pushNamedAndRemoveUntil(context, RouteNames.login, (route) => false);

    }, icon: Icon(Icons.logout))]

      ),
      body: Container(),
    );
  }


}


