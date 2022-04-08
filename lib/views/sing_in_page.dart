// ignore_for_file: prefer_const_constructors
import 'package:authentication_app/services/auth.dart';
import 'package:authentication_app/views/email_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:authentication_app/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class signInPage extends StatefulWidget {
  @override
  State<signInPage> createState() => _signInPageState();
}

class _signInPageState extends State<signInPage> {
  // butonlara tıkladığında diğer sayfaya gidene kadar
  // birden fazla kez basılıp id alabilme hatasını çözmek için
  // false iken butonlar aktif
  bool _isLoading = false;

  // anonim butonuna tıklandığında olacak işlemler
  // aşağıda kalabalık yapmasın diye ayrı tuttuk
  Future<void> _signInAnonymously() async {
    setState(() {
      // butona tıklandığında true ya çevir ve kitle
      _isLoading = true;
    });

    // anonim şekilde kullanıcıya user id veriyor.
    final user =
        await Provider.of<Auth>(context, listen: false).signInAnonymously();
    setState(() {
      _isLoading = false;
    });

    print(user.uid);
  }

// google ile direkt giriş kısmı
  Future<void> _signInWithGoogle() async {
    setState(() {
      // butona tıklandığında true ya çevir ve kitle
      _isLoading = true;
    });

    final user =
        await Provider.of<Auth>(context, listen: false).signInWithGoogle();
    setState(() {
      // signInWithGoogle dinliyor gelmezse false olmuyor.
      _isLoading = false;
    });

    print(user.uid);
  }

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
              onPressed: _isLoading ? null : _signInAnonymously,
            ),
            SizedBox(height: 10),
            myButton(
              color: Colors.yellow,
              child: Text("Sing In  Email/password"),
              onPressed: _isLoading
                  ? null
                  : () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => emailSingInPage())));
                    },
            ),
            SizedBox(height: 10),
            myButton(
              color: Colors.lightBlueAccent,
              child: Text("Google Sign İn"),
              onPressed: _isLoading ? null : _signInWithGoogle,
            ),
          ],
        ),
      ),
    );
  }
}
