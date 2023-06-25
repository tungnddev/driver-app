##Driver App With Flutter Clean Architecture
A UI-only driver app with google map, custom camera, horizontal list view calendar, form builder,...
### Main Feature
* `Calendar` - Show work by day
* `Router` - Routes that user will follow by day, check by google maps - position, and can capture the result
* `Profile`
* `Notification`
### Project structure
* `/app` - main application
* `/data` - get data from remote (API) or local (database / local storage) and send to UI layer
* `/domain` - all POJO class, include models app, core of repository
* `/presenter` - code all screens using BLoC state management
* `/env` - config environment
* `/route` - handle all navigator, using route
* `/I10n` - config language in app
* `/utils` - utilities for app
    * `define` - Define some const resource, include images, colors,...
    * `extension` - extension for app
    * `widgets` - common widgets
### Components:
* [BLoC](https://pub.dev/packages/bloc)
* [FlutterFire](https://firebase.flutter.dev/)
* Clean Architecture
* [Google Map](https://pub.dev/packages/google_maps_flutter)
* [Camera](https://pub.dev/packages/camera)
### Usage
* Install Flutter 3.3 
* Run `flutter pub get` to get and sync all library
* Run `flutter pub run intl_utils:generate` to generate files language 
* Run `flutter pub run build_runner build --delete-conflicting-outputs` to generate all models flow json
* Run on device `flutter run`
* Build apk `flutter build apk`
* Build ios `flutter build ios`
### Screenshots
##### Main
<img src="./screenshot/login.png" alt="drawing" width="120"/>
<img src="./screenshot/home.png" alt="drawing" width="120"/>
<img src="./screenshot/profile.png" alt="drawing" width="120"/>
<img src="./screenshot/notification.png" alt="drawing" width="120"/>
##### Calendar
<img src="./screenshot/calendar.png" alt="drawing" width="120"/>
<img src="./screenshot/calendar_pending.png" alt="drawing" width="120"/>
<img src="./screenshot/confirm_route.png" alt="drawing" width="120"/>
##### Router
<img src="./screenshot/maps.png" alt="drawing" width="120"/>
<img src="./screenshot/google_map_2.png" alt="drawing" width="120"/>
<img src="./screenshot/route_list.png" alt="drawing" width="120"/>
<img src="./screenshot/order_detail.png" alt="drawing" width="120"/>
##### Finish order
<img src="./screenshot/payment.png" alt="drawing" width="120"/>
<img src="./screenshot/capture.png" alt="drawing" width="120"/>
<img src="./screenshot/camera.png" alt="drawing" width="120"/>
<img src="./screenshot/rate.png" alt="drawing" width="120"/>


### License
[MIT](https://choosealicense.com/licenses/mit/)