// lib/data/static_data.dart
// Curated data for Gir Yatra.
// Sources (fetched & curated manually):
//   • Safari: girlion.gujarat.gov.in (official permit portal)
//   • Hotels: tripadvisor.in – Sasan Gir listings
//   • Attractions: tripadvisor.in + verified temple/govt sources

import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────
// SAFARI — TIMINGS, ZONES, FEES, RULES
// ─────────────────────────────────────────────────────────────

class SafariTiming {
  final String session;
  final String time;
  final String season;
  final IconData icon;

  const SafariTiming({
    required this.session,
    required this.time,
    required this.season,
    required this.icon,
  });
}

// Two seasonal schedules from the official Gir portal.
const List<SafariTiming> safariTimings = [
  SafariTiming(
    session: 'Morning (Winter)',
    time: '6:30 AM – 9:30 AM',
    season: '16 October – 28/29 February',
    icon: Icons.wb_sunny_outlined,
  ),
  SafariTiming(
    session: 'Evening (Winter)',
    time: '3:00 PM – 6:00 PM',
    season: '16 October – 28/29 February',
    icon: Icons.wb_twilight,
  ),
  SafariTiming(
    session: 'Morning (Summer)',
    time: '6:00 AM – 9:00 AM',
    season: '1 March – 15 June',
    icon: Icons.sunny,
  ),
  SafariTiming(
    session: 'Evening (Summer)',
    time: '4:00 PM – 7:00 PM',
    season: '1 March – 15 June',
    icon: Icons.wb_twilight,
  ),
  SafariTiming(
    session: 'Monsoon Closure',
    time: 'Park CLOSED',
    season: '16 June – 15 October',
    icon: Icons.do_not_disturb_on_outlined,
  ),
];

// ─── Safari Zones ────────────────────────────────────────────
class SafariZone {
  final String name;
  final String code;
  final String description;
  final String entryPoint;
  final String highlight;
  final IconData icon;
  final Color color;

  const SafariZone({
    required this.name,
    required this.code,
    required this.description,
    required this.entryPoint,
    required this.highlight,
    required this.icon,
    required this.color,
  });
}

const List<SafariZone> safariZones = [
  SafariZone(
    name: 'Gir Jungle Trail',
    code: 'Main Safari',
    description:
        'The flagship jeep (Gypsy) safari through the core forest — the best chance of sighting Asiatic lions in the wild. Six pre-defined routes rotate daily.',
    entryPoint: 'Sinh Sadan, Sasan Gir',
    highlight: 'Lion, leopard, sambar, crocodile',
    icon: Icons.directions_car,
    color: Color(0xFF2E7D32),
  ),
  SafariZone(
    name: 'Devalia Safari Park',
    code: 'Interpretation Zone',
    description:
        'Fenced 4 sq km zone with bus & gypsy safaris. Near-guaranteed lion sightings — ideal for families and limited-time visitors.',
    entryPoint: 'Devalia (12 km from Sasan)',
    highlight: 'Guaranteed lions, leopards, deer',
    icon: Icons.local_activity,
    color: Color(0xFF388E3C),
  ),
  SafariZone(
    name: 'Ambardi Safari Park',
    code: 'Dhari',
    description:
        'Lesser-known lion safari park near Dhari, Amreli. Low crowds, open grassland views, good for second-time visitors.',
    entryPoint: 'Ambardi (near Dhari)',
    highlight: 'Open landscape, relaxed safaris',
    icon: Icons.park,
    color: Color(0xFF558B2F),
  ),
  SafariZone(
    name: 'Girnar Nature Safari',
    code: 'Junagadh',
    description:
        'Safari through Girnar Wildlife Sanctuary — hilly terrain, leopards, and birds. Close to Junagadh city.',
    entryPoint: 'Bhavnath, Junagadh',
    highlight: 'Leopards, hilly forest, raptors',
    icon: Icons.terrain,
    color: Color(0xFF5D4037),
  ),
];

// ─── Fees (permit only — vehicle & guide charged separately) ──
class EntryFee {
  final String category;
  final String feePerPerson;
  final String vehicleFee;
  final String guideCharge;

  const EntryFee({
    required this.category,
    required this.feePerPerson,
    required this.vehicleFee,
    required this.guideCharge,
  });
}

const List<EntryFee> entryFees = [
  EntryFee(
    category: 'Indian — Weekday',
    feePerPerson: '₹800 / permit (up to 6 pax)',
    vehicleFee: '₹2,500–₹4,500 (Gypsy, 4–8 seats)',
    guideCharge: '₹400–₹700 (G2 / G1 / Naturalist)',
  ),
  EntryFee(
    category: 'Indian — Weekend / Festival',
    feePerPerson: '₹1,000 / permit (up to 6 pax)',
    vehicleFee: 'Same as weekday',
    guideCharge: 'Same as weekday',
  ),
  EntryFee(
    category: 'Foreign — Weekday',
    feePerPerson: '₹7,440 / permit',
    vehicleFee: 'Same vehicle rates',
    guideCharge: 'Same guide rates',
  ),
  EntryFee(
    category: 'Foreign — Weekend / Festival',
    feePerPerson: '₹9,300 / permit',
    vehicleFee: 'Same vehicle rates',
    guideCharge: 'Same guide rates',
  ),
  EntryFee(
    category: 'Devalia Safari Park',
    feePerPerson: '₹150 Indian · ₹2,800 Foreign',
    vehicleFee: 'Bus / Gypsy included',
    guideCharge: 'Included',
  ),
];

// Quick-glance fee breakdown used by the Safari screen.
class SafariFeeLine {
  final String label;
  final String value;
  const SafariFeeLine(this.label, this.value);
}

