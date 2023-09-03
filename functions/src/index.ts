
import * as functions from "firebase-functions/v1";
import * as admin from "firebase-admin";

admin.initializeApp();

exports.onAuthUserCreate = functions.auth.user().onCreate(async (user) => {
  // Get the user's email address.
  const email = user.email;

  // Create a new document in the `users` collection.
  const doc = admin.firestore().collection("users").doc(user.uid);
  doc.set({
    email,
    displayName: user.displayName,
    avatarURL: user.photoURL,
    admin: false,
  });

});

