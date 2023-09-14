# About Section

## App Summary

This app lets the user sign into a blog, view all of the posts that have been made by other users on the blog, and create their own posts while they are logged in.

Credit to app icon is: <https://www.iconbolt.com/iconsets/streamline-emoji/meat-on-bone>
Credit to pictures on the page is:
    slightly_meatier_bone: Howie's screenshot from the game Genshin Impact ; 
    stone: <https://i.ytimg.com/vi/FBRrnBS8yjY/maxresdefault.jpg> ; 
    cat: <https://www.pinterest.com/pin/802977808537483596/>

## About the Additional Features

First feature: We implemented user-defined tags so that other users can search for relevant blog posts that have certain words included in the tags section.

Second feature: We implemented a search to compliment the tag feature so that users could actually search for specific blog posts instead of having superfluous tags.  This feature is not completely functional because it only searches for posts in memory instead of querying the Firebase Firestore for the relevant tags.  **Look to the other three features for full functionality!**

Third feature: Google and GitHub authentication was added for user convenience.

Fourth feature: Pagination was implemented, giving the user the ability to only see a couple posts at a time, instead of loading all of the posts immediately when the app is opened. Also, a refresh feature was implemented with the reset button and swiping down on the app to reset the posts to its native state when there are too many on the screen.

### Firebase Security

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read: if true;
      allow write: if request.auth != true;
    }
  }
}
```