const List<SafariFeeLine> vehicleFees = [
  SafariFeeLine('Gypsy — 4 seater', '₹2,500'),
  SafariFeeLine('Gypsy — 6 seater', '₹3,500'),
  SafariFeeLine('Gypsy — 8 seater', '₹4,500'),
];

const List<SafariFeeLine> guideFees = [
  SafariFeeLine('Naturalist Guide', '₹700'),
  SafariFeeLine('Guide G1', '₹500'),
  SafariFeeLine('Guide G2', '₹400'),
];

const List<String> safariRules = [
  'Carry original government photo ID (Aadhaar / Passport) — mandatory for every guest',
  'Reach the entry gate at least 30 minutes before your slot',
  'One e-permit covers up to 6 adults + 1 child (3–12 yrs)',
  'Vehicle and guide fees are separate — paid to operators on-site',
  'Stay inside the vehicle at all times — do not dismount',
  'No loud music, no shouting, no feeding wildlife',
  'Photography allowed — flash strictly prohibited',
  'No single-use plastic, no littering — carry back all waste',
  'Children below 3 are not permitted on the main jungle trail',
  'Tatkal / urgent bookings are not accepted — plan ahead',
];

const String bookingProcess = '''
1. Visit the only official portal: girlion.gujarat.gov.in
2. Register and book a permit 1–60 days in advance
3. Pick zone, date, slot (morning or evening)
4. Pay online — permit issued instantly as PDF
5. At Sasan, hire the Gypsy + guide at Sinh Sadan (fees paid separately)
6. Arrive 30 min before slot with the printed/digital permit + ID''';

const String bestSeasonInfo = '''
🌿 Best Season: October to June

• Oct 16 – Feb: Cool, clear weather — peak sightings & peak tourists
• March – April: Warm & dry — animals gather near waterholes
• May – June: Hot but highly predictable sightings around water
• Jun 16 – Oct 15: Forest CLOSED (monsoon & cub-rearing)

Peak months are Nov–Feb — book at least 2–3 weeks ahead.
''';

// Official booking URL — used for click-through.
const String officialBookingUrl = 'https://girlion.gujarat.gov.in/';
const String forestOfficePhone = '02877285541';

// ─────────────────────────────────────────────────────────────
// HOTELS (Sasan Gir) — curated from TripAdvisor
// ─────────────────────────────────────────────────────────────

class Hotel {
  final String name;
  final String location;
  final String priceRange;
  final int priceMin;
  final int priceMax;
  final String contact; // kept for legacy screens (search)
  final String? phone;
  final String? website;
  final String type;
  final String description;
  final List<String> amenities;
  final double rating;
  final int reviews;
  final IconData icon;

  const Hotel({
    required this.name,
    required this.location,
    required this.priceRange,
    required this.priceMin,
    required this.priceMax,
    required this.contact,
    required this.type,
    required this.description,
    required this.amenities,
    required this.rating,
    required this.reviews,
    required this.icon,
    this.phone,
    this.website,
  });
}

