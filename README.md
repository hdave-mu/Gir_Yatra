<p align="center">
  <img src="gir_yatra_icon.png" width="130" alt="Gir Yatra Logo" />
</p>

<h1 align="center">🦁 Gir Yatra</h1>

<p align="center">
  <strong>The Definitive Tourism Companion for Sasan Gir & Saurashtra, Gujarat</strong><br/>
  <em>Plan your Gir Forest safari, browse stays, explore hidden gems, and handle emergencies — beautifully, offline-first.</em>
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
- [Features](#-features)
- [Project Architecture](#-project-architecture)
- [Tech Stack](#-tech-stack)
- [Quick Start](#-quick-start)
- [Screen Gallery](#-screen-gallery)
- [Data Design](#-data-design)
- [State Management](#-state-management)
- [Performance](#-performance)
- [Store Listing Copy](#-store-listing-copy)
- [Contributing](#-contributing)
- [License](#-license)

---

## 🌿 About the App

**Gir Yatra** is a fully offline-first Flutter travel guide for the **Sasan Gir Wildlife Sanctuary** — home to the last surviving Asiatic lions on Earth. Built for real travellers venturing into Gujarat's jungle heartland, every piece of tourism content ships compiled into the app as typed Dart constants. **Zero network. Zero JSON parsing. Zero cold-start latency.**

| Stat               | Value                                |
| :----------------- | :----------------------------------- |
| Lines of Dart      | **13,038**                           |
| Dart Source Files  | **26**                               |
| Screens            | **12**                               |
| Reusable Widgets   | **4**                                |
| Custom Animations  | **3** (fireflies, forest light, page transitions) |
| Curated Data Lines | **2,044** (static_data + extra_data) |
| Backend            | None — 100% offline                  |
| Platforms          | Android · Web (iOS-ready)            |
| Min SDK            | Flutter ≥ 3.0 · Dart ≥ 3.0           |
| Target FPS         | 120fps tuned                         |
| Locale             | en_IN                                |

---

## ✨ Features

### 🏠 Home Dashboard

- Animated lion splash screen with multi-controller SVG choreography
- Live **Forest Status** indicator (open / closed / restricted by month)
- Swipeable **Wildlife Facts** carousel with curated Asiatic lion trivia
- 5-tab bottom navigation (Home · Explore · Itinerary · Checklist · Profile)
- Slide-out **Drawer** with sections grouped by Main · Travel · Support
- Glassmorphism collapsible AppBar

### 🦁 Safari Information

- Session timings (morning & evening, summer & winter schedules)
- All **5 official safari zones** (East, West & Devalia) with entry points and highlights
- Complete **entry-fee breakdown** for Indian & foreign nationals, vehicle categories
- Step-by-step **booking process** guide linked to `girlion.gujarat.gov.in`
- Comprehensive **Safari Rules** — do's & don'ts inside the sanctuary

### 🏨 Stay & Accommodation

- **21 curated hotel and resort listings** around Sasan Gir
- Filterable by type (resort, hotel, eco-lodge, homestay, farmhouse)
- Sortable by **rating** or **price**
- Per-property details: amenities, phone, website, pricing, tips
- One-tap **call** and **website launch** via `url_launcher`

### 🍛 Food & Culture

- Tabbed view: **local Kathiawadi cuisine** + **cultural traditions**
- Must-try dish cards with descriptions and icons
- Regional dining etiquette and festival overview

### 📍 Nearby Attractions

- **10 handpicked destinations** — Somnath Temple, Girnar Hills, Junagadh, Diu Fort, Jamjir Waterfall, Tulshi Shyam, Kankai Mata, Devaliya Safari Park, Veraval Beach, and more
- Full detail view per location: distance, ratings, descriptions, curated imagery
- Filterable by type and sortable by distance or rating

### 🗓️ Smart Itinerary

- Pre-built **1-Day and 2-Day** travel plans in visual timeline format
- Hour-by-hour schedule with activity descriptions

### 📅 Seasonal Calendar

- **12-month breakdown** covering wildlife activity, weather, park status
- Local festivals flagged per month
- Crowd density indicators for choosing the perfect window

### 🚌 Transport & How to Reach

- **5 travel modes**: air, train, bus, car, and local taxi
- Distances, durations, fare estimates, station names, frequency info
- Insider **last-mile tips** for navigating into the forest

### ✅ Packing Checklist

- **45 items** across **6 categories** (Essentials, Clothing, Safari Gear, Toiletries, Food & Water, Electronics)
- **Essential-item badges** on must-have gear
- Live **progress bar** tracking checked vs. total items
- Check-all / clear-all controls
- Persisted across screens via global `InheritedNotifier` state

### 🆘 Emergency & Safety

- **9 quick-dial emergency contacts** (Forest Dept, Police, Hospital, Ambulance, Fire)
- One-tap **call and SMS** via `url_launcher`
- **4 first-aid protocol cards** — snake bite, heat stroke, animal encounter, insect bite
- Expandable step-by-step instructions per scenario

### 🔍 Universal Search

- Instant **full-text search** across all app content
- Covers: places, hotels, food, safari rules, emergency tips, packing items
- Results grouped by category with deep-link navigation

### 🎬 Motion & Atmosphere

- Custom **firefly particle painter** for ambient jungle feel
- **Forest light** volumetric-ray painter on hero surfaces
- Bespoke **page transitions** with physics-based curves
- `flutter_animate` chains for tasteful enter/exit motion
- `shimmer` skeletons during any synchronous load spikes

---

## 🗂 Project Architecture

```
gir_yatra_v_4/
│
├── lib/
│   ├── main.dart                        # App entry · SystemChrome · image cache tuning (71)
│   │
│   ├── data/
│   │   ├── static_data.dart             # Safari, hotels, places, food, culture (1,235)
│   │   └── extra_data.dart              # Transport, emergency, checklist, seasonal (809)
│   │
│   ├── screens/
│   │   ├── splash_screen.dart           # Multi-controller animated lion splash (472)
│   │   ├── home_screen.dart             # Dashboard + Drawer + BottomNav (2,188)
│   │   ├── safari_screen.dart           # Timings, zones, fees, rules, booking (675)
│   │   ├── stay_screen.dart             # 21 hotels with filter & sort (719)
│   │   ├── food_culture_screen.dart     # Tabbed food + culture guide (717)
│   │   ├── nearby_places_screen.dart    # 10 attractions with filter & sort (763)
│   │   ├── itinerary_screen.dart        # 1-Day & 2-Day visual timeline (681)
│   │   ├── seasonal_screen.dart         # 12-month seasonal calendar (394)
│   │   ├── transport_screen.dart        # How to reach — 5 modes (444)
│   │   ├── checklist_screen.dart        # 45-item packing checklist (542)
│   │   ├── emergency_screen.dart        # 9 contacts + 4 first-aid cards (644)
│   │   └── search_screen.dart           # Universal full-text search (681)
│   │
│   ├── animations/
│   │   ├── firefly_painter.dart         # Custom particle system (94)
│   │   ├── forest_light_painter.dart    # Volumetric light rays (124)
│   │   └── page_transitions.dart        # Bespoke route transitions (89)
│   │
│   ├── state/
│   │   └── app_state.dart               # InheritedNotifier — favorites, checklist, lang (110)
│   │
│   ├── theme/
│   │   ├── app_theme.dart               # Forest-green + amber Material 3 theme (330)
│   │   └── design_tokens.dart           # Shared radii, spacing, shadows (70)
│   │
│   ├── widgets/
│   │   ├── custom_card.dart             # Reusable card components (467)
│   │   ├── filter_bar.dart              # Horizontal filter chips + sort dropdown (203)
│   │   ├── contact_actions.dart         # One-tap call / SMS / website buttons (165)
│   │   └── shimmer_skeleton.dart        # Shimmer placeholders (136)
│   │
│   └── utils/
│       └── performance_utils.dart       # Frame-budget helpers, RepaintBoundary wraps (215)
│
├── Image/                               # Curated destination photographs
├── android/                             # Android platform config
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
| State Management | `InheritedNotifier` — zero external packages  |
| URL Actions      | `url_launcher` (call, SMS, website)           |
| SVG Rendering    | `flutter_svg`                                 |
| Motion           | `flutter_animate`                             |
| Loading States   | `shimmer`                                     |
| Typography       | `google_fonts`                                |
| Splash           | `flutter_native_splash` (custom branded)      |
| App Icon         | `flutter_launcher_icons` (adaptive icon)      |
| Theme            | Material 3 — Light-only forest-green palette  |
| Orientation      | Portrait-locked                               |
| Locale           | en_IN                                         |
| CI/CD            | Flutter CLI (`flutter build apk` / `ipa`)     |

---

## ⚡ Quick Start

```bash
# 1. Clone the project
git clone https://github.com/your-username/gir-yatra.git
cd gir-yatra

# 2. Install dependencies
flutter pub get

# 3. Generate launcher icons & splash screen
dart run flutter_launcher_icons
dart run flutter_native_splash:create

# 4. Run on a connected device or emulator
flutter run

# 5. Build a release APK
flutter build apk --release

# 6. Build for iOS (macOS required)
flutter build ipa --release
```

**Requirements:** Flutter ≥ 3.0 · Dart ≥ 3.0 · Android SDK 21+ or iOS 12+

> 💡 No backend setup. No API keys. No Firebase. Clone → `pub get` → `run`.

---

## 🖼 Screen Gallery

| Screen                 | Description                                                          |
| :--------------------- | :------------------------------------------------------------------- |
| **SplashScreen**       | Multi-controller animated lion entrance with SVG logo and ring pulse |
| **HomeScreen**         | Dashboard with forest status card + wildlife facts carousel          |
| **SafariScreen**       | Timings, 5 zones, fee tables, booking steps, rules                   |
| **StayScreen**         | 21 filterable hotels with sort-by-rating and sort-by-price           |
| **FoodCultureScreen**  | Tabbed Kathiawadi food & cultural traditions guide                   |
| **NearbyPlacesScreen** | 10 day-trip destinations with filter, sort, imagery                  |
| **ItineraryScreen**    | 1-Day & 2-Day visual timeline plans                                  |
| **SeasonalScreen**     | Month-by-month wildlife, weather, crowd, event guide                 |
| **TransportScreen**    | 5 travel modes with distances, fares, tips                           |
| **ChecklistScreen**    | 45-item smart packing checklist with progress bar                    |
| **EmergencyScreen**    | 9 quick-dial contacts + 4 first-aid protocol cards                   |
| **SearchScreen**       | Universal real-time full-text search                                 |

> 📸 _Screenshots coming soon — run the app to experience the full UI._

---

## 📦 Data Design

All tourism content lives as **typed Dart constants and model classes** in two dedicated files — available instantly without I/O, network, or JSON parsing.

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

  const SafariZone({ /* ... */ });
}
```

| Data File          | Lines | Content                                                                                                          |
| :----------------- | :---- | :--------------------------------------------------------------------------------------------------------------- |
| `static_data.dart` | 1,235 | Safari timings · 5 zones · fee tables · 21 hotels · 10 attractions · food · culture                              |
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
| Transport routes & fares    | Verified 2025–2026 season                                                                |

---

## 🧠 State Management

Gir Yatra uses Flutter's built-in **`InheritedNotifier`** pattern — no `provider`, `riverpod`, `bloc`, or `get` required.

```
GirYatraApp
  └── AppStateProvider (InheritedNotifier)
        └── AppStateNotifier (ChangeNotifier)
              ├── AppStateData.favoritePlaceIds    → Set<String>
              ├── AppStateData.favoriteHotelNames  → Set<String>
              ├── AppStateData.checkedItems        → Set<int>
              └── AppStateData.language            → String ('en' | 'gu')
```

Any widget down the tree reads state with:

```dart
final state = AppStateProvider.of(context);
```

Only widgets that call `of(context)` rebuild when the notifier fires — no rebuild storms.

---

## 🚀 Performance

The app is tuned for sustained 120fps on modern Android panels:

- **Image cache enlarged** to 500 entries / 750 MB GPU memory in `main.dart`
- **Debug paint flags killed** at startup (`debugRepaintRainbowEnabled = false`, etc.)
- **Bouncing scroll physics** paired with scrollbar-less `MaterialScrollBehavior`
- **`RepaintBoundary` wrappers** around animated regions (see `utils/performance_utils.dart`)
- **Custom `CustomPainter`s** with `shouldRepaint` returning `false` when idle
- **Portrait-locked** to avoid orientation-driven relayout cost
- **AOT-friendly const constructors** throughout widget tree

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
puts everything you need right in your pocket — fully offline.

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
the year. Ready-made 1-Day and 2-Day itineraries give you a complete
hour-by-hour plan the moment you land.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ SMART PACKING CHECKLIST
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
45 packing items across 6 categories. Essential items are flagged so
nothing critical gets left behind. A live progress bar shows how packed
you really are.

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
transport hubs with fare estimates and insider tips for the last mile
into the forest.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🔍 SEARCH EVERYTHING
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
One search bar to find anything — places, hotels, food, rules, emergency
tips, packing items. Results appear instantly and link directly to the
relevant screen.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🎨 BEAUTIFUL DESIGN
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Built on Material 3 with a nature-inspired palette — deep forest greens,
warm amber, and soft beige. Glassmorphism app bar, custom firefly and
forest-light painters, and 120fps-tuned animations throughout.

No ads. No tracking. No internet needed. Just Gir, beautifully at your
fingertips.
```

### App Features _(store feature bullets)_

```
• Safari timings, 5 zones, entry fees, booking guide & forest rules
• 21 curated hotels & resorts — filter by type, sort by rating/price
• 10 nearby attractions with ratings, distance & imagery
• 12-month seasonal calendar — wildlife, weather, events & crowd levels
• Pre-built 1-Day and 2-Day itinerary timeline plans
• Local Kathiawadi food guide + cultural highlights
• Smart packing checklist — 45 items, 6 categories, live progress
• 9 emergency contacts + 4 first-aid protocol cards with steps
• Transport guide — air, train, bus, car & local taxi with fares
• Universal real-time search across all app content
• Material 3 design — glassmorphism, custom painters, 120fps motion
• Animated lion splash screen with SVG logo
• 100% offline — no accounts, no tracking, no internet required
```

---

## 🤝 Contributing

Contributions welcome:

1. **Fork** and create a feature branch: `git checkout -b feat/your-feature`
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
