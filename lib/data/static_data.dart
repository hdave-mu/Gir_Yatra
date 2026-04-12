// lib/data/static_data.dart
// All static data for Gir Yatra — NO internet required
// Data covers Safari info, Hotels, Food, Places, Itinerary

import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────
// 🐾 SAFARI DATA
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

const List<SafariTiming> safariTimings = [
  SafariTiming(
    session: 'Morning Safari',
    time: '6:00 AM – 9:00 AM',
    season: 'October – June',
    icon: Icons.wb_sunny_outlined,
  ),
  SafariTiming(
    session: 'Evening Safari',
    time: '3:00 PM – 6:00 PM',
    season: 'October – June',
    icon: Icons.wb_twilight,
  ),
];

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
    category: 'Indian Citizen',
    feePerPerson: '₹75',
    vehicleFee: '₹450 (Gypsy)',
    guideCharge: '₹150',
  ),
  EntryFee(
    category: 'Foreign Tourist',
    feePerPerson: '₹1,500',
    vehicleFee: '₹450 (Gypsy)',
    guideCharge: '₹300',
  ),
  EntryFee(
    category: 'Devalia Safari Park',
    feePerPerson: '₹75 (Indian)',
    vehicleFee: 'Bus Included',
    guideCharge: 'Included',
  ),
];

const List<String> safariRules = [
  'No loud music or unnecessary noise inside the forest',
  'Strictly no littering — carry your waste back',
  'Do not feed or provoke wildlife',
  'Stay inside the vehicle at all times',
  'Photography is allowed without flash',
  'Mobile phones should be on silent mode',
  'Children below 5 years are not recommended',
  'Booking is mandatory — online or at forest office',
  'Carry valid ID proof (Aadhaar / Passport)',
  'No plastic bags or single-use plastic inside',
];

const String bookingProcess = '''
1. Online Booking: Visit the official Gujarat Forest Dept website
   → sasangir.gujarat.gov.in
2. Book at least 1–2 days in advance (especially peak season)
3. Slots are limited — 6 Gypsies per zone per session
4. Carry booking confirmation (printout or digital)
5. Reach the entry gate 30 minutes before your slot
6. Forest office counter opens at 5:30 AM for morning safari''';

const String bestSeasonInfo = '''
🌿 Best Season: October to June

• October – February: Cool weather, excellent wildlife sightings
• March – April: Dry season, animals gather near waterholes
• May – June: Hot but ideal for spotting lions in open areas
• July – September: Monsoon — Forest CLOSED for tourists

Peak Season: November to February (Book well in advance!)
''';

// ─────────────────────────────────────────────────────────────
// 🏨 ACCOMMODATION DATA
// ─────────────────────────────────────────────────────────────

class Hotel {
  final String name;
  final String location;
  final String priceRange;
  final String contact;
  final String type;
  final String description;
  final List<String> amenities;
  final IconData icon;

  const Hotel({
    required this.name,
    required this.location,
    required this.priceRange,
    required this.contact,
    required this.type,
    required this.description,
    required this.amenities,
    required this.icon,
  });
}

