# CEP Search
Basic App to help you find more information about a specific CEP

[![CI-iOS](https://github.com/igdutra/CEPSearch/actions/workflows/CI-iOS.yml/badge.svg)](https://github.com/igdutra/CEPSearch/actions/workflows/CI-iOS.yml)
[![CI-macOS](https://github.com/igdutra/CEPSearch/actions/workflows/CI-macOS.yml/badge.svg)](https://github.com/igdutra/CEPSearch/actions/workflows/CI-macOS.yml)

## Architecture Overview

![Architecture Overview](Architecture%20Overview.png)

## Project Structure
Main entrance point is on the `CEPApp/CEPApp.xcworkspace/`  
Note that there will be 3 Schemes  

1. `CEPSearch`, which contains Shared code that can ran both on Mac and iOS Platforms
    * And thus can have its tests running locally on MacOS when on development.
2. `CEPiOS`, which contains iOS-platform exclusive code (UIKit).
    * Although it must be pointed out that case a project accepts MacOS Catalyst, this target is not necessary
3. `CEPApp`, main target App, where the Composition Root resides and compose all the other components together.

## TODOs
There are some local observations in code, but there are some next priority tasks:
1. Add spinner when fetching CEP, so the User can understand that an async operation is happening
2. Handle API errors in the UI: Notify the User when the operation failed.
3. Add string formatting, so that regardless how the user types, we can fetch it.
4. Add acceptance tests: investigate on SwiftUI how to simulate a button tapped.
5. Add more tests to the API Layer: add more custom errors as well as test to cover other HTTP Status.


## Use Cases

### GET CEP Details from Remote Use Case

#### Data:
- CEP API BASE URL
- CEP String

#### Primary course (happy path):
1. Execute "Get CEP Details" command with the specified base API URL and CEP string.
2. System constructs the API URL using data provided.
2. System retrieves data from the provided API.
3. System validates downloaded data.
4. System creates CEP Details from valid data.
5. System delivers the processed CEP Details for user access.

#### Invalid data – error course (sad path):
1. System delivers error.

# UI 
## Home Screen
- [✅] Render Title, Input Field and Search Button 
- [✅] Load CEP when Search Button is pressed

## Detail Screen
- [✅]  Render CEP, Street Name, District, City, State
