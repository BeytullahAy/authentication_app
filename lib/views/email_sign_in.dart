// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:authentication_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart'; // e mail kontrolü için kütüphane

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
                : _formStatus == FormStatus.register
                    ? buildRegisterInForm()
                    : buildResetForm()),
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
                      borderRadius: BorderRadius.circular(20.0))),
            ),
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
            ElevatedButton(
                onPressed: () async {
                  // Eğer formdaki e mail ve şifre kurallara uyuyor ise.
                  if (_signInFormKey.currentState.validate()) {
                    // user çekme işlemi
                    final user = await Provider.of<Auth>(context, listen: false)
                        .signInWithEmailAndPassword(
                            _emailController.text, _passwordController.text);

                    // eğer doğrulanmamışsa
                    if (user != null && !user.emailVerified) {
                      await _showMyDialog();
                      // kullanıcıyı çıkart.
                      // çünkü firebase tarafında kullanıcıgı giriş yaptı sadece onaylamadı.
                      // eğer kullanıcı uygulamayı kapatıp açarsa direkt homepage ekranına gider.
                      await Provider.of<Auth>(context, listen: false).signOut();
                    }
                    // anladık dedikten sonra mail onayı yapmadıgı için önceki sayfaya atıcak.
                    Navigator.pop(context);
                  }
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
            SizedBox(
              height: 10,
            ),
            TextButton(
                onPressed: () {
                  setState(() {
                    // sayfayı yenile ama resigstera çevirip yenile.
                    _formStatus = FormStatus.reset;
                  });
                },
                child: Text("Şifremi unuttum")),
          ],
        ),
      ),
    );
  }

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
                onPressed: () async {
                  // eğer bütün form elemanları okey verdiyse forma
                  if (_registerFormKey.currentState.validate()) {
                    // yeni bir kullanıcı oluşması için provider ile Auth classına
                    // bilgileri yolluyoruz.
                    // daha sonra userın gelmesini bekliyoruz
                    // geldikten sonra
                    final user = await Provider.of<Auth>(context, listen: false)
                        .createUserWithEmailAndPassword(
                            _emailController.text, _passwordController.text);
                    print(user.uid);

                    // eğer user içindeki veri doğrulanmamış ise
                    // e maile doğrulama mesajı gönder.
                    if (user != null && !user.emailVerified) {
                      await user.sendEmailVerification();
                    }

                    // kullanıcı anladım yazısına tıklayana kadar ekranda kal (alert diaglog)
                    await _showMyDialog();

                    // kullanıcıyı çıkart.
                    // çünkü firebase tarafında kullanıcıgı giriş yaptı sadece onaylamadı.
                    // eğer kullanıcı uygulamayı kapatıp açarsa direkt homepage ekranına gider.
                    await Provider.of<Auth>(context, listen: false).signOut();

                    setState(() {
                      // giriş yapma ekranına yolla
                      _formStatus = FormStatus.signIn;
                    });
                  }
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

  // Şifre yenileme
  Widget buildResetForm() {
    final _resetFormKey = GlobalKey<FormState>();
    TextEditingController _emailController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _resetFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Şifre Yenileme', style: TextStyle(fontSize: 25)),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _emailController,
              validator: (value) {
                if (!EmailValidator.validate(value)) {
                  return 'Lütfen Geçerli bir adres giriniz';
                } else {
                  return null;
                }
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: 'E-mail',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0))),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                if (_resetFormKey.currentState.validate()) {
                  await Provider.of<Auth>(context, listen: false)
                      .sendPasswordResetEmail(_emailController.text);

                  await _showResetPasswordDialog();

                  Navigator.pop(context);
                }
              },
              child: Text('Gönder'),
            ),
          ],
        ),
      ),
    );
  }

  // kullanıcıyı kayıt olmak için email gönderdikten sonra alert diyalog ekranı.
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // dışarıya tıklanıp tıklanmama durumu
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Onay Gerekiyor'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Merhaba lütfen mailinizi kontrol ediniz.'),
                Text('Onay linkine tıklayıp tekrar giriş yapmalısınız.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Anladım'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showResetPasswordDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('ŞİFRE YENİLEME'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Merhaba, lütfen mailinizi kontrol ediniz,'),
                Text('Linki tıklayarak şifrenizi yenileyiniz.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('ANLADIM'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
