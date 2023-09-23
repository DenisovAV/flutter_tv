import * as functions from "firebase-functions/v2";
import * as admin from "firebase-admin";

export const sendPushNotification = functions.firestore.onDocumentCreated("movies/{id}",
  async (event) => {
    const movie = event.data;

    if (!movie) {
      return console.error("Data is not available in the snapshot.");
    }

    const name = movie.get("name");
    const image = movie.get("image");

    console.log(`${name} was added to collection!`);

    const notification: admin.messaging.Message = {
      notification: {
        title: `${name} added!`,
        body: "New movie was added to movies catalog, please enjoy!",
        imageUrl: image,
      },
      topic: "movies",
    };

    try {
      const response = await admin.messaging().send(notification);
      console.log("Successfully sent message:", response);
    } catch (error) {
      console.error("Error sending message:", error);
    }
  });