const List<Hotel> hotels = [
  Hotel(
    name: 'Gir Jungle Lodge',
    location: 'Sasan Gir, Near Entry Gate',
    priceRange: '₹4,000 – ₹8,000 / night',
    contact: '+91-92650-XXXXX',
    type: 'Eco-Lodge',
    description: 'Nestled inside the forest buffer zone, this eco-lodge offers an authentic jungle experience with guided nature walks.',
    amenities: ['Safari Booking Help', 'Nature Walk', 'Veg Restaurant', 'Wi-Fi in Lobby'],
    icon: Icons.cabin,
  ),
  Hotel(
    name: 'Lion Safari Camp',
    location: 'Sasan Village, 1 km from gate',
    priceRange: '₹2,500 – ₹5,000 / night',
    contact: '+91-98795-XXXXX',
    type: 'Safari Camp',
    description: 'Comfortable tented accommodations with modern amenities, offering an immersive forest camping experience.',
    amenities: ['Tent Stay', 'Campfire', 'Safari Packages', 'Meals Included'],
    icon: Icons.holiday_village,
  ),
  Hotel(
    name: 'Hotel Gir Greens',
    location: 'Sasan Gir Main Road',
    priceRange: '₹1,500 – ₹3,500 / night',
    contact: '+91-99256-XXXXX',
    type: 'Budget Hotel',
    description: 'Clean and affordable hotel with easy access to forest and local market. Best value for budget travellers.',
    amenities: ['AC Rooms', 'Free Parking', 'Restaurant', 'Safari Assistance'],
    icon: Icons.hotel,
  ),
  Hotel(
    name: 'Taj Safari Sasan',
    location: 'Sasan Gir, Junagarh Road',
    priceRange: '₹12,000 – ₹25,000 / night',
    contact: '+91-79-XXXXXXXX',
    type: 'Luxury Resort',
    description: 'Premium luxury resort with spa, pool, and fine dining. Offers exclusive private safari arrangements.',
    amenities: ['Swimming Pool', 'Spa', 'Fine Dining', 'Private Safari', 'Conference Hall'],
    icon: Icons.king_bed,
  ),
  Hotel(
    name: 'GTDC Tourist Bungalow',
    location: 'Sasan Gir, Forest Department',
    priceRange: '₹800 – ₹1,800 / night',
    contact: '+91-2877-285541',
    type: 'Government Lodge',
    description: 'Government-run tourist bungalow maintained by Gujarat Tourism. Simple, clean, and well-located.',
    amenities: ['Basic AC', 'Canteen', 'Parking', 'Safe Location'],
    icon: Icons.apartment,
  ),
  Hotel(
    name: 'Maneland Jungle Lodge',
    location: 'Sasan, Gir Forest Buffer',
    priceRange: '₹3,500 – ₹7,000 / night',
    contact: '+91-94270-XXXXX',
    type: 'Jungle Lodge',
    description: 'Family-run lodge at the edge of the forest with personalised service, home-cooked meals and bird-watching opportunities.',
    amenities: ['Bird Watching', 'Home-cooked Meals', 'Library', 'Cycling Tours'],
    icon: Icons.forest,
  ),
];

// ─────────────────────────────────────────────────────────────
// 🍽️ FOOD & CULTURE DATA
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
    description: 'A grand traditional platter featuring bajra rotla, ringna no olo (roasted brinjal), kadhi, dal, rice, buttermilk, and multiple accompaniments. The ultimate Gujarati feast!',
    bestFoundAt: 'Sasan village restaurants & Junagarh dhaba',
    isVeg: true,
    icon: Icons.rice_bowl,
  ),
  LocalDish(
    name: 'Bajra Rotla',
    description: 'Thick millet bread cooked on clay griddle, eaten with ghee and jaggery. A staple of the local Maldhari community living inside the forest.',
    bestFoundAt: 'Local homes & village dhabas',
    isVeg: true,
    icon: Icons.breakfast_dining,
  ),
  LocalDish(
    name: 'Khichdi with Kadhi',
    description: 'Comfort food of Gujarat — yellow moong dal cooked with rice, served with tangy yoghurt-based kadhi. Simple, wholesome, and nourishing.',
    bestFoundAt: 'All local restaurants',
    isVeg: true,
    icon: Icons.set_meal,
  ),
  LocalDish(
    name: 'Gir Kesar Mango',
    description: 'The world-famous GI-tagged Kesar mango grown in Gir orchards. Intensely aromatic, saffron-coloured pulp. Available May–July. Do not miss it!',
    bestFoundAt: 'Roadside stalls & Talala market (May–July)',
    isVeg: true,
    icon: Icons.eco,
  ),
  LocalDish(
    name: 'Sev Tameta',
    description: 'A simple but delicious dish of crispy sev (gram flour noodles) cooked with tomatoes and spices. A Saurashtra specialty eaten with rotla.',
    bestFoundAt: 'Street stalls in Sasan & Veraval',
    isVeg: true,
    icon: Icons.soup_kitchen,
  ),
  LocalDish(
    name: 'Gir Buffalo Milk Chai',
    description: 'Famous thick, creamy tea made with full-fat buffalo milk from the Maldhari community. Richer and creamier than regular chai.',
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
    description: 'The indigenous Maldhari people have lived inside the Gir forest for centuries alongside lions. They are buffalo and cattle herders who share a unique coexistence with wildlife. Visiting their nes (hamlet) is a once-in-a-lifetime cultural experience.',
    icon: Icons.people,
  ),
  CultureTradition(
    title: 'Siddi Tribe',
    description: 'The Siddis are an Afro-Indian community descended from African traders and soldiers. They live in the Gir region and perform the traditional Dhamal dance — a vibrant, rhythmic celebration of African and Indian heritage.',
    icon: Icons.celebration,
  ),
  CultureTradition(
    title: 'Navratri Celebrations',
    description: 'Gujarat\'s most beloved festival is celebrated grandly in Sasan and Junagarh. Locals and tourists dance Garba (circular folk dance) and Dandiya together for nine nights. A truly electric cultural experience.',
    icon: Icons.music_note,
  ),
  CultureTradition(
    title: 'Cow Worship & Panchayat',
    description: 'Cattle are considered sacred by the local Kathiyawadi community. Village Panchayats (local self-governance) remain very active. Cattle fairs (Pashu Mela) are periodically held near Talala.',
    icon: Icons.agriculture,
  ),
  CultureTradition(
    title: 'Traditional Craft — Leather & Jewelry',
    description: 'Local artisans craft beautiful hand-tooled leather items, silver jewelry, and embroidered textiles. Junagarh\'s old market is the best place to buy authentic handicrafts at fair prices.',
    icon: Icons.diamond_outlined,
  ),
];