const List<Hotel> hotels = [
  Hotel(
    name: 'Saavaj Resort, Sasan Gir',
    location: 'Sasan Gir',
    priceRange: '₹4,564 – ₹6,000 / night',
    priceMin: 4564,
    priceMax: 6000,
    rating: 4.8,
    reviews: 599,
    contact: '+91-2877-285858',
    phone: '+91-2877-285858',
    website:
        'https://www.tripadvisor.in/Hotel_Review-g4468377-d4411813-Saavaj_Resort_Sasan_Gir.html',
    type: 'Luxury Resort',
    description:
        'A premium upscale resort nestled in lush green surroundings with elegantly designed cottages. Experience authentic Kathiyawadi hospitality with cultural performances, vegetarian cuisine featuring local flavours, and modern amenities. Perfect for families seeking comfort with cultural immersion.',
    amenities: [
      'Swimming Pool',
      'Cultural Shows',
      'Multi-cuisine Restaurant',
      'Kids Play Area',
      'WiFi',
      'AC Rooms'
    ],
    icon: Icons.holiday_village,
  ),
  Hotel(
    name: 'The Fern Gir Forest Resort',
    location: 'Near Reserve Forest, Sasan Gir',
    priceRange: '₹13,086 – ₹16,000 / night',
    priceMin: 13086,
    priceMax: 16000,
    rating: 4.9,
    reviews: 1486,
    contact: '+91-2877-220100',
    phone: '+91-2877-220100',
    website:
        'https://www.tripadvisor.in/Hotel_Review-g4468377-d2374356-The_Fern_Gir_Forest_Resort.html',
    type: 'Luxury Resort',
    description:
        'An award-winning serene resort nestled amid lush greenery adjacent to the Gir reserve forest. Features luxurious rooms with stunning views, diverse dining options with live counters, expert-guided bird watching, tribal dance performances, and engaging family activities. Exceptional service and modern luxury blend seamlessly with nature.',
    amenities: [
      'Swimming Pool',
      'Multiple Restaurants',
      'Bird Watching',
      'Evening Events',
      'WiFi',
      'Spa Services',
      'Kids Entertainment'
    ],
    icon: Icons.king_bed,
  ),
  Hotel(
    name: 'Anil Farm Gir Jungle Resort',
    location: 'Riverside, Sasan',
    priceRange: '₹3,294 – ₹5,000 / night',
    priceMin: 3294,
    priceMax: 5000,
    rating: 4.7,
    reviews: 267,
    contact: '+91-2877-285555',
    phone: '+91-2877-285555',
    website:
        'https://www.tripadvisor.in/Hotel_Review-g4468377-d2002909-Anil_Farm_Gir_Jungle_Resort.html',
    type: 'Eco-Resort',
    description:
        'A tranquil nature retreat located riverside with mango orchards creating a serene backdrop. Offers eco-friendly accommodation with swimming pool, vegetarian buffet meals, and excellent opportunities for wildlife spotting and bird watching. Ideal for nature lovers seeking an authentic forest experience.',
    amenities: [
      'Swimming Pool',
      'Vegetarian Buffet',
      'Birdwatching Tours',
      'Riverside Location',
      'WiFi',
      'Bonfire Area'
    ],
    icon: Icons.eco,
  ),
  Hotel(
    name: 'Gir Serai – IHCL SeleQtions',
    location: 'Hiran Riverside, Sasan Gir',
    priceRange: '₹9,388 – ₹12,000 / night',
    priceMin: 9388,
    priceMax: 12000,
    rating: 4.8,
    reviews: 695,
    contact: '+91-2877-222233',
    phone: '+91-2877-222233',
    website:
        'https://www.tripadvisor.in/Hotel_Review-g4468377-d2618091-Gir_Serai_IHCL_SeleQtions.html',
    type: 'Luxury Resort',
    description:
        'A prestigious heritage hotel by the Taj Group, elegantly blending old-world charm with contemporary comfort on the banks of the Hiran River. Features spacious rooms with private balconies, lush gardens, play areas for children, and prime proximity to safari check-in points. Exceptional hospitality and service excellence.',
    amenities: [
      'Riverside Location',
      'Garden Walks',
      'Kids Play Areas',
      'Safari Proximity',
      'WiFi',
      'Restaurant',
      'Room Service'
    ],
    icon: Icons.king_bed,
  ),
  Hotel(
    name: 'Vanveda Resort Sasan Gir By Nirvana',
    location: 'Sasan Gir',
    priceRange: '₹8,549 – ₹11,500 / night',
    priceMin: 8549,
    priceMax: 11500,
    rating: 4.5,
    reviews: 75,
    contact: '+91-2877-285999',
    phone: '+91-2877-285999',
    website:
        'https://www.tripadvisor.in/Hotel_Review-g4468377-d26800314-Vanveda_Resort_Sasan_Gir.html',
    type: 'Luxury Resort',
    description:
        'A premium forest resort featuring luxurious private-pool villas with spacious rooms and generous balconies. Offers indoor and outdoor pool facilities, delicious dining experiences, and attentive staff service. Perfect for families, couples, and group getaways seeking ultimate comfort in nature.',
    amenities: [
      'Private Pool Villas',
      'Indoor Pool',
      'Gourmet Restaurant',
      'Large Rooms',
      'WiFi',
      'Concierge',
      'Room Service'
    ],
    icon: Icons.king_bed,
  ),
  Hotel(
    name: 'Lion Park Hotel and Resort',
    location: 'Sasan Gir',
    priceRange: '₹2,585 – ₹4,500 / night',
    priceMin: 2585,
    priceMax: 4500,
    rating: 4.4,
    reviews: 33,
    contact: '+91-2877-285520',
    phone: '+91-2877-285520',
    website:
        'https://www.tripadvisor.in/Hotel_Review-g4468377-d13384035-Lion_Park_Hotel_and_Resort.html',
    type: 'Mid-Range Hotel',
    description:
        'A comfortable and budget-friendly accommodation offering clean, well-maintained rooms with pleasant ambiance. Situated in peaceful surroundings with convenient access to safari entry points and attractions. Reliable hospitality and good value for money make it ideal for budget-conscious travelers.',
    amenities: [
      'Swimming Pool',
      'Restaurant',
      'Clean Rooms',
      'Peaceful Location',
      'WiFi',
      'Parking',
      'Front Desk'
    ],
    icon: Icons.hotel,
  ),
  Hotel(
    name: 'Sarovar Portico, Sasan Gir',
    location: 'Near Sasan Gir National Park',
    priceRange: '₹4,288 – ₹6,500 / night',
    priceMin: 4288,
    priceMax: 6500,
    rating: 4.8,
    reviews: 570,
    contact: '+91-2877-285600',
    phone: '+91-2877-285600',
    website:
        'https://www.tripadvisor.in/Hotel_Review-g4468377-d23240601-Sarovar_Portico_Sasan_Gir.html',
    type: 'Family Resort',
    description:
        'A family-centric resort beautifully situated with stunning natural greenery near Gir National Park. Features a large swimming pool, badminton court, dedicated kids play area, and spacious rooms. Known for exceptional service, wholesome dining, and activities suited for all age groups.',
    amenities: [
      'Swimming Pool',
      'Badminton Court',
      'Kids Play Area',
      'Spacious Rooms',
      'WiFi',
      'Family Restaurant',
      'Games Room'
    ],
    icon: Icons.hotel,
  ),
  Hotel(
    name: 'Woods At Sasan',
    location: 'Inside a Mango Orchard, Sasan',
    priceRange: '₹16,358 – ₹19,000 / night',
    priceMin: 16358,
    priceMax: 19000,
    rating: 4.7,
    reviews: 334,
    contact: '+91-2877-221100',
    phone: '+91-2877-221100',
    website:
        'https://www.tripadvisor.in/Hotel_Review-g4468377-d12675622-Woods_At_Sasan.html',
    type: 'Eco-Resort',
    description:
        'A premium tranquil retreat located within a serene mango orchard, offering a unique eco-luxe experience. Guests enjoy organic cuisine at the signature Mango Bar, live musical performances, nature walks through the edible garden, and open balconies with panoramic views. A sanctuary for those seeking authentic nature connection.',
    amenities: [
      'Organic Cuisine',
      'Mango Bar',
      'Live Music Evenings',
      'Edible Garden Tours',
      'WiFi',
      'Spa',
      'Open Balconies'
    ],
    icon: Icons.eco,
  ),
  Hotel(
    name: 'AamraKunj Gir Resort',
    location: 'Sasan Gir',
    priceRange: '₹2,388 – ₹3,500 / night',
    priceMin: 2388,
    priceMax: 3500,
    rating: 5.0,
    reviews: 1,
    contact: '+91-2877-285888',
    phone: '+91-2877-285888',
    website:
        'https://www.tripadvisor.in/Hotel_Review-g4468377-d26857749-AamraKunj_Gir_Resort.html',
    type: 'Budget Hotel',
    description:
        'A highly-rated eco-friendly resort offering excellent value for money with a peaceful, nature-focused atmosphere. Committed to sustainable practices without compromising on comfort. Ideal for budget travelers and nature enthusiasts seeking an authentic, responsible travel experience.',
    amenities: [
      'Eco-Friendly Practices',
      'Peaceful Ambiance',
      'Nature-Focused',
      'Budget Friendly',
      'WiFi',
      'Natural Surroundings'
    ],
    icon: Icons.eco,
  ),
  Hotel(
    name: 'Asiatic Lion Lodge',
    location: 'Sasan Gir (jungle edge)',
    priceRange: '₹6,222 – ₹8,500 / night',
    priceMin: 6222,
    priceMax: 8500,
    rating: 4.8,
    reviews: 596,
    contact: '+91-2877-285777',
    phone: '+91-2877-285777',
    website:
        'https://www.tripadvisor.in/Hotel_Review-g4468377-d6415355-Asiatic_Lion_Lodge.html',
    type: 'Eco-Lodge',
    description:
        'An eco-conscious jungle lodge featuring vintage-style spacious cottages positioned at the forest edge. Offers adventure activities including cycling, hiking, guided bird watching tours, and memorable bonfire dinners under the stars. Includes professional wildlife safari coordination for authentic Gir forest exploration.',
    amenities: [
      'Cycling & Hiking',
      'Birdwatching Tours',
      'Bonfire Dinners',
      'Vintage Cottages',
      'WiFi',
      'Safari Desk',
      'Restaurant'
    ],
    icon: Icons.cabin,
  ),
];

