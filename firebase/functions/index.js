const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

/*
exports.scheduledFunctionCrontab = functions.pubsub
  .schedule("every 2 minutes")
  .timeZone("America/New_York")
  .onRun((context) => {
    const date = Date.now();
    const nowUtc = Date.UTC(
      date.getUTCFullYear(),
      date.getUTCMonth(),
      date.getUTCDate(),
      date.getUTCHours(),
      date.getUTCMinutes(),
      date.getUTCSeconds()
    );
    const messagesRef = admin.database().ref("/markersMatrix/userMarkers");
    messagesRef.once("value", (snapshot) => {
      snapshot.forEach((child) => {
        console.log("child ${child}");
        const postDate = Date.parse(child.val()["date"]);
        const postLimit = new Date(
          dateNow.getUTCFullYear(),
          dateNow.getUTCMonth(),
          dateNow.getUTCDate(),
          dateNow.getUTCHours(),
          dateNow.getUTCMinutes() + 2,
          dateNow.getUTCSeconds()
        );
        if (nowUtc >= postLimit) {
          child.ref.set(null);
        }
      });
    });
    response.send("Deleted old entries");
  });

  */


exports.deleteOldEntries = functions.https.onRequest((request, response) => {

	const dateNow = new Date();
	const dateTwoHoursAgo = new Date(
		dateNow.getUTCFullYear(),
		dateNow.getUTCMonth(),
		dateNow.getUTCDate(),
		dateNow.getUTCHours(),
		dateNow.getUTCMinutes() + 2,
		dateNow.getUTCSeconds()
	);
    const messagesRef = admin.database().ref();
	var itemRef = messagesRef.child("/markersMatrix/userMarkers");
	
	itemRef.once("value", function(snapshot) {
		snapshot.forEach(function(child) {
			const date = new Date(child.val().data);
			if (date <= dateTwoHoursAgo) {
				child.ref.remove();
			}
		});
		
	});

    response.send("OK");
  });
