importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");

firebase.initializeApp({
    apiKey: 'AIzaSyBSzUdobLGj_-bOF1BQ9xcxB4Re6DHxrE0',
    appId: '1:6210683209:web:e0001a88eadb1320389a98',
    messagingSenderId: '6210683209',
    projectId: 'geekscmsystem',
    authDomain: 'geekscmsystem.firebaseapp.com',
    storageBucket: 'geekscmsystem.appspot.com',
    measurementId: 'G-W5LQ1VXNZ4',
});
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
    console.log("onBackgroundMessage", message);
});