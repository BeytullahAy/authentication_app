import 'package:authentication_app/services/auth.dart';
import 'package:authentication_app/views/sing_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../views/home_page.dart';

// Eğer kayıtlıysa ana sayfaya yönlendireceğiz.
// hayır kayıtlı değil ise kayıt olma sayfasına yönlendireceğiz.
class onBoardWidget extends StatefulWidget {
  @override
  State<onBoardWidget> createState() => _onBoardWidgetState();
}

class _onBoardWidgetState extends State<onBoardWidget> {
  // bool _isLogged = true;

  @override
  Widget build(BuildContext context) {
    // auth dinlemek için Provider kullandık.
    final _auth = Provider.of<Auth>(context, listen: false);

// auth ile authstatuse bağlanıoruz. authstatus ise firbase bağlanıyor.
// böylelikle log bilgisi alınıyor
    return StreamBuilder<User>(
        stream: _auth.authStatus(),
        // AsyncSnapshot bir streamdan en son gelen verinin paketlendiği sınıf.
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          // hazır kod burası. Bağlantı varsa aktif et.
          if (snapshot.connectionState == ConnectionState.active) {
            // aktif ise data boş ise signinPage
            // data boş dolu ise HomePage yönlendir.
            return snapshot.data != null ? HomePage() : signInPage();
          } else {
            // aktif değilse bekleme ekranı yap
            return SizedBox(
              height: 300,
              width: 300,
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
