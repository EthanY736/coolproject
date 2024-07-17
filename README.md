# Coding Minds Template

This is a Flutter template for use in Coding Minds applications for quicker development times. While the actual template exists on FlutterFlow, this is a version of that template made for Dart programming rather than through the typical FlutterFlow editor. In either case, the template works the same way and is expanded upon in the same way.

## Features

This template as of 6/17/2024 features:
1. Already-done integration with Firebase's authentication and Firestore services
2. A sign in and account creation page
3. A blank dashboard
4. A fully working chat system between two users
5. A profile settings page
6. An option to delete or log out of a logged in account

## Getting Started

### Setup
1. Fork this GitHub repository.
2. Open this project in Android Studio.
3. If it isn't enabled already, enable Dart in the configuration.
4. Install the dependencies found in `pubspec.yaml`.
5. Make sure that the app runs.
6. Create a Firebase server and [follow the instructions to link the Firebase account to this project](https://firebase.google.com/docs/flutter/setup) (don't use the one that the project comes with)

### What's There
The pages for this application are located in `lib\pages`.

| Page           | Description                                           |
|----------------|-------------------------------------------------------|
| chat           | The page used for one on one or group chats.          |
| chat_nav       | The page used to select a user or group to chat with. |
| delete_account | The account confirmation and deletion page.           |
| edit_profile   | The page used for a user to edit their information.   |
| home_page      | A currently blank home page.                          |
| login_signup   | The creation creation and login page.                 |
| profile        | The user's profile page.                              |
| settings       | The settings page for the user's account.             |


**NOTE** that the pages are folders, containing a `X_model.dart` and a `X_widget.dart` file. For example, `chat` contains `chat_model.dart` and `chat_widget.dart`. The `X_widget.dart` file contains the actual page code while the `X_model.dart` file can be largely ignored.

## A Note on Complexity

This template was initially designed on FlutterFlow and automatically converted into a form that can be edited using "traditional" Flutter development methods using Android Studio. Given that FlutterFlow acts as an abstraction layer over Flutter and the given template is heavily stylized, you will find that widgets on pages are lengthy and obtuse.

1. You probably should **not** modify template pages.
2. When adding new content, you do **not** need to follow the coding conventions that FlutterFlow uses, or style your widgets to match the template style. It is fine to just keep it simple and do it as you usually would.
