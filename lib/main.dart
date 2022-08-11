import 'package:ecommerce/app/auth_widget.dart';
import 'package:ecommerce/app/pages/admin/admin_home.dart';
import 'package:ecommerce/app/pages/auth/sign_in_page.dart';
import 'package:ecommerce/app/providers.dart';
import 'package:ecommerce/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple,primary: Colors.purple),
        ),
        home: AuthWidget(
            nonSignedInBuilder: (_) => const SignInPage(),
            signedInBuilder: (context) =>  Scaffold(
                  body: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("Signed In"),
                        const SizedBox(height: 25,),
                        ElevatedButton(onPressed: (){
                          ref.read(firebaseAuthProvider).signOut();
                        }, child: const Text("Sign out"))
                      ],
                    ),
                  ),
                ), adminSignedInBuilder: (BuildContext context) { 
                  return const AdminHome();
                 },));
  }
}
