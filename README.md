<p align="center">
  <img src="gir_yatra_icon.png" width="130" alt="Gir Yatra Logo" />
</p>

<h1 align="center">🦁 Gir Yatra</h1>

<p align="center">
  <strong>The Definitive Tourism Companion for Sasan Gir & Saurashtra, Gujarat</strong><br/>
  <em>Plan your Gir Forest safari, book stays, explore hidden gems, and handle emergencies — beautifully.</em>
</p>

<p align="center">
  <a href="#-quick-start">📲 Get Started</a> · <a href="#-features">✨ Features</a> · <a href="#-project-architecture">🗂 Architecture</a> · <a href="#-store-listing-copy">📝 Store Listings</a> · <a href="#-contributing">🤝 Contributing</a>
</p>

<br/>

```
 ██████╗ ██╗██████╗      ██╗   ██╗ █████╗ ████████╗██████╗  █████╗
██╔════╝ ██║██╔══██╗     ╚██╗ ██╔╝██╔══██╗╚══██╔══╝██╔══██╗██╔══██╗
██║  ███╗██║██████╔╝      ╚████╔╝ ███████║   ██║   ██████╔╝███████║
██║   ██║██║██╔══██╗       ╚██╔╝  ██╔══██║   ██║   ██╔══██╗██╔══██║
╚██████╔╝██║██║  ██║        ██║   ██║  ██║   ██║   ██║  ██║██║  ██║
 ╚═════╝ ╚═╝╚═╝  ╚═╝        ╚═╝   ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝
```

---

## 📖 Table of Contents