// Filter categories used by the Stay screen.
const List<String> hotelTypeFilters = [
  'All',
  'Luxury Resort',
  'Family Resort',
  'Eco-Resort',
  'Eco-Lodge',
  'Mid-Range Hotel',
  'Budget Hotel',
];

// ─────────────────────────────────────────────────────────────
// FOOD & CULTURE
// ─────────────────────────────────────────────────────────────

class LocalDish {
  final String name;
  final String description;
  final String bestFoundAt;
  final bool isVeg;
  final IconData icon;

  const LocalDish({
    required this.name,
    required this.description,
    required this.bestFoundAt,
    required this.isVeg,
    required this.icon,
  });
}

const List<LocalDish> localDishes = [
  LocalDish(
    name: 'Kathiyawadi Thali',
    description:
        'A grand traditional platter featuring bajra rotla, ringna no olo (roasted brinjal), kadhi, dal, rice, buttermilk, and multiple accompaniments. The ultimate Gujarati feast!',
    bestFoundAt: 'Sasan village restaurants & Junagadh dhaba',
    isVeg: true,
    icon: Icons.rice_bowl,
  ),
  LocalDish(
    name: 'Bajra Rotla',
    description:
        'Thick millet bread cooked on clay griddle, eaten with ghee and jaggery. A staple of the local Maldhari community living inside the forest.',
    bestFoundAt: 'Local homes & village dhabas',
    isVeg: true,
    icon: Icons.breakfast_dining,
  ),
  LocalDish(
    name: 'Khichdi with Kadhi',
    description:
        'Comfort food of Gujarat — yellow moong dal cooked with rice, served with tangy yoghurt-based kadhi. Simple, wholesome, and nourishing.',
    bestFoundAt: 'All local restaurants',
    isVeg: true,
    icon: Icons.set_meal,
  ),
  LocalDish(
    name: 'Gir Kesar Mango',
    description:
        'The world-famous GI-tagged Kesar mango grown in Gir orchards. Intensely aromatic, saffron-coloured pulp. Available May–July. Do not miss it!',
    bestFoundAt: 'Roadside stalls & Talala market (May–July)',
    isVeg: true,
    icon: Icons.eco,
  ),
  LocalDish(
    name: 'Sev Tameta',
    description:
        'A simple but delicious dish of crispy sev (gram flour noodles) cooked with tomatoes and spices. A Saurashtra specialty eaten with rotla.',
    bestFoundAt: 'Street stalls in Sasan & Veraval',
    isVeg: true,
    icon: Icons.soup_kitchen,
  ),
  LocalDish(
    name: 'Gir Buffalo Milk Chai',
    description:
        'Famous thick, creamy tea made with full-fat buffalo milk from the Maldhari community. Richer and creamier than regular chai.',
    bestFoundAt: 'Chai stalls near forest gate',
    isVeg: true,
    icon: Icons.local_cafe,
  ),
];

class CultureTradition {
  final String title;
  final String description;
  final IconData icon;

  const CultureTradition({
    required this.title,
    required this.description,
    required this.icon,
  });
}

