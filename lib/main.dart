import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'screens/authentication/login.dart';
import 'utilities/app_state.dart';

void main() {
  // runApp(const MaterialApp(
  //   home: Login(),
  // ));
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: const MaterialApp(
        title: "Login",
        home: Login(),
      ),
    );
  }
}
