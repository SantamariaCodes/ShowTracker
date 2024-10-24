# ShowTracker App 📱


ShowTracker is a SwiftUI-based iOS app that enables users to browse, search, and manage TV shows through integration with their TMDB account. It implements genre filtering, detailed show pages, and personalized user profiles with features like Favorites and Account Display.

The app utilizes MVVM architecture to maintain clean, scalable code and asynchronous networking with Moya to fetch real-time data from the TMDB API, ensuring a smooth and responsive user experience. Future enhancements will include local storage for favorites to provide offline access. 


##Features 🚀

- Browse TV Shows: Discover top-rated shows, airing today, or by genre using data from the TMDB API.

- Search Shows: Search for TV shows by name.

- Favorites Management: Planned ability to save favorite shows locally for easy access.

- User Profile: Display user information and session details.

- Authentication: Secure login using token-based authentication.

- Modular Architecture: Organized by feature and core utilities for easy scalability and maintenance.

##Getting Started 🛠️

Prerequisites
Xcode 15+: Ensure Xcode is installed on your machine.
Setup Instructions
Clone the repository:
git clone https://github.com/santamariacodes/ShowTracker.git
cd ShowTracker
Open the project: open ShowTracker.xcodeproj
Build and run the project on an iOS simulator or a physical device.

##Usage 🧑‍💻

- Browse TV Shows: Navigate to the Home tab to discover popular TV shows and explore different genres.

- Search Shows: Use the search bar at the top of the Home tab to find shows by name.

- Display Profile: Visit the Profile tab to View your account and session details.

##Core Technologies 🛠️

- SwiftUI: A modern declarative UI framework for building responsive interfaces across Apple platforms.

- Moya: A network abstraction layer built on top of Alamofire, simplifying API requests.

- KeychainAccess: A library for secure storage of sensitive data such as user session tokens.

- UserDefaults: A lightweight storage system for non-sensitive user preferences and settings.

##Authentication Flow 🔑

- Request Token: Fetch a request token from the TMDB API.

- Create Session: After the user logs in, the request token is exchanged for a session ID.

- Keychain Storage: The session ID is securely stored using KeychainAccess for subsequent requests.

##Planned Improvements 📋

- Guest Login: Implement guest login with locally stored favorite shows.

- Favorites List Navigation: Add navigation to a dedicated favorites screen.

- Unified Object Models: Consolidate TvShowDetailView, ShowDetailView, and ShowDetailRowView.

- Local Save Functionality: Add local storage to enable saving shows to favorites.

- Review Architecture: Evaluate if Favorites should share the same target from UserAccountViewModel.

- Refactor Detail Views: Ensure GridDisplayView uses the most up-to-date TvShowDetailView.

- Dark Mode Support: Implement full dark mode for a better user experience.

##Contact 📬

Created by Diego Santamaria.

GitHub: santamariacodes
Website: santamariacodes

##Issues 🐛

If you encounter any issues, please open an issue on the GitHub repository.
