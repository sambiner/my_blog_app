# my_blog_app
A blog app that I and a group member collaborated on, integrating Firebase into the app to continue instances of blog posts by people who used the app. Final grade achieved: 101%

## For Submission
Create a blog mobile app using Firestore for persistence and Firebase Auth for authentication. You have been given a [starter/sample bare-bones blog app project](https://classroom.github.com/a/rk1OqpJQ) but you are under no obligation to use that code as given—feel free to pick and choose from it to build a blog app your way. Make it as amazing as can be in terms of features and look-and-feel. Explore the possibilities—unleash your creativity!

Make sure that your blog app goes _well beyond_ the given bare-bones version: note that this is _not_ a suggestion; it’s a requirement 😈 Some ideas:
* Expand article data: lots of potential here, such as adding tags, categories, loglines, sectioning, etc.—all of these will require deeper knowledge of the [Firestore data model](https://firebase.google.com/docs/firestore/data-model)
* Filter/search articles: welcome to the world of [querying](https://firebase.google.com/docs/firestore/query-data/queries)
* Categorize/group articles: yes, still querying, with some [ordering and limits](https://firebase.google.com/docs/firestore/query-data/order-limit-data)
* Page through articles: [actually a necessity](https://firebase.google.com/docs/firestore/query-data/query-cursors) as your article counts grow—with some interesting user interface options though, ranging from classic previous/next buttons to [infinite scroll](https://swiftuirecipes.com/blog/infinite-scroll-list-in-swiftui)
* Update articles: similarly, this corresponds to [updating documents](https://firebase.google.com/docs/firestore/manage-data/add-data#update-data)
* Delete articles: that’s a specific case of [deleting data](https://firebase.google.com/docs/firestore/manage-data/delete-data)
* Allow photo uploads or attachments: you will want to learn about [Firebase Storage](https://firebase.google.com/docs/storage/ios/start) on the back end and [image access](https://www.hackingwithswift.com/books/ios-swiftui/importing-an-image-into-swiftui-using-phpickerviewcontroller) on the front end
* Add user metadata (e.g., photos, profile, links, etc.): just a specific case of expanding your document structure, but this one may involve [additional collections and more documents](https://firebase.google.com/docs/firestore/data-model#collections)
* Implement rich text editing: this one is a [SwiftUI deep dive](https://betterprogramming.pub/how-to-implement-a-wysiwyg-editor-in-swiftui-c60236749943) but may be worth it
* Support Touch ID/Face ID: this breaks you away from the premade FirebaseUI views into [direct invocation of Firebase authentication functions](https://firebase.google.com/docs/auth/ios/start) which you would call after [using Touch ID or Face ID](https://developer.apple.com/documentation/localauthentication/logging_a_user_into_your_app_with_face_id_or_touch_id) with [SwiftUI](https://www.hackingwithswift.com/books/ios-swiftui/using-touch-id-and-face-id-with-swiftui). This can go [quite deep if you want a completely secure solution](https://developer.apple.com/documentation/localauthentication#overview)—for this assignment, it’s OK to go with something rudimentary (though it won’t hurt to read through that last link to get the big picture)
* Support [links in articles](https://www.appcoda.com/swiftui-wkwebview/) that go to the web browser or an embedded web view
* Support additional methods, whether [via FirebaseUI](https://firebase.google.com/docs/auth/ios/firebaseui#set_up_sign-in_methods) or [through direct SDK calls](https://firebase.google.com/docs/auth/ios/start#next_steps)—note that some of these will require additional configuration or packages

Add _at least three (3)_ features beyond what is provided by the starter blog app. Additional features will earn extra credit based on the sophistication of those features.

As you can see above, starter links for these features are provided but don’t hesitate to find others. As always, if you use any content directly from a source, _make sure to credit the source_. Note also that there isn’t enough time to cover all of these in class so some self-study will be called for. This is by design because it corresponds to what one typically does in industry or research.

Notice how the Firebase SDKs abstract out the inner details of interacting with Firebase and expose Firebase functionality to your mobile app by way of “plain” classes, objects, methods, and functions. This can be viewed as a “professional example” of what you were asked to do with your generic API network code. Similarly, you will also be best off if you abstract the _Firebase functionality_ away from the rest of your app code. This puts you in a position to transition away more easily in case you change your back end to something other than Firebase.

As before, continue to reinforce and build upon the skills you have already learned:
* Use of model objects to separate data from presentation—now matched up to your Firebase Firestore documents!
* Retrieval from and interaction with the Firebase back end
* Abstraction of Firebase operations behind classes, objects, methods, and functions (async where appropriate)
* Appropriate user interface feedback for operations-in-progress
* Correct error handling with messaging to the user when appropriate
* Effective layout via proper composition of stacks, spacers, padding, and other SwiftUI features
* Appealing color choices and visuals—demonstrate your mastery of views and their properties (without violating any iOS Human Interface Guidelines 😅)
* Proper choice of input views and controls
* Well-chosen animations or transitions beyond the standard SwiftUI view behaviors
* Well-chosen programmed graphics using paths, gradients, and related functions
* Custom app icon

Supply a simple _about.md_ Markdown file that describes your blog app briefly. Make sure to _state and elaborate on the three (3) or more features_ that go beyond the bare bones starter/sample code. Also include a copy of the _production_ security policy that you implemented for your database.
