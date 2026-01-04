# 🏡 Luxeyline - Real Estate Mobile Application

A modern, feature-rich **Real Estate Mobile Application** built with **Flutter**, designed to provide users with an intuitive and seamless experience for discovering, browsing, and managing property listings.

[![Flutter](https://img.shields.io/badge/Flutter-3.0+-02569B?style=flat&logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?style=flat&logo=dart)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

---

## 📱 About The Project

**Luxeyline** is a comprehensive real estate application that connects property seekers with their dream homes. The app features user authentication, property browsing, favorites management, API integration, and a rich settings experience—all packaged in a clean and responsive UI.

### ✨ Key Highlights

- 🔐 **Secure Authentication** - User registration and login with real API integration
- 🏠 **Property Discovery** - Browse residential and commercial properties with detailed information
- ❤️ **Favorites Management** - Save and manage favorite properties with local storage persistence
- 🔍 **Smart Search** - Filter properties by name, location, and price range
- 🌐 **API Integration** - RESTful API integration for authentication and data fetching
- 📱 **Responsive Design** - Works seamlessly on Android, iOS, and Web
- 🔔 **Push Notifications** - Configurable notification settings with test alerts
- ⚙️ **Rich Settings** - Comprehensive settings menu with 10+ options
- 💾 **Local Storage** - Persistent data storage using SharedPreferences

---

## 🎯 Features

### 🔐 Authentication
- User registration with email and password
- Secure login system with JWT token management
- Password reset functionality
- Form validation and error handling
- Persistent authentication state

### 🏘️ Property Management
- **Browse Properties**: View a curated list of residential and commercial properties
- **Property Details**: High-quality images, descriptions, prices, and amenities
- **Search & Filter**: Find properties by name, location, or price range
- **Favorites**: Save favorite properties with local storage persistence
- **Navigation**: Seamless navigation between home, detail, and other screens

### 🌐 API Integration
- RESTful API integration with `http://72.61.229.146:8080`
- Authentication endpoints (signup, login, password reset)
- Health check endpoint for API status monitoring
- Error handling and network timeout management
- JWT token management with Dio interceptors

### ⚙️ Settings & Preferences
- **Account Settings**: Profile, Privacy, Security
- **Preferences**: Notifications toggle, Dark mode, Language selection
- **Support**: Help & Support, About, Terms & Conditions
- **Sign Out**: Secure logout with confirmation dialog
- Local storage persistence for all settings

### 🔔 Notifications
- Configurable notification preferences (4 toggle options)
- Test notification functionality with rich UI
- Alert dialog implementation with property details
- Notification badge and status indicators

---

## 🛠️ Tech Stack

### Frontend
- **Framework**: Flutter 3.0+
- **Language**: Dart 3.0+
- **UI Components**: Material Design
- **Responsive Design**: flutter_screenutil
- **Fonts**: Google Fonts (Manrope)

### Backend & APIs
- **HTTP Client**: Dio 5.9.0
- **API Base URL**: `http://72.61.229.146:8080`
- **Authentication**: JWT Token-based

### Data Management
- **Local Storage**: SharedPreferences 2.5.3
- **State Management**: StatefulWidget (built-in)
- **Caching**: cached_network_image 3.4.1

### Additional Packages
- `intl_phone_field` - International phone number input (Indonesia +62)
- `provider` - State management utilities
- `lottie` - Animation support
- `hive_flutter` - Lightweight and fast local database
- `connectivity_plus` - Network connectivity monitoring

---

## 📁 Project Structure

```
capstone-MAD/
├── lib/
│   ├── main.dart                    # Application entry point
│   ├── errors/
│   │   └── exceptions.dart          # Custom exception handlers
│   ├── models/
│   │   └── property.dart            # Property data model
│   ├── network/
│   │   ├── api_service.dart         # API service implementation
│   │   ├── connection.dart          # Network connectivity
│   │   └── network_client.dart      # Dio HTTP client configuration
│   ├── pages/
│   │   ├── signup/                  # User registration screen
│   │   ├── login/                   # User login screen
│   │   ├── home/                    # Property listing home screen
│   │   ├── details/                 # Property detail screen
│   │   ├── settings/                # Settings and preferences
│   │   ├── notifications/           # Notification configuration
│   │   └── api/                     # API integration demo
│   └── utils/
│       ├── constants.dart           # App-wide constants and colors
│       ├── network_constants.dart   # API endpoints
│       ├── routes.dart              # App routing configuration
│       └── shared_preferences.dart  # Local storage utilities
├── assets/
│   ├── images/                      # Property images
│   ├── svgs/                        # SVG icons
│   └── lotties/                     # Lottie animations
├── android/                         # Android-specific files
├── ios/                             # iOS-specific files
├── web/                             # Web-specific files
├── USER_STORIES.md                  # 9 complete user stories
├── pubspec.yaml                     # Project dependencies
└── README.md                        # Project documentation
```

---

## 🚀 Getting Started

### Prerequisites

Before running this application, ensure you have:

- **Flutter SDK** (3.0 or higher) - [Install Flutter](https://flutter.dev/docs/get-started/install)
- **Dart SDK** (3.0 or higher)
- **Android Studio** / **Xcode** (for mobile development)
- **VS Code** or **Android Studio** with Flutter extensions
- **Git** for version control

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/[YOUR-USERNAME]/capstone-mad-realestate.git
   cd capstone-mad-realestate
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Verify Flutter setup**
   ```bash
   flutter doctor
   ```

4. **Check for issues**
   ```bash
   flutter analyze
   ```

### Running the Application

#### 🌐 **Web**
```bash
flutter run -d chrome
```

#### 📱 **Android Emulator**
```bash
flutter run -d android
```

#### 🍎 **iOS Simulator** (macOS only)
```bash
flutter run -d ios
```

#### 🖥️ **Windows Desktop**
```bash
flutter run -d windows
```

### Building for Production

#### Android APK
```bash
flutter build apk --release
```

#### Android App Bundle
```bash
flutter build appbundle --release
```

#### iOS
```bash
flutter build ios --release
```

#### Web
```bash
flutter build web --release
```

---

## 🔌 API Endpoints

Base URL: `http://72.61.229.146:8080`

### Authentication Endpoints

| Method | Endpoint | Description | Request Body |
|--------|----------|-------------|--------------|
| POST | `/api/auth/signup` | Register new user | `{ "email": "string", "password": "string" }` |
| POST | `/api/auth/login` | Login user | `{ "email": "string", "password": "string" }` |
| POST | `/api/auth/reset-password-request` | Request password reset | `{ "email": "string" }` |
| POST | `/api/auth/reset-password` | Reset password | `{ "token": "string", "newPassword": "string" }` |
| GET | `/api/health` | Check API health status | - |

### Response Examples

**Login Response:**
```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "tokenType": "Bearer"
}
```

**Health Check Response:**
```json
{
  "status": "UP",
  "timestamp": "2026-01-04T15:51:46.407878080Z",
  "uptimeMs": 2842671349
}
```

---

## 👤 User Stories

This project implements **9 comprehensive user stories**:

1. **User Registration** - As a new user, I want to create an account
2. **User Login** - As a registered user, I want to login to access the app
3. **View Properties** - As a user, I want to browse available properties
4. **View Property Details** - As a user, I want to see detailed information about properties
5. **Manage Favorites** - As a user, I want to save and manage my favorite properties
6. **Search Properties** - As a user, I want to search and filter properties
7. **Configure Settings** - As a user, I want to customize app settings
8. **Manage Notifications** - As a user, I want to control notification preferences
9. **API Integration** - As a developer, I want the app to integrate with backend APIs

📄 **Full user stories available in:** [USER_STORIES.md](USER_STORIES.md)

---

## 📸 Screenshots

> **Note**: Screenshots are available for submission and can be found in the project documentation folder.

Screenshots include:
- Signup screen with validation
- Login screen with error handling
- Home screen with logo and property listings
- Property detail screen
- Settings menu and screens
- Notifications configuration
- API integration demo
- Local storage persistence demo

---

## 🧪 Testing

### Run Tests
```bash
flutter test
```

### Test Credentials

For testing the application, use the following credentials:

**Test Account:**
- Email: `user@example.com`
- Password: `password123`

Or create a new account via the signup screen.

---

## 🔧 Configuration

### Network Configuration

Update API base URL in `lib/utils/network_constants.dart`:

```dart
class NetworkConstants {
  static const baseUrlDev = "http://72.61.229.146:8080";
}
```

### Theme Configuration

Customize app colors in `lib/utils/constants.dart`:

```dart
class AppColorsLight {
  static const primary = Color(0xFF6C63FF);
  static const accent = Color(0xFF4CAF50);
  // ... more colors
}
```

---

## 📦 Dependencies

### Core Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  dio: ^5.9.0                           # HTTP client
  shared_preferences: ^2.5.3            # Local storage
  flutter_screenutil: ^5.9.3            # Responsive design
  google_fonts: ^6.3.2                  # Custom fonts
  intl_phone_field: ^3.2.0             # Phone input
  provider: ^6.1.5                      # State management
  cached_network_image: ^3.4.1         # Image caching
  lottie: ^3.3.1                        # Animations
  hive_flutter: ^1.1.0                 # Local database
  connectivity_plus: ^6.1.2            # Network monitoring
```

### Dev Dependencies
```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
  build_runner: ^2.4.13
  hive_generator: ^2.0.1
```

---

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 👨‍💻 Author

**Your Name**
- GitHub: [@yourusername](https://github.com/yourusername)
- Email: your.email@example.com

---

## 🙏 Acknowledgments

- [Flutter](https://flutter.dev) - The UI framework
- [Dio](https://pub.dev/packages/dio) - HTTP client for Dart
- [Google Fonts](https://fonts.google.com) - Typography
- Backend API provided by course infrastructure
- Coursera Mobile Application Development Course

---

## 📞 Support

For support and questions:
- Create an issue in this repository
- Email: your.email@example.com

---

## 🎓 Academic Project

This application was developed as a capstone project for the **Mobile Application Development** course.

**Project Requirements Met:**
- ✅ User Authentication (Signup & Login)
- ✅ Home Screen with Logo
- ✅ Detail Screen Navigation
- ✅ Local Storage Implementation
- ✅ External API Integration
- ✅ Settings Menu (10+ items)
- ✅ Notifications Configuration
- ✅ 9 Complete User Stories
- ✅ Responsive UI Design

---

<div align="center">

**Built with ❤️ using Flutter**

⭐ Star this repository if you found it helpful!

</div>
