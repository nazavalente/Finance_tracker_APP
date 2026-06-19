require('dotenv').config({ quiet: true });
const admin = require('firebase-admin');

const serviceAccountPath = process.env.GOOGLE_APPLICATION_CREDENTIALS;

if (!admin.apps.length) {
  if (serviceAccountPath) {
    admin.initializeApp({
      credential: admin.credential.cert(require(serviceAccountPath)),
    });
  } else {
    admin.initializeApp({
      credential: admin.credential.applicationDefault(),
    });
  }
}

const db = admin.firestore();

console.log('Firebase Firestore connected.');

module.exports = db;
