# 📱 Aisle iOS (UIKit)

A minimal, scalable, and reusable authentication flow built using UIKit in Swift. This is part of a redesigned prototype for the Aisle app, focused on clean architecture, smooth onboarding, and robust validation.

---

## 🚀 Features

- 📞 Phone number input with validation  
- 🌐 Country code selection using `UIMenu`  
- 🔐 OTP flow with navigation and ViewModel binding  
- ❌ Error handling via alerts  
- 🧪 Lightweight MVVM structure for testability  
- ✅ Dynamic UI state (button enabled/disabled based on input)  

---

## 🧱 Architecture

- **UIKit-based UI** using `UIViewController` and custom views  
- **MVVM pattern** with `AuthViewModel` for handling network requests and validation logic  
- **Reusable input views** using `InputView` with enum-based configuration  
- **Network layer** built using `URLSession`  
- **Codable models** for parsing JSON responses  
- **Protocols** for component communication  

---

## 📂 Folder Structure

Aisle/
│
├── Controllers/
│ ├── PhoneNumberViewController.swift
│ └── OtpViewController.swift
│
├── Views/
│ ├── InputView.swift
│ └── InputViewType.swift
│
├── ViewModel/
│ └── AuthViewModel.swift
│
├── Models/
│ └── AuthResponse.swift
│
├── Resources/
│ └── Assets.xcassets (colors, icons)
│
└── Utilities/
└── Extensions, Validators, Constants


---

## 📱 Screens

| Phone Input Screen | Country Code Menu | OTP Screen |
|--------------------|-------------------|------------|
| ✅ Validations     | 🌐 +91 🇮🇳         | 🔐 Secure  |

---

## ⚙️ Setup Instructions

1. Clone the repo:
   ```bash
   git clone https://github.com/yourname/aisle-auth-flow.git
   cd aisle-auth-flow
Open in Xcode:

arduino
Copy
Edit
open Aisle.xcodeproj
Run the app on a simulator or real device (iOS 15+).

🔧 API Integration
POST /phone_number_login – accepts phone number and returns an authentication token

POST /verify_otp – accepts OTP and token to complete login

These are mocked or plugged into your real API depending on your backend.

🛡 Validation Logic
Phone number must be 10 digits (India-specific currently)

Country code is selected via UIMenu dropdown

OTP screen is shown only on successful token response

📌 Future Enhancements

🌍 Auto-detect country code based on locale

📬 OTP autofill using iOS SMS parser

🔒 Keychain storage for auth token

📲 Combine version for reactive bindings

## 🧑‍💻 Author

Purnasindhu Bachu

iOS Developer | Swift | UIKit | MVVM

GitHub Profile

## 📄 License
This project is licensed under the MIT License. Feel free to use and adapt it in your own apps.

yaml
Copy
Edit

---

Let me know if you'd like me to:

- Add a badge (e.g., iOS version, build status)
- Include screenshots or GIFs of UI
- Write a section for Combine/SwiftUI conversion later

I'll also tailor it if you're publishing this as a library or demo app.