// ─────────────────────────────────────────────────────────────
// 📍 NEARBY PLACES DATA
// ─────────────────────────────────────────────────────────────

class NearbyPlace {
  final String id;
  final String name;
  final String shortDescription;
  final String fullDescription;
  final String distance;
  final String bestTime;
  final String entryFee;
  final List<String> travelTips;
  final IconData icon;
  final Color color;

  const NearbyPlace({
    required this.id,
    required this.name,
    required this.shortDescription,
    required this.fullDescription,
    required this.distance,
    required this.bestTime,
    required this.entryFee,
    required this.travelTips,
    required this.icon,
    required this.color,
  });
}

final List<NearbyPlace> nearbyPlaces = [
  const NearbyPlace(
    id: 'somnath',
    name: 'Somnath Temple',
    shortDescription: 'One of the 12 Jyotirlingas of Lord Shiva',
    fullDescription: '''Somnath Temple is one of the most sacred Hindu shrines in India and one of the 12 Jyotirlingas dedicated to Lord Shiva. Located on the western coast of Gujarat at Prabhas Patan, the temple has been built, destroyed, and rebuilt multiple times throughout history, symbolising India's resilience and spiritual strength.

The current temple was built in the Chalukya style of Hindu architecture using red Chalukya sandstone. The temple faces the sea, and a pillar inscription (Baan Stambha) reads that from this point, across the sea, lies the Antarctic — symbolising the temple's primacy.

The Sound and Light show in the evening is a must-watch — it dramatically narrates the temple's history against the backdrop of the sea.''',
    distance: '45 km from Sasan Gir',
    bestTime: 'November – March | Evening for Sound & Light Show',
    entryFee: 'Free Entry | ₹25 for Sound & Light Show',
    travelTips: [
      'Dress modestly — traditional attire preferred',
      'Photography inside the sanctum is prohibited',
      'Evening aarti (6:30 PM) is very atmospheric',
      'Sound & Light Show starts at 8:00 PM',
      'Nearby Triveni Sangam (3 rivers meeting sea) is worth visiting',
    ],
    icon: Icons.temple_hindu,
    color: Color(0xFFFF8F00),
  ),
  const NearbyPlace(
    id: 'devalia',
    name: 'Devalia Safari Park',
    shortDescription: 'Enclosed lion safari — guaranteed sightings',
    fullDescription: '''Devalia Safari Park, also known as Gir Interpretation Zone, is an enclosed 4 sq km fenced area within the larger Gir National Park. It provides a more controlled and guaranteed wildlife-viewing experience compared to the main safari.

Unlike the main forest where animal sightings depend on luck, Devalia offers near-guaranteed sightings of Asiatic lions, leopards, spotted deer, crocodiles, sambars, and various bird species from the comfort of a dedicated bus.

The bus tour covers designated forest tracks inside the enclosure. The park is ideal for families, senior citizens, and those wanting a shorter but more certain wildlife experience.''',
    distance: '12 km from Sasan Gir',
    bestTime: 'October – June | Avoid midday in summer',
    entryFee: '₹75 Indians | ₹1,200 Foreigners (Bus included)',
    travelTips: [
      'No private vehicles — government bus only',
      'Better for families as lion sightings are near-guaranteed',
      'Book tickets at Devalia counter or Sasan office',
      'Combine with main Sasan safari on the same day',
      'Best light for photography: morning session',
    ],
    icon: Icons.local_activity,
    color: Color(0xFF2E7D32),
  ),
  const NearbyPlace(
    id: 'girnar',
    name: 'Girnar Hills',
    shortDescription: 'Sacred Jain hills with 10,000 steps',
    fullDescription: '''Girnar is a group of mountains near Junagarh with immense religious significance for both Jains and Hindus. The hills are home to several ancient temples and are considered one of the most important pilgrimage sites in Gujarat.

The main pilgrimage involves climbing approximately 9,999 stone steps (often rounded to 10,000) to reach the various temples at different elevations. The highest peak, Gorakhnath (1,117 m), is sacred to the Hindu Nath tradition. The Jain temples on the Girnar summit date back to the 12th century.

Girnar Ropeway (recently inaugurated by PM Modi) is also available for those who cannot climb, making this sacred site accessible to all. The view from the summit, particularly at sunrise, is breathtakingly beautiful.''',
    distance: '60 km from Sasan Gir',
    bestTime: 'October – February | Maha Shivratri for Bhavnath fair',
    entryFee: 'Free | Ropeway ₹700 (return) | ₹130 one-way',
    travelTips: [
      'Start climbing before 5 AM to avoid heat',
      'Wear comfortable walking shoes — no slippers!',
      'Palanquin (doli) services available for elderly',
      'Bhavnath Mahadev fair during Shivratri is spectacular',
      'Carry water and light snacks for the climb',
    ],
    icon: Icons.terrain,
    color: Color(0xFF5D4037),
  ),
  const NearbyPlace(
    id: 'veraval',
    name: 'Veraval Beach',
    shortDescription: 'Historic fishing port and coastal town',
    fullDescription: '''Veraval is an ancient coastal city and one of India's busiest fishing ports, located just minutes from Somnath Temple. The town has rich maritime heritage — it was from here that Arab traders and explorers set sail centuries ago.

The bustling fish market at the port is an experience unlike any other — colourful fishing boats, fresh catch being unloaded, and the vibrant energy of the fishing community. Veraval's beach is popular for evening walks with stunning sunsets over the Arabian Sea.

Nearby is the ancient Bhalka Tirth, the spot where Lord Krishna is believed to have been struck by an arrow and departed from Earth — a significant Hindu pilgrimage site.''',
    distance: '40 km from Sasan Gir',
    bestTime: 'October – March | Avoid monsoon season',
    entryFee: 'Free',
    travelTips: [
      'Visit the fish market at 6 AM for an authentic experience',
      'Evenings are perfect for beach walks and sunsets',
      'Bhalka Tirth (Krishna\'s departure site) is nearby',
      'Try fresh seafood at Veraval\'s local restaurants',
      'Combine with Somnath Temple (just 5 km away)',
    ],
    icon: Icons.beach_access,
    color: Color(0xFF0277BD),
  ),
  const NearbyPlace(
    id: 'junagarh',
    name: 'Junagarh City',
    shortDescription: 'Ancient fort city with rich Nawabi heritage',
    fullDescription: '''Junagarh (meaning "Old Fort") is a historic city steeped in layers of history — from Ashokan edicts to Nawabi-era palaces. The city offers a fascinating mix of Hindu, Jain, and Islamic architecture and is often called the cultural capital of Saurashtra.

Uparkot Fort is a 2,300-year-old hillfort with ancient Buddhist caves, stepwells, and cannons. Mahabat Maqbara (the Nawab's tomb) is one of the most unique buildings in Gujarat — a stunning Indo-Islamic-European architectural hybrid with silver doors and minarets.

The Sakkarbaug Zoological Park houses one of India's finest zoos with Asiatic lions, while the market areas offer excellent Kathiyawadi food and local crafts.''',
    distance: '65 km from Sasan Gir',
    bestTime: 'October – March',
    entryFee: 'Uparkot Fort: ₹20 | Maqbara: Free | Zoo: ₹50',
    travelTips: [
      'Start with Uparkot Fort early morning for fewer crowds',
      'Mahabat Maqbara looks magical at sunset',
      'Try the famous Junagarh Jalebi and chikki',
      'Sakkarbaug Zoo is great for Asiatic lion sightings',
      'Friday market near the old city is colourful',
    ],
    icon: Icons.fort,
    color: Color(0xFF6A1B9A),
  ),
  const NearbyPlace(
    id: 'tulsi',
    name: 'Tulsi Shyam',
    shortDescription: 'Hot springs temple deep in the forest',
    fullDescription: '''Tulsi Shyam is a temple dedicated to Lord Vishnu (Shyam) located deep inside the Gir forest, known for its natural hot springs. The warm sulphur springs are believed to have medicinal properties and thousands of pilgrims come here to bathe.

The drive to Tulsi Shyam through the forest is itself remarkable — you may spot wildlife including deer, birds, and occasionally lions along the route. The temple has ancient carvings and a serene forest atmosphere.

The natural hot springs (kund) reach temperatures of 45–50°C and locals believe they can cure skin and joint ailments. The surrounding landscape of forested hills creates a spiritually calm environment.''',
    distance: '35 km from Sasan Gir',
    bestTime: 'October – April | Kartik Purnima is festive',
    entryFee: 'Free (Temple donation optional)',
    travelTips: [
      'Drive slowly through forest — wildlife crossing',
      'The hot spring water is very hot — test before entering',
      'Festival days are crowded but very vibrant',
      'Nearby Kankai Mata temple is also worth visiting',
      'No food stalls deep inside — carry snacks',
    ],
    icon: Icons.hot_tub,
    color: Color(0xFFE65100),
  ),
];

