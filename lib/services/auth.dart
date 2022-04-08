import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
    UserCredential userCredentials;
    try {
      userCredentials = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredentials.user;
    } on FirebaseAuthException catch (e) {
      //aynı hesapla tekrar kayıt olmak istersek hata vericek
      print(e.code);
      print(e.message);
      // hata gelen yere bu mesajı göndermek için rethrow kullanıyoruz.
      rethrow;
    }
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

// Google Sing in girişi
  Future<User> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

// gerçekten bir şey döndüyle aşağıdakileri yap.
    if (googleUser != null) {
      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      return userCredential.user;
    } else {
      return null;
    }
  }

  // logout işlemi yapılması
  Future<void> signOut() async {
    await _firebaseAuth.signOut();

    // googledan da çıkmak için
    await GoogleSignIn().signOut();
  }

  // bu method firebase ile konusacak.
  // log in mi log out mu onun bilgisi alınması işlemi için
  Stream<User> authStatus() {
    return _firebaseAuth.authStateChanges();
  }
}
