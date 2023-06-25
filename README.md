# Quiz App

## Project overview

This project is a simple Flutter application designed for presentation purposes. It showcases the application's architecture and code style while demonstrating the implementation of a quiz app. The app allows users to generate quizzes loaded from [The trivia API](https://the-trivia-api.com), store questions in a local database, and view the questions offline. Additionally, the app enables quiz generation from the stored questions if the device is offline. Even though the app itself is relatively simple, the architecture of the project has been designed to showcase a medium-scale project structure. This approach allows for a demonstration of how the architecture can scale and accommodate more complex features.

### Key Features:

- **Quiz generation**: Users can generate quizzes by fetching questions from an [The trivia API](https://the-trivia-api.com). The app provides a user-friendly interface to initiate the quiz generation process
- **Offline Quiz Viewing**: Once quizzes are generated and fetched from the API, the app stores the questions in a local database. Users can view and attempt these quizzes even when the device is offline, ensuring seamless access to previously fetched quiz data.
- **Quiz Generation from Local Data**: In the absence of an internet connection, the app offers the functionality to generate quizzes from the questions stored locally.
- **Streamlined User Interface**: While the primary emphasis of this example app is on showcasing architecture and code style, it also offers a streamlined user interface. The app's UI design is intentionally kept simple and intuitive, prioritizing a seamless user experience.

## Installation

You need to have Flutter and Dart installed on your system before running the project

### Step 1: Install Dependencies
Navigate to the project directory and run the following command to install the required dependencies:
```
flutter pub get
```

### Step 2: Run Build Runner
Before running the app, you need to generate the necessary code using the build runner. Execute the following command in the terminal.
```
flutter pub run build_runner build --delete-conflicting-outputs
```

### Step 3: Generate Strings
This project uses localization to handle strings in different languages. To generate the required localization files, run the following command in the terminal.
```
flutter --no-color pub global run intl_utils:generate
```

### Step 4: Run the App
After completing the above steps, you can now run the app on an emulator or physical device using the following command.
```
flutter run
```

The app should launch on your device, and you can interact with the simple quiz application.

## Project Architecture

The application follows a robust and scalable architecture based on the best practices of Flutter development. It employs a modified version of the [Bloc (Business Logic Component)](https://pub.dev/packages/bloc) pattern.

The app is structured into three main layers: data, domain, and UI.

- **Data Layer** - The data layer is responsible for handling data communication with the API, storing data into a local database, and providing access points to this layer through repositories.

- **Domain Layer** -  The domain layer contains the business logic of the application. It encompasses a set of use cases and workers that define how the app interacts with data and executes tasks.

- **UI Layer** - The UI layer is responsible for presenting the user interface. It includes the UI widgets, screens, and blocs.

Communication between the layers is structured in a one-way manner, following a unidirectional data flow. User interactions in the UI layer are propagated to the domain layer, which processes the requests and communicates with the data layer for data retrieval or modification. Once the data is updated, the UI layer receives the updated data and reflects the changes in the user interface.

## Used technologies, libraries

- [Dio](https://pub.dev/packages/dio): Used for handling API communication.

- [Retrofit](https://pub.dev/packages/retrofit): A type-safe HTTP client library inspired by Retrofit from the Android world. 

- [Drift](https://pub.dev/packages/drift): Drift is a reactive persistence library for Flutter and Dart, used for storing quizzes.

- [Freezed](https://pub.dev/packages/freezed): A code generation library for immutable classes with union and data classes. It helps generate boilerplate-free code for handling immutable states.

- [Intl](https://pub.dev/packages/intl): Used for strings localization.

- [Internet Connection Checker](https://pub.dev/packages/internet_connection_checker): Used to determine whether the device has an active internet connection.

- [Get It](https://pub.dev/packages/get_it): Used for dependency injection.

- [Logging](https://pub.dev/packages/logging): Used for logging.

- [RxDart](https://pub.dev/packages/rxdart): Used for streams manipulation.

- [AutoRoute](https://pub.dev/packages/auto_route): Used for navigation between screens.

- [Bloc](https://pub.dev/packages/bloc): Used for UI logic.

- [Flutter SVG](https://pub.dev/packages/flutter_svg): Used to display SVG icons.

- [Mockito](https://pub.dev/packages/mockito): Used for generating mock in tests.


## Project packages structure
Project packages structure is divided into 4 main packages. 3 of them (`data`, `domain`, `UI`) mirror the Clean Architecture division described in Project architecture section. `core` package contains classes used across multiple layers. Here is an outline of main packages:
```
core
  ├── di                    # Dependency injection (Get it)
  ├── entity                # Data classes representing entities within the project
  └── error                 # All errors (exceptions) used in the project
data
  ├── local                 # Contains classes for managing and retrieving data from local storage
  │   ├── dataStore         # Data stores as an abstraction to access locally stored data
  │   ├── drift             # Concrete implementation of Drift database
  │   └── model             # Local storage models
  ├── remote                # Contains classes for managing and retrieving data from remote storage (e.g. API)
  │   ├── dataStore         # Data stores as an abstraction to access remotely stored data
  │   ├── model             # Remote models (format of API response)
  │   └── retrofit          # Concrete implementation of Retrofit
  └── repository            # Repositories as an access point to the data layer and abstraction from concrete technologies used for storing data
domain
  └── useCase               # Use cases
ui
  ├── bloc                  # Blocs containing UI logic
  ├── error                 # Error handling on UI level
  ├── navigation            # Router related classes
  ├── screen                # Views for screen
  ├── theme                 # Theme
  └── widget                # Reusable UI widgets across the app

```
## Testing

The app includes unit tests to ensure the correctness of the application's logic and behavior. The tests are using Mockito to generate mocks classes.

### Unit Tests

Easiest way to run test is using terminal.

To run the unit tests, follow these steps:

1. Ensure that the project is set up correctly and all dependencies are resolved (see installation section).

2. Execute command to run all tests
```
flutter test
```

4. Monitor the test execution results to check for any failures or errors.
