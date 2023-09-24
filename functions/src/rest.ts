import * as functions from "firebase-functions/v2";
import * as admin from "firebase-admin";

functions.setGlobalOptions({
  region: "europe-west1",
});

export const getMoviesData = functions.https.onRequest(async (req, res) => {
  const snapshot = await admin.firestore().collection("movies").get();

  if (snapshot.empty) {
    res.status(400).send({error: "Collection of movies is empty."});
    return;
  }

  const data: any[] = [];

  snapshot.forEach((doc) => {
    data.push({
      id: doc.id,
      ...doc.data(),
    });
  });

  res.status(200).send({data: data});
});
