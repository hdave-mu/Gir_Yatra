<div align="center">

<img src="https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white" />
<img src="https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart&logoColor=white" />
<img src="https://img.shields.io/badge/Platform-Android%20%7C%20iOS-brightgreen?style=for-the-badge" />
<img src="https://img.shields.io/badge/Offline-100%25-orange?style=for-the-badge" />
<img src="https://img.shields.io/badge/Packages-Zero-red?style=for-the-badge" />
<img src="https://img.shields.io/badge/Version-4.0.0-purple?style=for-the-badge" />

<br/><br/>

# 🦁 Gir Yatra

### *The Definitive Offline Tourism Companion for Sasan Gir, Gujarat*

> Plan your Gir Forest safari, stay, commute, and emergency response — all without a single internet connection.

<br/>

[📲 Get Started](#-quick-start) · [✨ Features](#-features) · [🗂 Architecture](#-project-architecture) · [📝 Store Listings](#-store-listing-copy) · [🤝 Contributing](#-contributing)

<br/>

```
 ██████╗ ██╗██████╗      ██╗   ██╗ █████╗ ████████╗██████╗  █████╗
██╔════╝ ██║██╔══██╗     ╚██╗ ██╔╝██╔══██╗╚══██╔══╝██╔══██╗██╔══██╗
██║  ███╗██║██████╔╝      ╚████╔╝ ███████║   ██║   ██████╔╝███████║
██║   ██║██║██╔══██╗       ╚██╔╝  ██╔══██║   ██║   ██╔══██╗██╔══██║
╚██████╔╝██║██║  ██║        ██║   ██║  ██║   ██║   ██║  ██║██║  ██║
 ╚═════╝ ╚═╝╚═╝  ╚═╝        ╚═╝   ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝
```

</div>

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

**Gir Yatra** is a zero-dependency Flutter travel guide for the **Sasan Gir Wildlife Sanctuary** — home to the last surviving Asiatic lions on Earth. Designed for real travellers venturing into Gujarat's jungle heartland, the app works entirely offline so it stays useful even when forest cell coverage disappears.

| Stat | Value |
|------|-------|
| Lines of Dart | **8,327+** |
| Dart Source Files | **19** |
| External Packages | **0** (Flutter SDK only) |
| Connectivity Required | **Never** |
| Platforms | Android · iOS |
| Min SDK | Flutter ≥ 3.x · Dart ≥ 3.0 |
| Locale | `en_IN` |

---

## 🆕 What's New in v4

| # | Module | What Changed |
|---|--------|-------------|
| 1 | 🆘 **Emergency Screen** | 8 emergency contacts · 4 expandable first-aid protocol cards |
| 2 | 🚌 **Transport Screen** | 4 travel modes · 6 transport stations · animated distance bar chart · insider local tips |
| 3 | ✅ **Packing Checklist** | 6 category groups · 44 individual items · essential-item flags · live progress bar |
| 4 | 📅 **Seasonal Calendar** | Full 12-month guide — wildlife activity rating, special events, crowd level, forest status |
| 5 | 🔍 **Universal Search** | Real-time full-text search spanning places, hotels, food, rules, and tips |
| 6 | 🌙 **Dark Mode** | System-aware auto-switch + manual toggle in AppBar / Drawer |
| 7 | 🗺️ **Drawer Navigation** | Slide-out nav with all 13 sections for one-tap access |
| 8 | 📊 **Forest Status Card** | Live month indicator widget baked into the home dashboard |
| 9 | 🦁 **Wildlife Facts Carousel** | Horizontal swipeable lion & wildlife fact cards on the dashboard |
| 10 | 💾 **Global State (InheritedNotifier)** | Favorites · checklist · dark-mode — zero external state packages |

---

## ✨ Features

### 🏠 Home Dashboard
- Animated lion splash screen on first launch
- Live **Forest Status** indicator (open / closed / restricted by month)
- Swipeable **Wildlife Facts** carousel with curated Asiatic lion trivia
- Bottom navigation bar + full slide-out **Drawer** (13 sections)
- Dark / Light mode toggle baked into AppBar

### 🦁 Safari Information
- Session timings (morning & evening slots)
- Complete entry-fee breakdown (Indian / Foreign nationals, vehicle categories)
- Step-by-step **booking process** guide
- Best months to visit with wildlife activity ratings
- Comprehensive **Safari Rules** — do's & don'ts

### 🗺️ Offline Map
- Fully custom-painted `Canvas` map — no Google Maps SDK, no API key required
- Interactive location **pins** with tap-to-reveal detail panels
- Smooth **pinch-to-zoom** gesture support
- Horizontal location list synced with pin selection
- Resets to default view with one tap

### 🏨 Stay & Accommodation
- Curated hotel and resort listings
- Filterable by budget, category, and proximity
- Per-property details: amenities, contact info, and booking tips

### 🍛 Food & Culture
- Tabbed view: local Gujarati cuisine highlights + cultural context
- Must-try dishes, restaurant picks, and dining etiquette

### 📍 Nearby Attractions
- 6 curated day-trip destinations beyond the sanctuary
- Full detail view per location: history, timings, how to reach

### 🗓️ Itinerary Planner
- Pre-built **1-Day** and **2-Day** timeline itineraries
- Hour-by-hour schedule with activity descriptions

### 🆘 Emergency & Safety
- 8 quick-dial emergency contacts (forest department, hospitals, police)
- 4 first-aid protocol cards (snake bite, heat stroke, animal encounter, injury) with expandable step-by-step instructions

### 🚌 Transport & How to Reach
- 4 travel modes covered: road, rail, air, local taxi
- 6 key transport hubs with distances and connectivity details
- Animated distance bar chart for visual comparison
- Local tips for navigating the last mile

### ✅ Packing Checklist
- 44 items across 6 categories (clothing, gear, documents, medicine, food, misc)
- Essential-item badges for must-have items
- Live progress bar tracking checked vs total items
- Persisted across sessions via global state

### 📅 Seasonal Guide
- Month-by-month breakdown for all 12 months
- Wildlife activity level · crowd density · special events · forest open/closed status
- Ideal for choosing the perfect travel window

### 🔍 Universal Search
- Instant full-text search across **all** app content
- Covers: places, hotels, food, safari rules, emergency tips, and packing items
- Results grouped by category with deep-link navigation

---

## 🗂 Project Architecture

```
gir_yatra/
├── lib/
│   ├── main.dart                      # App entry · AppStateProvider boot
│   ├── state/
│   │   └── app_state.dart             # InheritedNotifier — favorites, checklist, theme
│   ├── theme/
│   │   └── app_theme.dart             # Material 3 Light + Dark themes
│   ├── data/
│   │   ├── static_data.dart           # Core content models (877 lines)
│   │   └── extra_data.dart            # Transport, emergency, checklist, seasonal (685 lines)
│   ├── widgets/
│   │   └── custom_card.dart           # Shared reusable widget library
│   └── screens/
│       ├── splash_screen.dart         # Animated lion intro
│       ├── home_screen.dart           # Dashboard + Drawer + BottomNav
│       ├── safari_screen.dart         # Safari timings, fees, rules
│       ├── stay_screen.dart           # Hotel listings (filterable)
│       ├── food_culture_screen.dart   # Food + Culture (tabbed)
│       ├── map_screen.dart            # Custom-painted offline map
│       ├── nearby_places_screen.dart  # 6 attractions + detail view
│       ├── itinerary_screen.dart      # 1-Day & 2-Day timeline
│       ├── emergency_screen.dart      # Contacts + first-aid cards
│       ├── transport_screen.dart      # How to reach + bar chart
│       ├── checklist_screen.dart      # Packing checklist + progress
│       ├── seasonal_screen.dart       # 12-month guide
│       └── search_screen.dart         # Universal full-text search
└── pubspec.yaml
```

---

## 🛠 Tech Stack

| Layer | Technology |
|-------|-----------|
| Framework | Flutter 3.x (Material 3) |
| Language | Dart 3.x (null-safe) |
| State Management | `InheritedNotifier` — zero packages |
| Maps | Custom `Canvas` + `CustomPainter` |
| Persistence | In-memory state (offline-first design) |
| Theme | Material 3 Dynamic theming (Light + Dark) |
| Orientation | Portrait-locked |
| Locale | `en_IN` |
| CI/CD | Flutter CLI (`flutter build apk / ipa`) |
| Dependencies | **Flutter SDK + `cupertino_icons` only** |

---

## ⚡ Quick Start

```bash
# 1. Clone or download the project
git clone https://github.com/your-org/gir_yatra.git
cd gir_yatra

# 2. Get dependencies (only the Flutter SDK itself)
flutter pub get

# 3. Run on a connected device or emulator
flutter run

# 4. Build a release APK
flutter build apk --release

# 5. Build for iOS
flutter build ipa --release
```

> **Requirements:** Flutter ≥ 3.0, Dart ≥ 3.0, Android SDK 21+ or iOS 12+

---

## 🖼 Screen Gallery

| Screen | Description |
|--------|-------------|
| `SplashScreen` | Animated Asiatic lion entrance |
| `HomeScreen` | Dashboard with forest status + wildlife carousel |
| `SafariScreen` | Timings, fees, booking steps, rules |
| `MapScreen` | Interactive custom-painted offline map |
| `StayScreen` | Filterable hotel & resort directory |
| `FoodCultureScreen` | Tabbed Gujarati food & culture guide |
| `NearbyPlacesScreen` | 6 day-trip destinations with detail |
| `ItineraryScreen` | 1-Day & 2-Day visual timeline |
| `EmergencyScreen` | Quick-dial contacts + first-aid protocols |
| `TransportScreen` | How to reach with animated bar chart |
| `ChecklistScreen` | Smart packing checklist with progress |
| `SeasonalScreen` | Month-by-month wildlife & visit guide |
| `SearchScreen` | Universal real-time full-text search |

---

## 📦 Data Design

All content is stored as Dart **constants** and **model classes** — no database, no network, no JSON files to parse at runtime.

```dart
// Example model from static_data.dart
class MapLocation {
  final String name;
  final String category;
  final double relX;  // 0.0–1.0 relative to canvas width
  final double relY;  // 0.0–1.0 relative to canvas height
  final String description;
  final String? timings;
}
```

This approach means:
- **Zero cold-start latency** — no I/O before first frame
- **True offline** — no cached API calls to expire
- **AOT-compiled** — Dart tree-shakes unused constants at build time

---

## 🧠 State Management

Gir Yatra uses Flutter's built-in `InheritedNotifier` pattern — no `provider`, `riverpod`, `bloc`, or `get` required.

```
AppStateProvider (InheritedNotifier)
  └── AppStateNotifier (ChangeNotifier)
        ├── AppState.isDarkMode    → theme switch
        ├── AppState.favorites     → Set<String> of saved place IDs
        └── AppState.checklist     → Map<String, bool> of packing items
```

Any widget down the tree accesses state with:
```dart
final state = AppStateProvider.of(context);
```

Changes propagate automatically and efficiently — only widgets that call `of(context)` rebuild.

---

## 📝 Store Listing Copy

### Short Description *(80 characters)*
```
Offline Gir forest guide: safari, map, stays, food & emergency help
```

### Full Application Description *(≤ 4,000 characters)*

```
Gir Yatra is the ultimate offline travel companion for Sasan Gir Wildlife
Sanctuary — home to the last wild Asiatic lions on Earth. Whether you're
a first-time wildlife enthusiast or a seasoned jungle traveller, Gir Yatra
puts everything you need right in your pocket, even without a network signal.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🦁 SAFARI MADE SIMPLE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Browse safari session timings, entry fee breakdowns for Indian and foreign
visitors, step-by-step online booking guidance, and a full list of forest
rules — all in one place. Know exactly when to go, what to pay, and how to
behave inside the sanctuary.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🗺️ OFFLINE MAP — NO DATA NEEDED
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Our custom-painted interactive map works 100% offline. Tap any pin to
reveal location details, pinch to zoom in, and use the location list to
jump between key spots — all without burning mobile data inside the forest.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🏨 STAYS, FOOD & NEARBY ATTRACTIONS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Filter hotels and resorts by budget and proximity. Discover local Gujarati
cuisine highlights and cultural context. Explore 6 curated day-trip
destinations near the sanctuary with opening hours and travel directions.

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
44 packing items across 6 categories — clothing, gear, documents, medicine,
food, and miscellaneous. Essential items are flagged so nothing critical
gets left behind. A live progress bar shows how packed you really are.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🆘 EMERGENCY HELP — ALWAYS READY
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
8 emergency contacts including forest department, hospitals, and police.
4 first-aid protocol cards — snake bite, heat stroke, animal encounter,
and injury — with step-by-step expandable instructions. Available
instantly, even with zero network coverage.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚌 HOW TO REACH
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Get directions via road, rail, air, and local transport. Distances to 6
key transport hubs are visualised in an animated bar chart, with insider
tips for the final stretch into the forest.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🔍 SEARCH EVERYTHING
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
One search bar to find anything — places, hotels, food, rules, emergency
tips, packing items. Results appear instantly and link directly to the
relevant screen.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌙 DARK MODE & CLEAN DESIGN
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Gir Yatra respects your system theme and lets you switch manually anytime.
Built on Material 3 with a nature-inspired colour palette — deep forest
greens, warm amber, and soft sky blues.

No ads. No sign-in. No internet required. Just Gir, beautifully at your
fingertips.
```

### App Features *(for store feature bullets)*

```
• 100% offline — works inside the forest with zero signal
• Interactive custom map with tap-to-reveal location pins
• Safari timings, entry fees, booking guide & forest rules
• 12-month seasonal calendar — best time to visit at a glance
• Pre-built 1-Day and 2-Day itinerary plans
• Filterable hotel & resort directory
• Local Gujarati food guide and cultural highlights
• 6 nearby day-trip destinations with full details
• Smart packing checklist — 44 items, 6 categories, live progress bar
• 8 emergency contacts + 4 first-aid protocol cards
• Transport guide — road, rail, air & animated distance chart
• Universal real-time search across all app content
• Dark mode — system-aware with manual toggle
• Material 3 design — smooth animations & nature-inspired palette
• Zero third-party packages — lightweight, fast & privacy-friendly
```

---

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. **Fork** the repo and create a feature branch: `git checkout -b feat/your-feature`
2. Keep all content in `lib/data/` as typed Dart constants — no JSON files
3. No new pub packages without a strong justification
4. Run `flutter analyze` and `flutter test` before submitting
5. Open a **Pull Request** with a clear description of what changed and why

---

## 📄 License

```
MIT License — Copyright © 2026 Gir Yatra Contributors

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software to use, copy, modify, merge, publish, distribute, sublicense,
and/or sell copies of the Software, subject to the conditions of the MIT License.
```

---

<div align="center">

Made with 💚 for the lions of Gir · Gujarat, India 🇮🇳

**[⬆ Back to Top](#-gir-yatra)**

</div>