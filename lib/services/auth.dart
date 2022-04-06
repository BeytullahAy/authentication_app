import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

// Auth serivisi

class Auth {
  // kullanıcı id'si oluşturmak için tanımlıyoruz
  final _firebaseAuth = FirebaseAuth.instance;

  Future<User> signInAnonymously() async {
    final UserCredentials = await _firebaseAuth.signInAnonymously();
    return UserCredentials.user;

    // bunları yazdıktan sonra direkt olarak istediğimi yerde
    // sınıf oluşturup çağırabiliriz ama bağımlı olur.
    // o yüzden Provider ile yayınlıyacağız.
  }

  // logout işlemi yapılması
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
