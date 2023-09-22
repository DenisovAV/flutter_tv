import * as functions from "firebase-functions/v1";
import * as admin from "firebase-admin";
import axios from "axios";
import {randomUUID} from "crypto";

admin.initializeApp();

export const createUser =
  exports.createUser = functions.region("europe-west1").auth.user().onCreate(async (user) => {
    const uuid = randomUUID();
    let updatedAvatarURL: string | null = null;

    if (user.photoURL) {
      const bucket = admin.storage().bucket();
      const avatarFileName = `avatars/${user.uid}.jpg`;

      const response = await axios.get(user.photoURL,
        {responseType: "arraybuffer"});
      const buffer = Buffer.from(response.data, "binary");

      const file = bucket.file(avatarFileName);
      await file.save(buffer, {
        contentType: "image/jpeg",
        public: true,
      });

      await file.setMetadata({
        metadata: {
          firebaseStorageDownloadTokens: uuid,
        },
      });

      updatedAvatarURL = `https://firebasestorage.googleapis.com/v0/b/${bucket.name}` +
        `/o/${encodeURIComponent(file.name)}?alt=media&token=${uuid}`;
    }

    // Get the user's email address.
    const email = user.email;

    // Create a new document in the `users` collection.
    const doc = admin.firestore().collection("users").doc(user.uid);

    doc.set({
      email,
      displayName: user.displayName,
      avatarURL: updatedAvatarURL,
      admin: false,
    });
  });
