import * as functions from "firebase-functions/v2";
import * as auth from "./auth";
import * as firestore from "./firestore";
import * as storage from "./storage";

functions.setGlobalOptions({
  region: "europe-west1",
});

exports.onAuthUserCreate = auth.createUser;
exports.compressMedia = storage.compressMedia;
exports.sendPushNotification = firestore.sendPushNotification;

