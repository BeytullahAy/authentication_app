// ignore_for_file: prefer_const_constructors
import 'package:authentication_app/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:authentication_app/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class signInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                // appbardaki logout botununa tıklayınca hesaptan çıkartıyor ki
                // bir daha anonim giriş yaparsak başka id versin.
                await Provider.of<Auth>(context, listen: false).signOut();
                print("logout tıklandı");
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Sing In Page",
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(
              height: 30,
            ),
            myButton(
              color: Colors.orangeAccent,
              child: Text("Sing In  Anonymously"),
              onPressed: () async {
                // anonim şekilde kullanıcıya user id veriyor.
                final user = await Provider.of<Auth>(context, listen: false)
                    .signInAnonymously();
                print(user.uid);
              },
            ),
            SizedBox(height: 10),
            myButton(
              color: Colors.yellow,
              child: Text("Sing In  Email/password"),
              onPressed: () {},
            ),
            SizedBox(height: 10),
            myButton(
              color: Colors.lightBlueAccent,
              child: Text("Google Sign İn"),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
