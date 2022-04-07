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

// E mail ile Kayıt olmak için kullanıcıdan aldığımız bilgileri buraya gönderiyoruz.
// burasıda bize user bilgilerini gönderiyor.
  Future<User> createUserWithEmailAndPassword(
      String email, String password) async {
    final userCredentials = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return userCredentials.user;
  }

// E mail girişi için
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    final userCredentials = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return userCredentials.user;
  }

  // Şifre sıfırlama methodu
  Future<void> sendPasswordResetEmail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  // logout işlemi yapılması
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  // bu method firebase ile konusacak.
  // log in mi log out mu onun bilgisi alınması işlemi için
  Stream<User> authStatus() {
    return _firebaseAuth.authStateChanges();
  }
}
