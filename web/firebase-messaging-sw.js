importScripts('https://www.gstatic.com/firebasejs/8.4.1/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/8.4.1/firebase-messaging.js');

const firebaseConfig = {
    apiKey: "AIzaSyBSzUdobLGj_-bOF1BQ9xcxB4Re6DHxrE0",
    authDomain: "geekscmsystem.firebaseapp.com",
    projectId: "geekscmsystem",
    storageBucket: "geekscmsystem.appspot.com",
    messagingSenderId: "6210683209",
    appId: "1:6210683209:web:e0001a88eadb1320389a98",
    measurementId: "${config.measurementId}"
};
firebase.initializeApp(firebaseConfig);
const messaging = firebase.messaging();

/*messaging.onMessage((payload) => {
console.log('Message received. ', payload);*/
messaging.onBackgroundMessage(function (payload) {
    console.log('Received background message ', payload);

    const notificationTitle = payload.notification.title;
    const notificationOptions = {
        body: payload.notification.body,
    };

    self.registration.showNotification(notificationTitle,
        notificationOptions);
});