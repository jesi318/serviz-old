import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

final Future<FirebaseApp> intilization = Firebase.initializeApp();
FirebaseAuth auth = FirebaseAuth.instance;