const List<CultureTradition> cultureTraditions = [
  CultureTradition(
    title: 'Maldhari Community',
    description:
        'The indigenous Maldhari people have lived inside the Gir forest for centuries alongside lions. They are buffalo and cattle herders who share a unique coexistence with wildlife. Visiting their nes (hamlet) is a once-in-a-lifetime cultural experience.',
    icon: Icons.people,
  ),
  CultureTradition(
    title: 'Siddi Tribe',
    description:
        'The Siddis are an Afro-Indian community descended from African traders and soldiers. They live in the Gir region and perform the traditional Dhamal dance — a vibrant, rhythmic celebration of African and Indian heritage.',
    icon: Icons.celebration,
  ),
  CultureTradition(
    title: 'Navratri Celebrations',
    description:
        'Gujarat\'s most beloved festival is celebrated grandly in Sasan and Junagadh. Locals and tourists dance Garba (circular folk dance) and Dandiya together for nine nights. A truly electric cultural experience.',
    icon: Icons.music_note,
  ),
  CultureTradition(
    title: 'Cow Worship & Panchayat',
    description:
        'Cattle are considered sacred by the local Kathiyawadi community. Village Panchayats (local self-governance) remain very active. Cattle fairs (Pashu Mela) are periodically held near Talala.',
    icon: Icons.agriculture,
  ),
  CultureTradition(
    title: 'Traditional Craft — Leather & Jewelry',
    description:
        'Local artisans craft beautiful hand-tooled leather items, silver jewelry, and embroidered textiles. Junagadh\'s old market is the best place to buy authentic handicrafts at fair prices.',
    icon: Icons.diamond_outlined,
  ),
];

// ─────────────────────────────────────────────────────────────
// NEARBY PLACES / ATTRACTIONS
// Sources: TripAdvisor + official/verified temple & govt sites
// ─────────────────────────────────────────────────────────────

class NearbyPlace {
  final String id;
  final String name;
  final String
      type; // e.g. Temple, Wildlife, Viewpoint, Heritage, Waterfall, Beach
  final String shortDescription;
  final String fullDescription;
  final String distance;
  final double? distanceKm; // numeric distance for sorting (if known)
  final double? rating;
  final String bestTime;
  final String entryFee;
  final List<String> travelTips;
  final String? website;
  final IconData icon;
  final Color color;
  final String imagePath; // Path to the place image

  const NearbyPlace({
    required this.id,
    required this.name,
    required this.type,
    required this.shortDescription,
    required this.fullDescription,
    required this.distance,
    required this.bestTime,
    required this.entryFee,
    required this.travelTips,
    required this.icon,
    required this.color,
    required this.imagePath,
    this.distanceKm,
    this.rating,
    this.website,
  });
}

