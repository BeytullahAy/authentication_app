// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart'; // e mail kontrolü için kütüphane

//Bu değişken sayesinde ya kayıt olma ekranına ya da giriş yapma ekranına geçecek.
// sınıf içinde  tanımlanmaz
enum FormStatus { signIn, register, reset }

class emailSingInPage extends StatefulWidget {
  @override
  State<emailSingInPage> createState() => _emailSingInPageState();
}

class _emailSingInPageState extends State<emailSingInPage> {
  // yukarıda tanımladığımız enum yapısından çekiyoruz.
  FormStatus _formStatus = FormStatus.signIn;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          // hangisi seçiliyse o sayfaya aç
          child: _formStatus == FormStatus.signIn
              ? buildSingInForm()
              : buildRegisterInForm(),
        ),
      ),
    );
  }

// Giriş yapma formu
  Widget buildSingInForm() {
    // kullanıcı girdileri doğru mu bizim istediğimiz gibi kontrol amaçlı
    // bir key oluşturduk. Bu kod sabit bir kod  GlobalKey<FormState>() kısmı
    final _signInFormKey = GlobalKey<FormState>();

    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _signInFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Lüften Giriş Yapınız",
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              validator: (val) {
                // Email paketindeki gibi email değilse hata vericek
                if (!EmailValidator.validate(val)) {
                  return 'Lütfen Geçerli Bir Adres Giriniz';
                } else {
                  return null;
                }
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: "E-mail",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0))),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
                validator: (valu) {
                  // @ işareti içermiyorsa hata vericek
                  if (valu.length < 6) {
                    return 'Lütfen Daha Uzun Bir Şifre Giriniz (Minimum:6)';
                  } else {
                    return null;
                  }
                },
                obscureText: true,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    hintText: "Şifre",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)))),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  // gelen mesajı telefon ekranına yazdırıyor
                  print(_signInFormKey.currentState.validate());
                },
                child: Text("Giriş")),
            SizedBox(
              height: 10,
            ),
            TextButton(
                onPressed: () {
                  setState(() {
                    // sayfayı yeniler ama resigstera çevirip yenile.
                    _formStatus = FormStatus.register;
                  });
                },
                child: Text("Yeni Kayıt İçin Tıklayınız")),
          ],
        ),
      ),
    );
  }

//
//
//
// Kayıt olma formu
  Widget buildRegisterInForm() {
    // bu formun keyini oluşturduk.
    final _registerFormKey = GlobalKey<FormState>();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _passwordConfirmController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _registerFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Kayıt Formu",
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(
              height: 1,
            ),
            TextFormField(
                controller: _emailController,
                validator: (val) {
                  // Email paketindeki gibi email değilse hata vericek
                  if (!EmailValidator.validate(val)) {
                    return 'Lütfen Geçerli Bir Adres Giriniz';
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: "E-mail",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)))),
            SizedBox(
              height: 10,
            ),
            TextFormField(
                controller: _passwordController,
                validator: (valu) {
                  // @ işareti içermiyorsa hata vericek
                  if (valu.length < 6) {
                    return 'Lütfen Daha Uzun Bir Şifre Giriniz (Minimum:6)';
                  } else {
                    return null;
                  }
                },
                obscureText: true,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    hintText: "Şifre",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)))),
            SizedBox(
              height: 10,
            ),
            TextFormField(
                controller: _passwordConfirmController,
                validator: (value) {
                  if (value != _passwordController.text) {
                    return "Şifreler Uyuşmuyor";
                  } else {
                    return null;
                  }
                },
                obscureText: true,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    hintText: "Onay",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)))),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  print(_registerFormKey.currentState.validate());
                },
                child: Text("Kayıt")),
            SizedBox(
              height: 10,
            ),
            TextButton(
                onPressed: () {
                  setState(() {
                    // sayfayı yenile ama resigstera çevirip yenile.
                    _formStatus = FormStatus.signIn;
                  });
                },
                child: Text("Zaten Üye Misiniz?")),
          ],
        ),
      ),
    );
  }
}
