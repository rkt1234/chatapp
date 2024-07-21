import 'package:chatapp/models/user_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  DatabaseService() {
    setupCollectionReferences();
  }

  final FirebaseFirestore firebasefirestore = FirebaseFirestore.instance;
  CollectionReference? usersCollection;

  void setupCollectionReferences() {
  try {
      usersCollection = firebasefirestore
        .collection('users')
        .withConverter<UserProfile>(
            fromFirestore: (snapshots, _) =>
                UserProfile.fromJson(snapshots.data()!),
            toFirestore: (userProfile, _) => userProfile.toJson());
  } catch(e) {
    print(e);
  }
  }

  Future<void> createUserProfile({
    required UserProfile userProfile,
  }) async {
    await usersCollection!.doc(userProfile.uid).set(userProfile);
  }
}