final List<NearbyPlace> nearbyPlaces = [
  // Inside / very near Gir
  const NearbyPlace(
    id: 'devalia',
    name: 'Devalia Safari Park',
    type: 'Wildlife',
    rating: 4.8,
    distanceKm: 11,
    shortDescription: 'Enclosed lion safari — near-guaranteed sightings',
    fullDescription:
        'Devalia Safari Park (Gir Interpretation Zone) is an enclosed 4 sq km fenced area inside Gir National Park. Unlike the main trail where sightings rely on luck, Devalia offers near-guaranteed sightings of Asiatic lions, leopards, spotted deer, crocodiles, sambars and various birds from dedicated safari buses and gypsies. Ideal for families, senior citizens and travellers on tight schedules.',
    distance: '11 km from Sasan · ~19 min drive',
    bestTime: 'October – June | Avoid midday in summer',
    entryFee: '₹150 Indian · ₹2,800 Foreign (bus included)',
    travelTips: [
      'No private vehicles — government bus or gypsy only',
      'Lion sightings are near-guaranteed — great for families',
      'Book tickets at Devalia counter or Sasan office',
      'Combine with main Sasan safari on the same day',
      'Best light for photography: morning session',
    ],
    website: 'https://girlion.gujarat.gov.in/',
    icon: Icons.local_activity,
    color: Color(0xFF2E7D32),
    imagePath: 'Image/Devaliya Safari Park.jpg',
  ),
  const NearbyPlace(
    id: 'kankai',
    name: 'Kankai Mata Temple',
    type: 'Temple',
    rating: 3.8,
    distanceKm: 46,
    shortDescription: 'Quaint temple deep inside Gir forest',
    fullDescription:
        'Kankai Mata is a centuries-old goddess temple situated deep inside the Gir forest. The drive through the forest is itself the experience — dense teak canopy, occasional lion and leopard sightings on the approach road. The temple serves a simple prasad and is busiest during festivals. Entry requires a forest permit for the inner road on most days.',
    distance: '46 km from Sasan · ~1 hr 46 min drive (forest road)',
    bestTime: 'October – April',
    entryFee: 'Free (forest road permit may apply)',
    travelTips: [
      'Check forest road access at the Sasan range office first',
      'Drive slowly — wildlife actively crosses the road',
      'Avoid monsoon months — road becomes inaccessible',
      'Carry water and snacks — no shops en route',
    ],
    icon: Icons.temple_hindu,
    color: Color(0xFFFF8F00),
    imagePath: 'Image/kankai mata.jpg',
  ),
  const NearbyPlace(
    id: 'jamjir',
    name: 'Jamjir Waterfall',
    type: 'Waterfall',
    rating: 4.1,
    distanceKm: 50,
    shortDescription: 'Perennial waterfall on the Shingoda river',
    fullDescription:
        'One of the only year-round waterfalls in the Saurashtra region, Jamjir falls into a rocky pool on the Shingoda river near Una. The surrounding forest makes it a peaceful half-day picnic spot. The flow is strongest just after the monsoon (Sep–Nov).',
    distance: '50 km from Sasan · ~1 hr drive',
    bestTime: 'September – February',
    entryFee: 'Free',
    travelTips: [
      'Wear grippy shoes — rocks are slippery',
      'Do not swim during full monsoon flow',
      'Combine with a Tulsi Shyam visit',
      'Best photographed in morning light',
    ],
    icon: Icons.water_drop,
    color: Color(0xFF0277BD),
    imagePath: 'Image/Jamjir Waterfall.jpg',
  ),
  const NearbyPlace(
    id: 'tulsi',
    name: 'Tulsi Shyam',
    type: 'Temple',
    rating: 4.2,
    distanceKm: 90,
    shortDescription: 'Hot springs temple deep in the forest',
    fullDescription:
        'Tulsi Shyam is a Vishnu (Shyam) temple inside the Gir forest, known for natural sulphur hot springs (kund) reaching 45–50°C. The drive through the forest is remarkable — wildlife sightings are common. Ancient carvings and a serene forest setting make this a spiritual favourite.',
    distance: '90 km from Sasan · ~2 hrs 26 min drive',
    bestTime: 'October – April · Kartik Purnima is festive',
    entryFee: 'Free (temple donation optional)',
    travelTips: [
      'Drive slowly through forest — wildlife crossing',
      'Hot-spring water is very hot — test before entering',
      'Festival days are crowded but very vibrant',
      'No food stalls deep inside — carry snacks',
    ],
    icon: Icons.hot_tub,
    color: Color(0xFFE65100),
    imagePath: 'Image/Tulshi Shyam.jpg',
  ),
  const NearbyPlace(
    id: 'veraval',
    name: 'Veraval Beach',
    type: 'Beach',
    rating: 4.0,
    distanceKm: 44,
    shortDescription: 'Historic fishing port & coastal town',
    fullDescription:
        'Veraval is an ancient coastal city and one of India\'s busiest fishing ports, just minutes from Somnath. The bustling fish market, colourful boats and evening beach walks are its highlights. Bhalka Tirth — the site where Lord Krishna is believed to have departed the earthly realm — is nearby.',
    distance: '44 km from Sasan · ~1 hr 5 min drive',
    bestTime: 'October – March',
    entryFee: 'Free',
    travelTips: [
      'Visit the fish market at 6 AM for an authentic experience',
      'Evenings are perfect for beach walks and sunsets',
      'Bhalka Tirth is just 5 km away',
      'Combine with Somnath temple (5 km further)',
    ],
    icon: Icons.beach_access,
    color: Color(0xFF0277BD),
    imagePath: 'Image/Veravel Beach.jpg',
  ),
  const NearbyPlace(
    id: 'somnath',
    name: 'Somnath Temple',
    type: 'Temple',
    rating: 4.8,
    distanceKm: 45,
    shortDescription: 'One of the 12 Jyotirlingas of Lord Shiva',
    fullDescription:
        'Somnath is the first among the 12 sacred Jyotirlinga shrines of Lord Shiva, rebuilt many times through history. The Chalukya-style sandstone temple faces the Arabian Sea. Evening aarti at 7 PM and the Sound & Light Show at 8 PM are the must-do experiences.',
    distance: '45 km from Sasan · ~1 hr 7 min drive',
    bestTime: 'November – March | Evening for Sound & Light Show',
    entryFee: 'Free entry · ₹25 Sound & Light Show',
    travelTips: [
      'Dress modestly — traditional attire preferred',
      'Mobiles and cameras are prohibited inside the sanctum',
      'Evening aarti is intensely atmospheric',
      'Triveni Sangam (3 rivers meeting the sea) is nearby',
    ],
    website: 'https://somnath.org/',
    icon: Icons.temple_hindu,
    color: Color(0xFFFF8F00),
    imagePath: 'Image/Somnath Temple.jpg',
  ),
  const NearbyPlace(
    id: 'girnar',
    name: 'Girnar Hills',
    type: 'Pilgrimage / Trek',
    rating: 4.6,
    distanceKm: 65,
    shortDescription: 'Sacred Jain & Hindu hills with ~10,000 steps',
    fullDescription:
        'Girnar is a sacred mountain range near Junagadh with Jain and Hindu temples at multiple elevations. The traditional climb is ~9,999 stone steps; a ropeway now makes the main summit accessible. Sunrise from the top is unforgettable. Gorakhnath peak (1,117 m) is the highest.',
    distance: '65 km from Sasan · ~1.5 hrs drive',
    bestTime: 'October – February · Maha Shivratri for Bhavnath fair',
    entryFee: 'Free · Ropeway ₹700 return · ₹130 one-way',
    travelTips: [
      'Start before 5 AM if climbing on foot',
      'Wear proper shoes — no slippers',
      'Palanquin (doli) service available for elderly',
      'Ropeway runs ~8 AM to 5 PM',
      'Carry water and light snacks',
    ],
    icon: Icons.terrain,
    color: Color(0xFF5D4037),
    imagePath: 'Image/Girnar Hills.jpg',
  ),
  const NearbyPlace(
    id: 'junagadh',
    name: 'Junagadh City',
    type: 'Heritage',
    rating: 4.3,
    distanceKm: 65,
    shortDescription: 'Ancient fort city with Nawabi heritage',
    fullDescription:
        'Junagadh ("Old Fort") is a historic city blending Hindu, Jain and Islamic architecture. Uparkot Fort is 2,300 years old with Buddhist caves and step-wells. Mahabat Maqbara — the Nawab\'s tomb — is an Indo-Islamic-European hybrid with silver doors and minarets. Sakkarbaug Zoo houses Asiatic lions.',
    distance: '65 km from Sasan · ~1.5 hrs drive',
    bestTime: 'October – March',
    entryFee: 'Uparkot ₹20 · Maqbara Free · Zoo ₹50',
    travelTips: [
      'Start with Uparkot Fort early for fewer crowds',
      'Mahabat Maqbara glows at sunset',
      'Try Junagadh jalebi and chikki',
      'Sakkarbaug Zoo is great for lion sightings',
    ],
    icon: Icons.fort,
    color: Color(0xFF6A1B9A),
    imagePath: 'Image/Junagadh City.jpeg',
  ),
  const NearbyPlace(
    id: 'diu',
    name: 'Diu Fort',
    type: 'Heritage',
    rating: 4.1,
    distanceKm: 115,
    shortDescription: '16th-century Portuguese seafort',
    fullDescription:
        'A 16th-century Portuguese coastal fort on the island of Diu, with cannons, watch towers and sweeping Arabian Sea views. Pair it with Nagoa beach and St. Paul\'s Church for a full day outing.',
    distance: '115 km from Sasan · ~2.5 hrs drive',
    bestTime: 'November – March',
    entryFee: 'Nominal (₹5–₹10 at gate)',
    travelTips: [
      'Best visited as a day trip from Sasan / Somnath',
      'Carry ID — it\'s a Union Territory border crossing',
      'Sunset view from the fort is spectacular',
      'Combine with Nagoa beach & St. Paul\'s Church',
    ],
    icon: Icons.castle,
    color: Color(0xFF00695C),
    imagePath: 'Image/Diu Fort.jpg',
  ),
];

