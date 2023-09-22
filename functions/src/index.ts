import * as auth from "./auth";
import * as storage from "./storage";

exports.onAuthUserCreate = auth.createUser;
exports.generateThumbnail = storage.compressMedia;
