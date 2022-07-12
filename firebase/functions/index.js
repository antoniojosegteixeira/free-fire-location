const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.removeOldMessages = functions.https.onRequest((req, res) => {
  const timeNow = Date.now();
  const messagesRef = admin.database().ref("/markersMatrix/userMarkers");
  messagesRef.once("value", (snapshot) => {
    snapshot.forEach((child) => {
      if (
        Number(child.val()["date"]) + Number(child.val()["duration"]) <=
        timeNow
      ) {
        child.ref.set(null);
      }
    });
  });
  return res.status(200).end();
});
