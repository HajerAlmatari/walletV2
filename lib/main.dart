import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:walletapp/screens/fingerprint.dart';
import 'package:walletapp/services/firebase_auth_methods.dart';
import 'package:walletapp/services/google_sign_in.dart';
import 'package:walletapp/screens/api.dart';
import 'package:walletapp/screens/nav_screen.dart';
import 'welcome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthMethods>(
          create: (_) => FirebaseAuthMethods(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<FirebaseAuthMethods>().authState,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'WalletApp',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),

        home: ShowCaseWidget(
          builder: Builder(
            builder: (context) => const AuthWrapper(),
          ),
        ),
        builder: EasyLoading.init(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null && firebaseUser.emailVerified) {
      return const NavScreen();
    }
    return WelcomePage();
  }
}
