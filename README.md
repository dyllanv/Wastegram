### Wasteagram: 
A mobile app that enables coffee shop employees to document daily food waste in the form of "posts" consisting of a photo, number of leftover items, the current date, and the location of the device when the post is created. The application should also display a list of all previous posts. 

The functional requirements are: 

- Display a circular progress indicator when there are no previous posts to display in the List Screen. 
- The List Screen should display a list of all previous posts, with the most recent at the top of the list. 
- Each post in the List Screen should be displayed as a date, representing the date the post was created, and a number, representing the total number of wasted items recorded in the post. 
- Tapping on a post in the List Screen should cause a Detail Screen to appear. The Detail Screen's back button should cause the List Screen to appear. 
- The Detail Screen should display the post's date, photo, number of wasted items, and the latitude and longitude that was recorded as part of the post. 
- The List Screen should display a large button at the center bottom area of the screen. 
- Tapping on the large button enables an employee to capture a photo, or select a photo from the device's photo gallery. 
- After taking a new photo or selecting a photo from the gallery, the New Post screen appears. 
- The New Post screen displays the photo of wasted food, a Number of Items text input field for entering the number of wasted items, and a large upload button for saving the post. 
- Tapping on the Number of Items text input field should cause the device to display its numeric keypad. 
- In the New Post screen, tapping the back button in the app bar should cause the List Screen to appear. 
- In the New Post screen, tapping the large upload button should cause the List Screen to appear, with the latest post now appearing at the top of the list. 
- In the New Post screen, if the Number of Items field is empty, tapping the upload button should cause a sensible error message to appear. 
 
In addition to the functional requirements above, your application should meet the following technical requirements: 
- Use the location, image_picker, cloud_firestore, and firebase_storage packages to meet the functional and technical requirements. 
- Incorporate the use of Firebase Cloud Storage and Firebase Cloud Firestore for storing images and post data. 
- Data should not be stored locally on the device. 
- On the List Screen, the application should display the posts stored in the Firestore database. 
- On the Detail Screen, the application should display the image stored in the Cloud Storage bucket. 
- On the New Post screen, tapping the large upload button should store a new post in the Firestore database. 
- Each "post" in Firestore should have the following attributes: date, imageURL, quantity, latitude and longitude. 
- The application should incorporate the Semantics widget in multiple places, such as interactive widgets like buttons, to aid accessibility. 
- The codebase should incorporate a model class. 
- The codebase should incorporate a few (two or three) simple unit tests that test the model class. 

To run: 
- Setup Flutter: https://flutter.dev/docs/get-started/install/windows 
- Create flutter project: Example, 'flutter create --org edu.oregonstate.YOURONID wasteagram' 
- Setup Cloud Firestore Database and Firebase Storage: https://console.firebase.google.com/ 
- Create two apps, one for iOS and one for Android, using same name as flutter project (ex., 'edu.oregonstate.YOURONID wasteagram') 
- Follow instructions when setting up Firestore to edit project files AndroidManifest.xml and iOS Info.plist, and adding Google Service files to specified directories. 
- Start a collection of 'posts' within Firestore Database. 
- Check 'Rules' for Firestore Database and for Firebase Storage and modify the authorization file to not require authentcation. 
- From the wastegram directory, run 'flutter run lib/main.dart' 