// ─────────────────────────────────────────────────────────────
// ITINERARIES
// ─────────────────────────────────────────────────────────────

class ItineraryStep {
  final String time;
  final String activity;
  final String description;
  final String location;
  final IconData icon;
  final Color color;

  const ItineraryStep({
    required this.time,
    required this.activity,
    required this.description,
    required this.location,
    required this.icon,
    required this.color,
  });
}

class ItineraryDay {
  final int day;
  final String title;
  final String theme;
  final List<ItineraryStep> steps;

  const ItineraryDay({
    required this.day,
    required this.title,
    required this.theme,
    required this.steps,
  });
}

final List<ItineraryDay> oneDayItinerary = [
  const ItineraryDay(
    day: 1,
    title: 'Best of Gir in One Day',
    theme: 'Safari + Wildlife + Temple',
    steps: [
      ItineraryStep(
        time: '5:30 AM',
        activity: 'Wake Up & Depart',
        description:
            'Get ready early. Head to the Forest Entry Gate. Morning air is fresh and animals are most active.',
        location: 'Your Hotel',
        icon: Icons.hotel,
        color: Color(0xFF5D4037),
      ),
      ItineraryStep(
        time: '6:00 AM',
        activity: 'Morning Safari 🦁',
        description:
            'Enter Sasan Gir for the morning jeep safari. Best chance to spot Asiatic lions, deer, crocodiles and birds.',
        location: 'Sasan Gir Forest',
        icon: Icons.directions_car,
        color: Color(0xFF2E7D32),
      ),
      ItineraryStep(
        time: '9:30 AM',
        activity: 'Breakfast at Dhaba',
        description:
            'Authentic Kathiyawadi breakfast — bajra rotla with ghee, chai and local snacks at a village dhaba.',
        location: 'Sasan Village',
        icon: Icons.coffee,
        color: Color(0xFFFF8F00),
      ),
      ItineraryStep(
        time: '11:00 AM',
        activity: 'Devalia Safari Park 🐆',
        description:
            'Visit the enclosed safari park for guaranteed lion and leopard sightings. Bus tour takes ~60 min.',
        location: 'Devalia, 12 km',
        icon: Icons.local_activity,
        color: Color(0xFF1565C0),
      ),
      ItineraryStep(
        time: '1:00 PM',
        activity: 'Lunch Break',
        description:
            'Traditional Kathiyawadi Thali at a local restaurant. Try sev tameta, kadhi and fresh buttermilk.',
        location: 'Sasan or Devalia',
        icon: Icons.restaurant,
        color: Color(0xFFE65100),
      ),
      ItineraryStep(
        time: '2:30 PM',
        activity: 'Drive to Veraval',
        description:
            'Scenic coastal drive through Gir forests to the Arabian Sea coast.',
        location: 'Veraval, 40 km',
        icon: Icons.directions_car,
        color: Color(0xFF0277BD),
      ),
      ItineraryStep(
        time: '4:00 PM',
        activity: 'Somnath Temple 🛕',
        description:
            'Visit the sacred Jyotirlinga. Evening aarti at 7 PM is spectacular. Sound & Light show at 8 PM.',
        location: 'Somnath, 45 km',
        icon: Icons.temple_hindu,
        color: Color(0xFFFF8F00),
      ),
      ItineraryStep(
        time: '8:00 PM',
        activity: 'Sound & Light Show',
        description:
            'Dramatic narration of Somnath\'s history against the sea. Return to hotel after.',
        location: 'Somnath Temple',
        icon: Icons.lightbulb_circle,
        color: Color(0xFF6A1B9A),
      ),
    ],
  ),
];

