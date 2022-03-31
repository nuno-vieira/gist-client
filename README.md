# Gist Client iOS App
A simple Gist Client application with Clean MVVM Architecture.

## Features
- List random gists
- Show a gist

## Requirements
- Xcode 13.0+

## How to Run
Open `GistClient.xcodeproj` and wait for SPM to fetch the dependencies.
- Application: Run `GistClient.xcscheme` from Xcode.
- Unit Tests: Run `GistClientTests.xcscheme` from Xcode.
- UI Tests: Run `GistClientUITests.xcscheme` from Xcode.

## Architecture
### Stack
- Swift
- UIKit
- Clean MVVM + Navigator
- Custom `Observable<Value>` type for `View<->ViewModel` Binding
- Manual Factories for Dependency Injection
- Dependency Manager: SPM

### Dependencies
- **Kingfisher** for Image Fetching and Caching.
- **Realm** for DB.

### Overview
The codebase follows the Clean Architecture, so the project has good maintainability, is easily testable, and does not depend directly on external dependencies. In the Presentation Layer, the MVVM design pattern is used for managing UI State and UI Updates. A custom `Observable<Value>` type is used to bind the view with the view model.

The Navigator Pattern is used for handling navigation, which is a very simple and flexible pattern. The dependencies are simply managed by factories that live in the Navigator, but in a bigger project, proper dependency containers would be a better approach to easily create the dependencies of each object.

For UITests the Page Object pattern was used together with some custom XCTest Gherkin extensions. This makes it really easy to read the UITests and also analyse the test logs.

## Notes
- Currently, there's no pagination. For simplicity, the gists are always fetched from scratch, and only contain the latest gists.
- Currently, the detail gist is not persisted, if there's no network, it will fail to load the gist.
- Although Realm is used as the persistent layer, we could easily replace it with CoreData or even UserDefaults, since the data repositories are abstracted.
- Localizable strings should be used in a real project and not plain strings.
- UITests should use accessibility identifiers in a real project, not only do they make the UITests more maintainable, but they provide accessibility to the application.
- UITests should use a mock server in a real application to make the UI tests more stable and less flaky.

## Future Improvements
- [ ] Add/Remove/List Favorites (Only Local DB)
- [ ] Pagination
- [ ] User Profile (SwiftUI)
- [ ] Persist Gist Raw HTML
