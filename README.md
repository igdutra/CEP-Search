# CEP Search
Basic App to help you find more information about a specific CEP

[![CI-iOS](https://github.com/igdutra/CEPSearch/actions/workflows/CI-iOS.yml/badge.svg)](https://github.com/igdutra/CEPSearch/actions/workflows/CI-iOS.yml)
[![CI-macOS](https://github.com/igdutra/CEPSearch/actions/workflows/CI-macOS.yml/badge.svg)](https://github.com/igdutra/CEPSearch/actions/workflows/CI-macOS.yml)

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
- [ ] Load CEP when Search Button is pressed

## Detail Screen
- [✅]  Render CEP, Street Name, District, City, State
