import 'package:google_sign_in/google_sign_in.dart';

void main() {
  // This test file is just to check what methods are available on GoogleSignIn
  final googleSignIn = GoogleSignIn.instance;

  // Try to access methods to see what's available
  // Uncomment one at a time to check

  // googleSignIn.signIn();
  // googleSignIn.authenticate();
  // googleSignIn.initialize();

  print('GoogleSignIn instance created: $googleSignIn');
}
