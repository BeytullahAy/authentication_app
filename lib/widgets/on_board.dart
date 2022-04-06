import 'package:authentication_app/views/sing_in_page.dart';
import 'package:flutter/material.dart';

import '../views/home_page.dart';

// Eğer kayıtlıysa ana sayfaya yönlendireceğiz.
// hayır kayıtlı değil ise kayıt olma sayfasına yönlendireceğiz.
class onBoardWidget extends StatefulWidget {
  @override
  State<onBoardWidget> createState() => _onBoardWidgetState();
}

class _onBoardWidgetState extends State<onBoardWidget> {
  bool _isLogged = true;

  @override
  Widget build(BuildContext context) {
    return _isLogged ? HomePage() : signInPage();
  }
}