// ─────────────────────────────────────────────────────────────
// 🗓️ ITINERARY DATA
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
        description: 'Get ready early. Head to the Forest Entry Gate. Morning air is fresh and animals are most active.',
        location: 'Your Hotel',
        icon: Icons.hotel,
        color: Color(0xFF5D4037),
      ),
      ItineraryStep(
        time: '6:00 AM',
        activity: 'Morning Safari 🦁',
        description: 'Enter Sasan Gir for morning jeep safari. Best chance to spot Asiatic lions, deer, crocodiles, and exotic birds.',
        location: 'Sasan Gir Forest',
        icon: Icons.directions_car,
        color: Color(0xFF2E7D32),
      ),
      ItineraryStep(
        time: '9:30 AM',
        activity: 'Breakfast at Dhaba',
        description: 'Enjoy authentic Kathiyawadi breakfast — bajra rotla with ghee, chai, and local snacks at a village dhaba.',
        location: 'Sasan Village',
        icon: Icons.coffee,
        color: Color(0xFFFF8F00),
      ),
      ItineraryStep(
        time: '11:00 AM',
        activity: 'Devalia Safari Park 🐆',
        description: 'Visit the enclosed safari park for guaranteed lion and leopard sightings. Bus tour takes 45–60 minutes.',
        location: 'Devalia, 12 km',
        icon: Icons.local_activity,
        color: Color(0xFF1565C0),
      ),
      ItineraryStep(
        time: '1:00 PM',
        activity: 'Lunch Break',
        description: 'Traditional Kathiyawadi Thali at a local restaurant. Try sev tameta, kadhi, and fresh buttermilk.',
        location: 'Sasan or Devalia',
        icon: Icons.restaurant,
        color: Color(0xFFE65100),
      ),
      ItineraryStep(
        time: '2:30 PM',
        activity: 'Drive to Veraval Beach',
        description: 'Scenic coastal drive through Gir forests. Reach the Arabian Sea coast of Veraval.',
        location: 'Veraval, 40 km',
        icon: Icons.directions_car,
        color: Color(0xFF0277BD),
      ),
      ItineraryStep(
        time: '4:00 PM',
        activity: 'Somnath Temple 🛕',
        description: 'Visit the sacred Jyotirlinga temple. Evening aarti at 6:30 PM is spectacular. Sound & Light show at 8 PM.',
        location: 'Somnath, 45 km',
        icon: Icons.temple_hindu,
        color: Color(0xFFFF8F00),
      ),
      ItineraryStep(
        time: '8:00 PM',
        activity: 'Sound & Light Show',
        description: 'Watch the dramatic narration of Somnath\'s history at the temple grounds. Return to Sasan or hotel.',
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
        activity: 'Morning Safari 🦁',
        description: 'Prime time for wildlife. Board the Gypsy jeep for the main forest safari. Keep camera ready!',
        location: 'Sasan Gir Forest',
        icon: Icons.directions_car,
        color: Color(0xFF2E7D32),
      ),
      ItineraryStep(
        time: '9:30 AM',
        activity: 'Forest Breakfast',
        description: 'Fresh morning breakfast. Try local chai and bajra khichdi at a dhaba near the forest gate.',
        location: 'Sasan Village',
        icon: Icons.coffee,
        color: Color(0xFFFF8F00),
      ),
      ItineraryStep(
        time: '11:00 AM',
        activity: 'Devalia Safari Park',
        description: 'Enclosed 4 sq km safari with guaranteed wildlife sightings — lions, leopards, deer and crocodiles.',
        location: 'Devalia, 12 km',
        icon: Icons.local_activity,
        color: Color(0xFF1565C0),
      ),
      ItineraryStep(
        time: '1:00 PM',
        activity: 'Village Cultural Walk',
        description: 'Walk through Sasan village. Visit a Maldhari hamlet. See traditional clay houses and cattle culture.',
        location: 'Sasan Village',
        icon: Icons.people,
        color: Color(0xFF5D4037),
      ),
      ItineraryStep(
        time: '3:00 PM',
        activity: 'Evening Safari 🐊',
        description: 'Second safari of the day! Evening golden light is best for photography. Spot crocodiles near Hiran river.',
        location: 'Sasan Gir Forest',
        icon: Icons.directions_car,
        color: Color(0xFF2E7D32),
      ),
      ItineraryStep(
        time: '6:30 PM',
        activity: 'Campfire Dinner 🔥',
        description: 'Return to lodge. Enjoy a traditional Kathiyawadi thali dinner with campfire experience.',
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
        description: 'Start early for the coastal drive. Watch sunrise over the Arabian Sea near Somnath.',
        location: 'Somnath, 45 km',
        icon: Icons.directions_car,
        color: Color(0xFF0277BD),
      ),
      ItineraryStep(
        time: '7:30 AM',
        activity: 'Morning Aarti at Somnath 🛕',
        description: 'Attend the morning prayer ceremony at the sacred Somnath Jyotirlinga temple. Deeply spiritual experience.',
        location: 'Somnath Temple',
        icon: Icons.temple_hindu,
        color: Color(0xFFFF8F00),
      ),
      ItineraryStep(
        time: '9:30 AM',
        activity: 'Veraval Fish Market',
        description: 'Walk through Veraval\'s famous fish market at the port — colourful boats, fresh catch, and vibrant atmosphere.',
        location: 'Veraval Port',
        icon: Icons.sailing,
        color: Color(0xFF0277BD),
      ),
      ItineraryStep(
        time: '11:30 AM',
        activity: 'Drive to Junagarh',
        description: 'Head inland to the historic fort city of Junagarh, known for its Nawabi heritage and ancient fort.',
        location: 'Junagarh, 65 km',
        icon: Icons.directions_car,
        color: Color(0xFF5D4037),
      ),
      ItineraryStep(
        time: '1:00 PM',
        activity: 'Lunch in Junagarh',
        description: 'Famous Junagarh Jalebi and local chaat. Try the Kesar milkshake and fresh sweets from the old market.',
        location: 'Junagarh Old Market',
        icon: Icons.restaurant,
        color: Color(0xFFE65100),
      ),
      ItineraryStep(
        time: '2:00 PM',
        activity: 'Uparkot Fort & Mahabat Maqbara',
        description: 'Explore the 2,300-year-old fort and the stunning silver-doored Nawab\'s tomb. History comes alive!',
        location: 'Junagarh Fort',
        icon: Icons.fort,
        color: Color(0xFF6A1B9A),
      ),
      ItineraryStep(
        time: '4:00 PM',
        activity: 'Local Shopping 🛍️',
        description: 'Buy handicrafts, leather items, Gir honey, Kesar aam pickles, and authentic Kathiyawadi souvenirs.',
        location: 'Junagarh Market',
        icon: Icons.shopping_bag,
        color: Color(0xFF2E7D32),
      ),
      ItineraryStep(
        time: '6:00 PM',
        activity: 'Return Journey',
        description: 'Head back home or to the nearest railway station (Junagadh / Veraval). Memories last a lifetime! 🌿',
        location: 'Departure',
        icon: Icons.flight_takeoff,
        color: Color(0xFF5D4037),
      ),
    ],
  ),
];

