import * as admin from "firebase-admin";
import * as auth from "./auth";
import * as firestore from "./firestore";
import * as storage from "./storage";
import * as rest from "./rest";

admin.initializeApp();

exports.onAuthUserCreate = auth.createUser;
exports.compressImage = storage.compressImage;
exports.sendPushNotification = firestore.sendPushNotification;
exports.getMoviesData = rest.getMoviesData;