- [About the App](#-about-the-app)
- [What's New in v4](#-whats-new-in-v4)
- [Features](#-features)
- [Project Architecture](#-project-architecture)
- [Tech Stack](#-tech-stack)
- [Quick Start](#-quick-start)
- [Screen Gallery](#-screen-gallery)
- [Data Design](#-data-design)
- [State Management](#-state-management)
- [Store Listing Copy](#-store-listing-copy)
- [Contributing](#-contributing)
- [License](#-license)

---

## 🌿 About the App

**Gir Yatra** is a feature-rich Flutter travel guide for the **Sasan Gir Wildlife Sanctuary** — home to the last surviving Asiatic lions on Earth. Designed for real travellers venturing into Gujarat's jungle heartland, the app delivers a premium offline-first experience backed by **Firebase Authentication** and **Cloud Firestore** for user accounts and profile management, while maintaining a massive local dataset of **2,095 lines of curated tourism data** — making the core experience blazing fast with or without connectivity.

| Stat               | Value                                |
| :----------------- | :----------------------------------- |
| Lines of Dart      | **12,900+**                          |
| Dart Source Files  | **27**                               |
| Screens            | **16**                               |
| Reusable Widgets   | **3**                                |
| Curated Data Lines | **2,095** (static_data + extra_data) |
| Backend            | Firebase Auth + Cloud Firestore      |
| Platforms          | Android · Web (iOS-ready)            |
| Min SDK            | Flutter ≥ 3.x · Dart ≥ 3.0           |
| Locale             | en_IN                                |

---

## 🆕 What's New in v4

| #   | Module                         | What Changed                                                                        |
| :-- | :----------------------------- | :---------------------------------------------------------------------------------- |
| 1   | 🔐 **Firebase Auth**           | Full email/password sign-up, login, and password reset via Firebase Authentication  |
| 2   | 👤 **User Profiles**           | Firestore-backed profiles with real-time sync — name, phone, city, last login       |
| 3   | 🗄️ **Cloud Firestore**         | Live Firestore collection browser + one-shot data seeding service                   |
| 4   | 🎨 **Light-Only Theme**        | Dark mode permanently removed — clean forest-green + amber Material 3 palette       |
| 5   | 🆘 **Emergency Screen**        | 9 emergency contacts · 4 expandable first-aid protocol cards                        |
| 6   | 🚌 **Transport Screen**        | 5 travel modes · real distances · fare estimates · insider local tips               |
| 7   | ✅ **Packing Checklist**       | 6 category groups · 45 individual items · essential-item flags · live progress bar  |
| 8   | 📅 **Seasonal Calendar**       | Full 12-month guide — wildlife activity, special events, crowd level, forest status |
| 9   | 🔍 **Universal Search**        | Real-time full-text search spanning places, hotels, food, rules, and tips           |
| 10  | 🗺️ **Drawer Navigation**       | Slide-out drawer with 11 sections across 3 groups (Main · Travel · Support)         |
| 11  | 📊 **Forest Status Card**      | Live month indicator widget baked into the home dashboard                           |
| 12  | 🦁 **Wildlife Facts Carousel** | Horizontal swipeable lion & wildlife fact cards on the dashboard                    |
| 13  | 💾 **Global State**            | InheritedNotifier — favorites, checklist, language — zero external state packages   |
| 14  | 🏨 **21 Hotels & Resorts**     | Expanded curated listings with filter-by-type and sort-by-rating/price              |
| 15  | 📍 **10 Attractions**          | Nearby destinations with imagery, distance, ratings, and descriptions               |

---

## ✨ Features

### 🏠 Home Dashboard

- Animated lion splash screen with SVG logo and multi-controller animations
- Live **Forest Status** indicator (open / closed / restricted by month)
- Swipeable **Wildlife Facts** carousel with curated Asiatic lion trivia
- 5-tab bottom navigation (Home · Explore · Itinerary · Checklist · Profile)
- Full slide-out **Drawer** with 11 sections across 3 groups
- Glassmorphism-style collapsible AppBar

### 🔐 Authentication & Profiles

- Firebase email/password **sign-up and login** with form validation
- **Password reset** via email
- Firestore-backed **user profile** — name, email, phone, city
- Real-time profile updates with `StreamBuilder` on Firestore snapshots
- Auto-tracked `createdAt`, `lastLoginAt`, and `provider` fields
- **Firestore Data Browser** — live collection viewer for debugging

### 🦁 Safari Information

- Session timings (morning & evening, summer & winter schedules)
- All **5 official safari zones** (East, West & Devalia) with entry points and highlights
- Complete **entry-fee breakdown** for Indian & foreign nationals, vehicle categories
- Step-by-step **booking process** guide linked to `girlion.gujarat.gov.in`
- Comprehensive **Safari Rules** — do's & don'ts inside the sanctuary

### 🏨 Stay & Accommodation

- **21 curated hotel and resort listings** around Sasan Gir
- Filterable by accommodation type (resort, hotel, eco-lodge, homestay, farmhouse)
- Sortable by **rating** or **price**
- Per-property details: amenities, phone, website, pricing, and booking tips
- One-tap **call** and **website launch** via `url_launcher`

### 🍛 Food & Culture

- Tabbed view: **local Kathiawadi cuisine** highlights + **cultural traditions**
- Must-try dish cards with descriptions and icons
- Regional cultural traditions and dining etiquette

### 📍 Nearby Attractions

- **10 handpicked destinations** — Somnath Temple, Girnar Hills, Junagadh, Diu Fort, Jamjir Waterfall, Tulshi Shyam, Kankai Mata, Devaliya Safari Park, Veraval Beach, and more
- Full detail view per location: distance, ratings, descriptions, and curated imagery
- Filterable by type and sortable by distance or rating

### 🗓️ Smart Itinerary

- Pre-built **1-Day and 2-Day** travel plans in visual timeline format
- Hour-by-hour schedule with activity descriptions
- Designed so tourists can hit the ground running without hours of planning

### 📅 Seasonal Calendar

- **12-month breakdown** covering wildlife activity levels, weather, park status
- Local festivals and events flagged for each month
- Crowd density indicators for choosing the perfect travel window

### 🚌 Transport & How to Reach

- **5 travel modes**: air, train, bus, car, and local taxi
- Distances, durations, fare estimates, station names, and frequency info
- Practical **insider tips** for navigating the last mile into the forest

### ✅ Packing Checklist

- **45 items** across **6 categories** (Essentials, Clothing, Safari Gear, Toiletries, Food & Water, Electronics)
- **Essential-item badges** for must-have items
- Live **progress bar** tracking checked vs. total items
- Check-all / clear-all controls
- Persisted across screens via global InheritedNotifier state

### 🆘 Emergency & Safety

- **9 quick-dial emergency contacts** (Forest Dept, Police, Hospital, Ambulance, Fire)
- One-tap **call and SMS** via `url_launcher`
- **4 first-aid protocol cards** — snake bite, heat stroke, animal encounter, insect bite
- Expandable step-by-step instructions for each scenario

### 🔍 Universal Search

- Instant **full-text search** across all app content
- Covers: places, hotels, food, safari rules, emergency tips, and packing items
- Results grouped by category with deep-link navigation to relevant screens

---

## 🗂 Project Architecture

```
gir_yatra_v_4/
│
├── lib/
│   ├── main.dart                        # App entry point · Firebase init · SystemChrome
│   │
│   ├── data/
│   │   ├── static_data.dart             # Safari, hotels, places, food, culture (1,286 lines)
│   │   └── extra_data.dart              # Transport, emergency, checklist, seasonal (809 lines)
│   │
│   ├── screens/
│   │   ├── splash_screen.dart           # Multi-controller animated lion splash (462 lines)
│   │   ├── auth_screen.dart             # Login / Register UI with forest-green theme (577 lines)
│   │   ├── login_screen.dart            # Firebase Auth logic — sign-in / sign-up (255 lines)
│   │   ├── home_screen.dart             # Dashboard + Drawer + BottomNav + Profile (1,594 lines)
│   │   ├── safari_screen.dart           # Timings, zones, fees, rules, booking (671 lines)
│   │   ├── stay_screen.dart             # 21 hotels with filter & sort (645 lines)
│   │   ├── food_culture_screen.dart     # Tabbed food + culture guide (694 lines)
│   │   ├── nearby_places_screen.dart    # 10 attractions with filter & sort (732 lines)
│   │   ├── itinerary_screen.dart        # 1-Day & 2-Day visual timeline (519 lines)
│   │   ├── seasonal_screen.dart         # 12-month seasonal calendar (390 lines)
│   │   ├── transport_screen.dart        # How to reach — 5 modes (440 lines)
│   │   ├── checklist_screen.dart        # 45-item packing checklist + progress (334 lines)
│   │   ├── emergency_screen.dart        # 9 contacts + 4 first-aid cards (637 lines)
│   │   ├── search_screen.dart           # Universal full-text search (502 lines)
│   │   ├── profile_screen.dart          # Firestore-backed user profile (654 lines)
│   │   └── firebase_data_screen.dart    # Live Firestore collection browser (246 lines)
│   │
│   ├── services/
│   │   ├── auth_service.dart            # Firebase Auth + Firestore user CRUD (85 lines)
│   │   └── seed_service.dart            # One-shot Firestore data seeder (330 lines)
│   │
│   ├── state/
│   │   └── app_state.dart               # InheritedNotifier — favorites, checklist, lang (110 lines)
│   │
│   ├── theme/
│   │   └── app_theme.dart               # Forest-green + amber Material 3 theme (172 lines)
│   │
│   ├── widgets/
│   │   ├── custom_card.dart             # Reusable card components (277 lines)
│   │   ├── filter_bar.dart              # Horizontal filter chips + sort dropdown (203 lines)
│   │   └── contact_actions.dart         # One-tap call / SMS / website buttons (157 lines)
│   │
│   └── firebase_options.dart            # FlutterFire auto-generated config (68 lines)
│
├── Image/                               # 10 curated destination photographs
├── android/                             # Android platform config + google-services.json
├── web/                                 # Web platform config
├── pubspec.yaml                         # Dependencies & asset declarations
└── README.md                            # You are here
```

---

## 🛠 Tech Stack

| Layer            | Technology                                    |
| :--------------- | :-------------------------------------------- |
| Framework        | Flutter 3.x (Material 3)                      |
| Language         | Dart 3.x (null-safe)                          |
| Authentication   | Firebase Auth (email/password)                |
| Database         | Cloud Firestore (real-time sync)              |
| State Management | InheritedNotifier — zero external packages    |
| URL Actions      | `url_launcher` (call, SMS, website)           |
| SVG Rendering    | `flutter_svg`                                 |
| Splash           | `flutter_native_splash` (custom branded)      |
| App Icon         | `flutter_launcher_icons` (adaptive icon)      |
| Theme            | Material 3 — Light-only, forest-green palette |
| Orientation      | Portrait-locked                               |
| Locale           | en_IN                                         |
| CI/CD            | Flutter CLI (`flutter build apk` / `ipa`)     |

---

## ⚡ Quick Start

```bash
# 1. Clone or download the project
git clone https://github.com/your-username/gir-yatra.git
cd gir-yatra

# 2. Install dependencies
flutter pub get

# 3. Configure Firebase (required)
dart pub global activate flutterfire_cli
flutterfire configure
# → Place google-services.json in android/app/

# 4. Generate launcher icons & splash screen
dart run flutter_launcher_icons
dart run flutter_native_splash:create

# 5. Run on a connected device or emulator
flutter run

# 6. Build a release APK
flutter build apk --release

# 7. Build for iOS (macOS required)
flutter build ipa --release
```

### Firebase Setup

1. Create a new project in the [Firebase Console](https://console.firebase.google.com/)
2. Enable **Email/Password** under Authentication → Sign-in method
3. Create a **Cloud Firestore** database in production or test mode
4. Run `flutterfire configure` to generate `firebase_options.dart`
5. Place `google-services.json` in `android/app/`
6. _(Optional)_ Use the in-app **Seed Service** to push all static data into Firestore

**Requirements:** Flutter ≥ 3.0 · Dart ≥ 3.0 · Android SDK 21+ or iOS 12+

---

## 🖼 Screen Gallery

| Screen                 | Description                                                          |
| :--------------------- | :------------------------------------------------------------------- |
| **SplashScreen**       | Multi-controller animated lion entrance with SVG logo and ring pulse |
| **AuthScreen**         | Forest-themed login / register with form validation                  |
| **HomeScreen**         | Dashboard with forest status card + wildlife facts carousel          |
| **SafariScreen**       | Timings, 5 zones, fee tables, booking steps, rules                   |
| **StayScreen**         | 21 filterable hotels with sort-by-rating and sort-by-price           |
| **FoodCultureScreen**  | Tabbed Kathiawadi food & cultural traditions guide                   |
| **NearbyPlacesScreen** | 10 day-trip destinations with filter, sort, and imagery              |
| **ItineraryScreen**    | 1-Day & 2-Day visual timeline plans                                  |
| **SeasonalScreen**     | Month-by-month wildlife, weather, crowd, and event guide             |
| **TransportScreen**    | 5 travel modes with distances, fares, and tips                       |
| **ChecklistScreen**    | 45-item smart packing checklist with progress bar                    |
| **EmergencyScreen**    | 9 quick-dial contacts + 4 first-aid protocol cards                   |
| **SearchScreen**       | Universal real-time full-text search                                 |
| **ProfileScreen**      | Firestore-backed editable user profile                               |
| **FirebaseDataScreen** | Live Firestore collection and document browser                       |

> 📸 _Screenshots coming soon — run the app to experience the full UI._

---

## 📦 Data Design

All core tourism content is stored as **typed Dart constants and model classes** in two dedicated files — making the core experience available instantly without any I/O, network, or JSON parsing.

```dart
// Example from static_data.dart
class SafariZone {
  final String name;
  final String code;
  final String description;
  final String entryPoint;
  final String highlight;
  final IconData icon;
  final Color color;

  const SafariZone({ ... });
}
```

| Data File          | Lines | Content                                                                                                          |
| :----------------- | :---- | :--------------------------------------------------------------------------------------------------------------- |
| `static_data.dart` | 1,286 | Safari timings · 5 zones · fee tables · 21 hotels · 10 attractions · food · culture                              |
| `extra_data.dart`  | 809   | 5 transport modes · 9 emergency contacts · 45 checklist items · 12-month seasonal calendar · first-aid protocols |

### Why Dart Constants?

- **Zero cold-start latency** — no file I/O or network before first frame
- **Offline-first by design** — no cached API calls to expire
- **AOT-compiled** — Dart tree-shakes unused constants at build time
- **Type-safe** — compile-time guarantees on every data field

### Data Sources

| Data                        | Source                                                                                   |
| :-------------------------- | :--------------------------------------------------------------------------------------- |
| Safari timings, zones, fees | [girlion.gujarat.gov.in](https://girlion.gujarat.gov.in/) (Official Gujarat Govt Portal) |
| Hotels & resorts            | TripAdvisor India — Sasan Gir listings                                                   |
| Attractions & temples       | TripAdvisor + verified government tourism sources                                        |
| Emergency contacts          | Official district emergency directory                                                    |
| Transport routes & fares    | Verified as of 2025–2026 season                                                          |

---

## 🧠 State Management

Gir Yatra uses Flutter's built-in **InheritedNotifier** pattern — no `provider`, `riverpod`, `bloc`, or `get` required.

```
GirYatraApp
  └── AppStateProvider (InheritedNotifier)
        └── AppStateNotifier (ChangeNotifier)
              ├── AppStateData.favoritePlaceIds   → Set<String>
              ├── AppStateData.favoriteHotelNames  → Set<String>
              ├── AppStateData.checkedItems        → Set<int>
              └── AppStateData.language             → String ('en' | 'gu')
```

Any widget down the tree accesses state with:

```dart
final state = AppStateProvider.of(context);
```

Changes propagate automatically and efficiently — only widgets that call `of(context)` rebuild. Firebase handles user-level persistence (auth + profile), while in-memory state covers session-scoped interactions (favorites, checklist progress).

---

## 📝 Store Listing Copy

### Short Description _(80 characters)_

```
Gir forest guide: safari, stays, food, seasonal tips & emergency help 🦁
```

### Full Application Description _(≤ 4,000 characters)_

```
Gir Yatra is the ultimate travel companion for Sasan Gir Wildlife
Sanctuary — home to the last wild Asiatic lions on Earth. Whether you're
a first-time wildlife enthusiast or a seasoned jungle traveller, Gir Yatra
puts everything you need right in your pocket.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🦁 SAFARI MADE SIMPLE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Browse safari session timings, entry fee breakdowns for Indian and foreign
visitors, step-by-step online booking guidance, and a full list of forest
rules — all in one place. Know exactly when to go, what to pay, and how to
behave inside the sanctuary.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🏨 STAYS, FOOD & NEARBY ATTRACTIONS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Filter 21 curated hotels and resorts by type and price. Discover local
Kathiawadi cuisine highlights and cultural traditions. Explore 10 curated
day-trip destinations near the sanctuary with ratings and travel info.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📅 PLAN AHEAD WITH SEASONAL & ITINERARY GUIDES
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
The 12-month seasonal calendar shows wildlife activity levels, forest
open/closed status, crowd density, and special events for every month of
the year — so you can pick the perfect travel window. Ready-made 1-Day and
2-Day itineraries give you a complete hour-by-hour plan the moment you land.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ SMART PACKING CHECKLIST
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
45 packing items across 6 categories — clothing, gear, documents, medicine,
food, and miscellaneous. Essential items are flagged so nothing critical
gets left behind. A live progress bar shows how packed you really are.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🆘 EMERGENCY HELP — ALWAYS READY
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
9 emergency contacts including forest department, hospitals, and police.
4 first-aid protocol cards — snake bite, heat stroke, animal encounter,
and insect bite — with step-by-step expandable instructions.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚌 HOW TO REACH
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Get directions via air, train, bus, car, and local taxi. Distances to key
transport hubs with fare estimates and insider tips for navigating the
last mile into the forest.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🔐 SECURE ACCOUNTS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Create your profile with Firebase-powered authentication. Your preferences
and profile stay synced across sessions with real-time Cloud Firestore.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🔍 SEARCH EVERYTHING
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
One search bar to find anything — places, hotels, food, rules, emergency
tips, packing items. Results appear instantly and link directly to the
relevant screen.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🎨 BEAUTIFUL DESIGN
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Built on Material 3 with a nature-inspired colour palette — deep forest
greens, warm amber, and soft beige. Glassmorphism app bar, smooth
animations, and a polished user experience throughout.

No ads. Just Gir, beautifully at your fingertips.
```

### App Features _(store feature bullets)_

```
• Safari timings, 5 zones, entry fees, booking guide & forest rules
• 21 curated hotels & resorts — filter by type, sort by rating/price
• 10 nearby attractions with ratings, distance & imagery
• 12-month seasonal calendar — wildlife, weather, events & crowd levels
• Pre-built 1-Day and 2-Day itinerary timeline plans
• Local Kathiawadi food guide + cultural highlights
• Smart packing checklist — 45 items, 6 categories, live progress bar
• 9 emergency contacts + 4 first-aid protocol cards with steps
• Transport guide — air, train, bus, car & local taxi with fares
• Universal real-time search across all app content
• Firebase Auth — sign up, login, password reset
• Cloud Firestore — real-time synced user profiles
• Material 3 design — glassmorphism, smooth animations, nature palette
• Animated lion splash screen with SVG logo
```

---

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. **Fork** the repo and create a feature branch: `git checkout -b feat/your-feature`
2. Keep all content in `lib/data/` as typed Dart constants — no JSON files
3. New pub packages require a strong justification in the PR description
4. Run `flutter analyze` and `flutter test` before submitting
5. Open a **Pull Request** with a clear description of what changed and why

---

## 📄 License

**MIT License** — Copyright © 2026 Gir Yatra Contributors

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software to use, copy, modify, merge, publish, distribute, sublicense,
and/or sell copies of the Software, subject to the conditions of the MIT License.

---

<p align="center">
  Made with 💚 for the lions of Gir · Gujarat, India 🇮🇳
</p>

<p align="center">
  <a href="#-table-of-contents">⬆ Back to Top</a>
</p>