final List<ItineraryDay> twoDayItinerary = [
  const ItineraryDay(
    day: 1,
    title: 'Lion Land — Safari & Forest',
    theme: 'Wildlife, Nature & Local Culture',
    steps: [
      ItineraryStep(
        time: '5:30 AM',
        activity: 'Wake Up & Depart',
        description:
            'Get ready early. Head to the Forest Entry Gate. Morning air is fresh and animals are most active.',
        location: 'Your Hotel',
        icon: Icons.hotel,
        color: Color(0xFF5D4037),
      ),
      ItineraryStep(
        time: '6:00 AM',
        activity: 'Morning Safari 🦁',
        description:
            'Prime time for wildlife. Board the Gypsy jeep for the main forest safari.',
        location: 'Sasan Gir Forest',
        icon: Icons.directions_car,
        color: Color(0xFF2E7D32),
      ),
      ItineraryStep(
        time: '9:30 AM',
        activity: 'Forest Breakfast',
        description: 'Chai and bajra khichdi at a dhaba near the forest gate.',
        location: 'Sasan Village',
        icon: Icons.coffee,
        color: Color(0xFFFF8F00),
      ),
      ItineraryStep(
        time: '11:00 AM',
        activity: 'Devalia Safari Park',
        description:
            'Enclosed 4 sq km safari with guaranteed lion, leopard, deer and crocodile sightings.',
        location: 'Devalia, 12 km',
        icon: Icons.local_activity,
        color: Color(0xFF1565C0),
      ),
      ItineraryStep(
        time: '1:00 PM',
        activity: 'Village Cultural Walk',
        description:
            'Walk through Sasan village. Visit a Maldhari hamlet. See traditional clay houses.',
        location: 'Sasan Village',
        icon: Icons.people,
        color: Color(0xFF5D4037),
      ),
      ItineraryStep(
        time: '3:00 PM',
        activity: 'Evening Safari 🐊',
        description:
            'Second safari of the day — golden light is best for photography.',
        location: 'Sasan Gir Forest',
        icon: Icons.directions_car,
        color: Color(0xFF2E7D32),
      ),
      ItineraryStep(
        time: '6:30 PM',
        activity: 'Campfire Dinner 🔥',
        description:
            'Kathiyawadi thali dinner with campfire experience at the lodge.',
        location: 'Eco-Lodge',
        icon: Icons.fireplace,
        color: Color(0xFFE65100),
      ),
    ],
  ),
  const ItineraryDay(
    day: 2,
    title: 'Pilgrimage & Coastal Trail',
    theme: 'Temples, Hills & Beaches',
    steps: [
      ItineraryStep(
        time: '6:00 AM',
        activity: 'Drive to Somnath',
        description: 'Coastal drive with a sunrise over the Arabian Sea.',
        location: 'Somnath, 45 km',
        icon: Icons.directions_car,
        color: Color(0xFF0277BD),
      ),
      ItineraryStep(
        time: '7:30 AM',
        activity: 'Morning Aarti at Somnath 🛕',
        description: 'Attend the morning prayer ceremony at the Jyotirlinga.',
        location: 'Somnath Temple',
        icon: Icons.temple_hindu,
        color: Color(0xFFFF8F00),
      ),
      ItineraryStep(
        time: '9:30 AM',
        activity: 'Veraval Fish Market',
        description: 'Walk through Veraval\'s famous fish market and port.',
        location: 'Veraval Port',
        icon: Icons.sailing,
        color: Color(0xFF0277BD),
      ),
      ItineraryStep(
        time: '11:30 AM',
        activity: 'Drive to Junagadh',
        description: 'Head inland to the historic fort city of Junagadh.',
        location: 'Junagadh, 65 km',
        icon: Icons.directions_car,
        color: Color(0xFF5D4037),
      ),
      ItineraryStep(
        time: '1:00 PM',
        activity: 'Lunch in Junagadh',
        description:
            'Famous jalebi and chaat. Try the Kesar milkshake from the old market.',
        location: 'Junagadh Old Market',
        icon: Icons.restaurant,
        color: Color(0xFFE65100),
      ),
      ItineraryStep(
        time: '2:00 PM',
        activity: 'Uparkot Fort & Mahabat Maqbara',
        description:
            'Explore the 2,300-year-old fort and the silver-doored Nawab\'s tomb.',
        location: 'Junagadh Fort',
        icon: Icons.fort,
        color: Color(0xFF6A1B9A),
      ),
      ItineraryStep(
        time: '4:00 PM',
        activity: 'Local Shopping 🛍️',
        description:
            'Handicrafts, leather, Gir honey, Kesar pickles and authentic souvenirs.',
        location: 'Junagadh Market',
        icon: Icons.shopping_bag,
        color: Color(0xFF2E7D32),
      ),
      ItineraryStep(
        time: '6:00 PM',
        activity: 'Return Journey',
        description:
            'Head home or to the nearest station (Junagadh / Veraval). 🌿',
        location: 'Departure',
        icon: Icons.flight_takeoff,
        color: Color(0xFF5D4037),
      ),
    ],
  ),
];

// ─────────────────────────────────────────────────────────────
// QUICK FACTS & ECO TIPS
// ─────────────────────────────────────────────────────────────

class QuickFact {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const QuickFact({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });
}

const List<QuickFact> quickFacts = [
  QuickFact(
    label: 'Total Area',
    value: '1,412 sq km',
    icon: Icons.map_outlined,
    color: Color(0xFF2E7D32),
  ),
  QuickFact(
    label: 'Lion Population',
    value: '674 (2020 census)',
    icon: Icons.pets,
    color: Color(0xFFFF8F00),
  ),
  QuickFact(
    label: 'Best Season',
    value: 'Oct – June',
    icon: Icons.calendar_today,
    color: Color(0xFF1565C0),
  ),
  QuickFact(
    label: 'Nearest Airport',
    value: 'Rajkot (160 km)',
    icon: Icons.flight,
    color: Color(0xFF6A1B9A),
  ),
  QuickFact(
    label: 'Nearest Railway',
    value: 'Veraval (40 km)',
    icon: Icons.train,
    color: Color(0xFF5D4037),
  ),
  QuickFact(
    label: 'Languages',
    value: 'Gujarati, Hindi',
    icon: Icons.language,
    color: Color(0xFFE65100),
  ),
];

const List<String> ecoTips = [
  'Carry reusable water bottles — no single-use plastic',
  'Use cloth bags for shopping in markets',
  'Do not pluck flowers or disturb forest plants',
  'Opt for eco-lodges over conventional hotels',
  'Never litter inside or near the forest',
  'Use public transport (GSRTC buses) when possible',
  'Respect wildlife — maintain safe distances',
  'Support local artisans and buy authentic handmade crafts',
  'Avoid loud music in and around forest areas',
  'Learn a few words of Gujarati — locals appreciate it!',
];
