# 🎬 ShowTracker

A sleek SwiftUI app to browse, search, and view your favorite TV shows using The Movie Database (TMDB) API. Built with a clean MVVM architecture, real-time search, carousel UI, and dual authentication support via Firebase and TMDB.

---

## ✨ Features

- 🔍 Browse top-rated, popular, and currently airing TV shows via TMDB API
- 🎯 Search functionality with real-time filtering
- 🎞️ Interactive carousel for featured content
- 🗂 Horizontal genre picker with subgenre breakdown
- ✅ Dual authentication: Firebase and TMDB login
- 💾 View saved favorites with TMDB login *(read-only)*
- 🔐 Save and remove favorites using Firebase authentication
- 🧪 MVVM architecture with Moya-based network abstraction
- 📱 Built entirely with SwiftUI and Combine

---

## 📸 Screenshots

| Dashboard | Detail View |
|-----------|-------------|
| ![](screenshots/dashboard.png) | ![](screenshots/detail.png) |

| Favorites | Search |
|-----------|--------|
| ![](screenshots/favorites.png) | ![](screenshots/search.png) |

| User Profile |
|--------------|
| ![](screenshots/userprofile.png) |

---

## 🧰 Tech Stack

- **Language:** Swift
- **UI Framework:** SwiftUI
- **Architecture:** MVVM
- **Networking:** Moya
- **Backend Services:** Firebase Auth, TMDB API
- **Persistence:** Keychain (for session data), UserDefaults (for local favorites)

---

## 🧱 Architecture Notes

- Views are organized by feature (`TvShows`, `User`, `Auth`, etc.)
- ViewModels handle all filtering, API calls, and data logic
- `TvShowView` is intentionally designed to showcase all major categories by default
- `DashboardRowView` currently receives the main `TvShowViewModel` for simplicity; in a production environment, this would be further modularized
- A reusable `LocalFavoriteService` handles local persistence for Firebase users
- Session management uses `KeychainManager` for TMDB-authenticated users

> ℹ️ **Note:** The TMDB API does not allow third-party apps to modify user favorites. This app supports *viewing* favorites with TMDB, and *adding/removing* favorites when using Firebase login.

---

## 🚀 Getting Started

1. **Clone the repository**

git clone https://github.com/santamariacodes/ShowTracker.git

2. **Open Xcode**
Open ShowTracker.xcodeproj using Xcode 14+.

3. **Configure your API key**
Open Constants.swift and replace the placeholder with your actual TMDB API key:

struct Constants {
    struct API {
        static let baseUrl = "https://api.themoviedb.org/3/"
        static let users = "users/"
        static let apiKey = "YOUR_TMDB_API_KEY" // ← Replace this
    }
}

🙋‍♂️ Author

Built by Diego Santamaria
LinkedIn:"https://linkedin.com/in/diego-santamaria-miguel"