// ─────────────────────────────────────────────────────────────
// 🗺️ MAP LOCATIONS DATA
// ─────────────────────────────────────────────────────────────

class MapLocation {
  final String name;
  final String category;
  final String shortInfo;
  final String distance;
  final IconData icon;
  final Color color;
  final double relX; // Relative X position (0.0 – 1.0) on map image
  final double relY; // Relative Y position (0.0 – 1.0) on map image

  const MapLocation({
    required this.name,
    required this.category,
    required this.shortInfo,
    required this.distance,
    required this.icon,
    required this.color,
    required this.relX,
    required this.relY,
  });
}

const List<MapLocation> mapLocations = [
  MapLocation(
    name: 'Sasan Gir',
    category: 'Forest / Safari',
    shortInfo: 'Main forest entry — Asiatic lion habitat',
    distance: 'Base location',
    icon: Icons.forest,
    color: Color(0xFF2E7D32),
    relX: 0.45,
    relY: 0.42,
  ),
  MapLocation(
    name: 'Devalia Safari Park',
    category: 'Safari',
    shortInfo: 'Enclosed lion safari — 12 km from Sasan',
    distance: '12 km',
    icon: Icons.local_activity,
    color: Color(0xFF388E3C),
    relX: 0.38,
    relY: 0.36,
  ),
  MapLocation(
    name: 'Somnath Temple',
    category: 'Religious',
    shortInfo: 'Sacred Jyotirlinga on the coast',
    distance: '45 km',
    icon: Icons.temple_hindu,
    color: Color(0xFFFF8F00),
    relX: 0.40,
    relY: 0.72,
  ),
  MapLocation(
    name: 'Veraval Beach',
    category: 'Coastal',
    shortInfo: 'Fishing port & beach',
    distance: '40 km',
    icon: Icons.beach_access,
    color: Color(0xFF0277BD),
    relX: 0.36,
    relY: 0.78,
  ),
  MapLocation(
    name: 'Junagarh City',
    category: 'Heritage',
    shortInfo: 'Historic fort city with Nawabi heritage',
    distance: '65 km',
    icon: Icons.fort,
    color: Color(0xFF6A1B9A),
    relX: 0.55,
    relY: 0.28,
  ),
  MapLocation(
    name: 'Girnar Hills',
    category: 'Pilgrimage / Trek',
    shortInfo: 'Sacred hills with 10,000 steps',
    distance: '60 km',
    icon: Icons.terrain,
    color: Color(0xFF5D4037),
    relX: 0.60,
    relY: 0.32,
  ),
  MapLocation(
    name: 'Tulsi Shyam',
    category: 'Temple / Hot Springs',
    shortInfo: 'Hot springs temple in forest',
    distance: '35 km',
    icon: Icons.hot_tub,
    color: Color(0xFFE65100),
    relX: 0.30,
    relY: 0.48,
  ),
];

// ─────────────────────────────────────────────────────────────
// ℹ️ QUICK FACTS
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

// ─────────────────────────────────────────────────────────────
// 🌿 ECO TIPS
// ─────────────────────────────────────────────────────────────

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
