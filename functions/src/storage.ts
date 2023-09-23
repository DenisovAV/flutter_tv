import * as functions from "firebase-functions/v2";
import * as sharp from "sharp";
import * as admin from "firebase-admin";

export const compressMedia =
  exports.compressMedia = functions.storage.onObjectFinalized({cpu: 2}, async (event) => {
    const fileBucket = event.data.bucket; // Storage bucket containing the file.
    const filePath = event.data.name; // File path in the bucket.
    const contentType = event.data.contentType ?? ""; // File content type.

    // Exit if this is triggered on a file that is not an image.
    if (!contentType.startsWith("image/")) {
      return console.error("This is not an uploaded image.");
    }

    // Download file into memory from bucket.
    const bucket = admin.storage().bucket(fileBucket);
    const downloadResponse = await bucket.file(filePath).download();
    const imageBuffer = downloadResponse[0];

    const meta = await sharp(imageBuffer).metadata();

    const rotatedBuffer = (meta.width! < meta.height! ?
      await sharp(imageBuffer).rotate(90).toBuffer() : imageBuffer);

    const processedBuffer = await sharp(rotatedBuffer).resize({
      width: 600,
      height: 300,
      withoutEnlargement: true,
    }).toBuffer();

    // Upload the processed image.
    const metadata = {contentType: contentType};
    const file = bucket.file(filePath);
    await file.save(processedBuffer, {
      metadata: metadata,
    });

    return console.error("Image uploaded!");
  });
