import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyB-zMKZlMpz-QcDlhHv1v9eEyfFmAkDpLc",
            authDomain: "cmtemplate.firebaseapp.com",
            projectId: "cmtemplate",
            storageBucket: "cmtemplate.appspot.com",
            messagingSenderId: "1021853751707",
            appId: "1:1021853751707:web:ee8b1c1d573079c580693e"));
  } else {
    await Firebase.initializeApp();
  }
}
