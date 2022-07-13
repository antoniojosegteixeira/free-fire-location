const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();


exports.scheduledFunctionCrontab = functions.pubsub
  .schedule("every 2 hours")
  .timeZone("Europe/London")
  .onRun((context) => {
	
	const dateNow = new Date(context.timestamp);
	const dateTwoHoursAgo = new Date(
		dateNow.getUTCFullYear(),
		dateNow.getUTCMonth(),
		dateNow.getUTCDate(),
		dateNow.getUTCHours() - 2,
		dateNow.getUTCMinutes(),
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



exports.deleteOldEntries = functions.https.onRequest((request, response) => {
	console.log('CFOSIAJDSAASIOA');
	const dateNow = new Date();
	const dateTwoHoursAgo = new Date(
		dateNow.getUTCFullYear(),
		dateNow.getUTCMonth(),
		dateNow.getUTCDate(),
		dateNow.getUTCHours() - 2,
		dateNow.getUTCMinutes(),
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

 