// lib/data/extra_data.dart
// Additional static data for real-life usage:
//   Transport routes, Emergency contacts, Packing checklist,
//   Monthly seasonal calendar, Weather guide, Forest tips

import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────
// 🚌 TRANSPORT / HOW TO REACH
// ─────────────────────────────────────────────────────────────

class TransportOption {
  final String mode;
  final String from;
  final String duration;
  final String distance;
  final String frequency;
  final String fare;
  final String tips;
  final IconData icon;
  final Color color;

  const TransportOption({
    required this.mode,
    required this.from,
    required this.duration,
    required this.distance,
    required this.frequency,
    required this.fare,
    required this.tips,
    required this.icon,
    required this.color,
  });
}

const List<TransportOption> transportOptions = [
  TransportOption(
    mode: 'By Air',
    from: 'Rajkot Airport (RAJ)',
    duration: '~3.5 hrs (drive)',
    distance: '160 km from Sasan Gir',
    frequency: 'Daily flights from Mumbai, Delhi, Ahmedabad',
    fare: '₹3,000 – ₹8,000 (air) + ₹1,500 taxi',
    tips:
        'Book Rajkot–Sasan Gir taxi in advance from airport prepaid booth. Best airport for Gir.',
    icon: Icons.flight,
    color: Color(0xFF0277BD),
  ),
  TransportOption(
    mode: 'By Train',
    from: 'Veraval Railway Station',
    duration: '1 hr (drive from Veraval)',
    distance: '40 km from Sasan Gir',
    frequency: 'Multiple trains daily from Ahmedabad, Rajkot, Mumbai',
    fare: '₹150 – ₹1,200 (class-dependent)',
    tips:
        'Saurashtra Mail & Saurashtra Express are most convenient. Auto/taxi from Veraval station to Sasan Gir: ₹300–₹500.',
    icon: Icons.train,
    color: Color(0xFF2E7D32),
  ),
  TransportOption(
    mode: 'By Bus (GSRTC)',
    from: 'Ahmedabad / Rajkot / Junagadh',
    duration: '5–9 hrs from Ahmedabad',
    distance: '390 km from Ahmedabad',
    frequency: 'Multiple departures from Junagadh daily',
    fare: '₹80 – ₹400',
    tips:
        'Junagadh → Talala → Sasan Gir is the most direct route. Private Volvo buses also available from Rajkot.',
    icon: Icons.directions_bus,
    color: Color(0xFFE65100),
  ),
  TransportOption(
    mode: 'By Car / Road',
    from: 'Ahmedabad via NH 27',
    duration: '5.5 hrs from Ahmedabad',
    distance: '390 km via Rajkot',
    frequency: 'Self-drive or hired cab',
    fare: '₹3,000–₹5,000 (Ahmedabad cab)',
    tips:
        'NH 27 via Rajkot is well-maintained. Fuel up at Talala (last major town). Drive slowly through Gir buffer zone — wildlife crossing.',
    icon: Icons.directions_car,
    color: Color(0xFF5D4037),
  ),
];

class NearbyStation {
  final String name;
  final String type;
  final String distance;
  final String code;
  final IconData icon;

  const NearbyStation({
    required this.name,
    required this.type,
    required this.distance,
    required this.code,
    required this.icon,
  });
}

const List<NearbyStation> nearbyStations = [
  NearbyStation(
      name: 'Veraval',
      type: 'Railway Station',
      distance: '40 km',
      code: 'VRL',
      icon: Icons.train),
  NearbyStation(
      name: 'Junagadh',
      type: 'Railway Station',
      distance: '65 km',
      code: 'JND',
      icon: Icons.train),
  NearbyStation(
      name: 'Keshod',
      type: 'Airport',
      distance: '55 km',
      code: 'IXK',
      icon: Icons.flight),
  NearbyStation(
      name: 'Rajkot',
      type: 'Airport',
      distance: '160 km',
      code: 'RAJ',
      icon: Icons.flight),
  NearbyStation(
      name: 'Talala Gir',
      type: 'Bus Stand',
      distance: '12 km',
      code: '—',
      icon: Icons.directions_bus),
  NearbyStation(
      name: 'Sasan Gir',
      type: 'Bus Stop',
      distance: '0 km',
      code: '—',
      icon: Icons.directions_bus),
];

// ─────────────────────────────────────────────────────────────
// 🆘 EMERGENCY CONTACTS
// ─────────────────────────────────────────────────────────────

class EmergencyContact {
  final String name;
  final String number;
  final String category;
  final String note;
  final IconData icon;
  final Color color;

  const EmergencyContact({
    required this.name,
    required this.number,
    required this.category,
    required this.note,
    required this.icon,
    required this.color,
  });
}

const List<EmergencyContact> emergencyContacts = [
  EmergencyContact(
    name: 'Police (National)',
    number: '100',
    category: 'Police',
    note: 'Available 24/7 — dial in any emergency',
    icon: Icons.local_police,
    color: Color(0xFF1565C0),
  ),
  EmergencyContact(
    name: 'Ambulance (National)',
    number: '108',
    category: 'Medical',
    note: 'Free emergency ambulance service, Gujarat',
    icon: Icons.local_hospital,
    color: Color(0xFFD32F2F),
  ),
  EmergencyContact(
    name: 'Forest Dept. (Sasan)',
    number: '02877-285541',
    category: 'Forest',
    note: 'Gir forest office — safari bookings & wildlife emergency',
    icon: Icons.forest,
    color: Color(0xFF2E7D32),
  ),
  EmergencyContact(
    name: 'Sasan Gir Police Station',
    number: '02877-222233',
    category: 'Police',
    note: 'Local police — nearest station to Sasan',
    icon: Icons.local_police,
    color: Color(0xFF1565C0),
  ),
  EmergencyContact(
    name: 'Civil Hospital Junagadh',
    number: '0285-2654503',
    category: 'Medical',
    note: 'Nearest major government hospital — 65 km',
    icon: Icons.local_hospital,
    color: Color(0xFFD32F2F),
  ),
  EmergencyContact(
    name: 'Wildlife Crime Control',
    number: '1800-11-9334',
    category: 'Wildlife',
    note: 'Report poaching or wildlife crime (toll-free)',
    icon: Icons.pets,
    color: Color(0xFFFF8F00),
  ),
  EmergencyContact(
    name: 'Tourist Helpline (Gujarat)',
    number: '1800-203-1111',
    category: 'Tourism',
    note: 'Gujarat Tourism official helpline (toll-free)',
    icon: Icons.headset_mic,
    color: Color(0xFF6A1B9A),
  ),
  EmergencyContact(
    name: 'Fire (National)',
    number: '101',
    category: 'Fire',
    note: 'Forest fire or building fire emergency',
    icon: Icons.local_fire_department,
    color: Color(0xFFE65100),
  ),
];

class FirstAidTip {
  final String situation;
  final String immediateAction;
  final List<String> steps;
  final String callNumber;
  final IconData icon;
  final Color color;

  const FirstAidTip({
    required this.situation,
    required this.immediateAction,
    required this.steps,
    required this.callNumber,
    required this.icon,
    required this.color,
  });
}

const List<FirstAidTip> firstAidTips = [
  FirstAidTip(
    situation: 'Lion / Animal Encounter',
    immediateAction: 'Do NOT run. Stay still and calm.',
    steps: [
      'Remain completely still — sudden movement triggers chase instinct',
      'Do not make eye contact with the lion directly',
      'Stay inside the vehicle at all times during safari',
      'Alert your guide immediately with a soft voice',
      'If outside, slowly back away without turning your back',
      'Call forest dept: 02877-285541 immediately after',
    ],
    callNumber: '02877-285541',
    icon: Icons.warning_amber,
    color: Color(0xFFFF8F00),
  ),
  FirstAidTip(
    situation: 'Snakebite',
    immediateAction: 'Immobilise the bitten limb immediately.',
    steps: [
      'Keep the victim calm and still — movement spreads venom faster',
      'Immobilise the bitten limb below heart level',
      'Remove jewellery and tight clothing near bite',
      'Do NOT cut the wound, suck venom, or apply tourniquet',
      'Note the snake description (colour, size) for doctors',
      'Rush to Civil Hospital Junagadh — 65 km away',
    ],
    callNumber: '108',
    icon: Icons.pest_control,
    color: Color(0xFFD32F2F),
  ),
  FirstAidTip(
    situation: 'Heatstroke / Dehydration',
    immediateAction: 'Move to shade. Cool down immediately.',
    steps: [
      'Move person to shade or air-conditioned vehicle',
      'Remove excess clothing',
      'Apply cool water/wet cloth to neck, armpits, groin',
      'Give ORS (Oral Rehydration Salts) or plain water if conscious',
      'Fan the person continuously',
      'Call 108 if unconscious or seizures occur',
    ],
    callNumber: '108',
    icon: Icons.thermostat,
    color: Color(0xFFE65100),
  ),
  FirstAidTip(
    situation: 'Lost in Forest',
    immediateAction: 'Stop. Stay where you are. Call for help.',
    steps: [
      'Do NOT wander further — you\'ll get more lost',
      'Stay in one place and make noise periodically',
      'Use phone torch/flashlight to signal at night',
      'If you have mobile signal, call forest dept immediately',
      'Stay on the trail or road you last knew',
      'Rescue teams operate from Sasan Gate — you will be found',
    ],
    callNumber: '02877-285541',
    icon: Icons.location_off,
    color: Color(0xFF6A1B9A),
  ),
];

// ─────────────────────────────────────────────────────────────
// ✅ PACKING CHECKLIST
// ─────────────────────────────────────────────────────────────

class ChecklistCategory {
  final String category;
  final IconData icon;
  final Color color;
  final List<ChecklistItem> items;

  const ChecklistCategory({
    required this.category,
    required this.icon,
    required this.color,
    required this.items,
  });
}

class ChecklistItem {
  final String item;
  final bool isEssential;
  final String? note;

  const ChecklistItem({
    required this.item,
    this.isEssential = false,
    this.note,
  });
}

const List<ChecklistCategory> checklistCategories = [
  ChecklistCategory(
    category: 'Safari Essentials',
    icon: Icons.directions_car,
    color: Color(0xFF2E7D32),
    items: [
      ChecklistItem(
          item: 'Safari booking confirmation',
          isEssential: true,
          note: 'Digital or printed copy'),
      ChecklistItem(
          item: 'Valid photo ID (Aadhaar / Passport)', isEssential: true),
      ChecklistItem(
          item: 'Binoculars',
          isEssential: false,
          note: 'Greatly enhances wildlife viewing'),
      ChecklistItem(item: 'Camera with extra batteries', isEssential: false),
      ChecklistItem(item: 'Extra memory cards', isEssential: false),
      ChecklistItem(item: 'Lens cleaning cloth', isEssential: false),
      ChecklistItem(item: 'Tripod / monopod (lightweight)', isEssential: false),
    ],
  ),
  ChecklistCategory(
    category: 'Clothing',
    icon: Icons.checkroom,
    color: Color(0xFF5D4037),
    items: [
      ChecklistItem(
          item: 'Earth-toned clothes (green, brown, khaki)',
          isEssential: true,
          note: 'Avoid bright colours in forest'),
      ChecklistItem(
          item: 'Light jacket for morning safari',
          isEssential: true,
          note: 'Forest is cool at 6 AM'),
      ChecklistItem(
          item: 'Full-sleeve shirts (sun + insect protection)',
          isEssential: true),
      ChecklistItem(
          item: 'Comfortable walking shoes / hiking boots', isEssential: true),
      ChecklistItem(item: 'Wide-brim hat or cap', isEssential: false),
      ChecklistItem(item: 'Sunglasses', isEssential: false),
      ChecklistItem(
          item: 'Rain poncho (monsoon or unpredictable weather)',
          isEssential: false),
      ChecklistItem(
          item: 'Modest clothing for temple visits',
          isEssential: false,
          note: 'Required at Somnath & Girnar'),
    ],
  ),
  ChecklistCategory(
    category: 'Health & Safety',
    icon: Icons.medical_services,
    color: Color(0xFFD32F2F),
    items: [
      ChecklistItem(item: 'Sunscreen SPF 50+', isEssential: true),
      ChecklistItem(
          item: 'Insect repellent (DEET-based)',
          isEssential: true,
          note: 'Mosquitoes active at dawn/dusk'),
      ChecklistItem(item: 'Personal prescription medicines', isEssential: true),
      ChecklistItem(item: 'ORS sachets (dehydration)', isEssential: true),
      ChecklistItem(item: 'Basic first aid kit', isEssential: true),
      ChecklistItem(item: 'Antidiarrhoeal tablets', isEssential: false),
      ChecklistItem(item: 'Antihistamine (allergies)', isEssential: false),
      ChecklistItem(item: 'Antiseptic cream', isEssential: false),
      ChecklistItem(item: 'Paracetamol / pain reliever', isEssential: false),
    ],
  ),
  ChecklistCategory(
    category: 'Documents & Money',
    icon: Icons.account_balance_wallet,
    color: Color(0xFFFF8F00),
    items: [
      ChecklistItem(item: 'Government photo ID (original)', isEssential: true),
      ChecklistItem(item: 'Hotel booking confirmation', isEssential: true),
      ChecklistItem(
          item: 'Cash in Indian Rupees',
          isEssential: true,
          note: 'Many dhabas don\'t accept cards'),
      ChecklistItem(
          item: 'UPI app / digital payments setup', isEssential: false),
      ChecklistItem(item: 'Travel insurance document', isEssential: false),
      ChecklistItem(
          item: 'Emergency contact list (printed)', isEssential: true),
      ChecklistItem(item: 'Printed map / offline map app', isEssential: false),
    ],
  ),
  ChecklistCategory(
    category: 'Food & Water',
    icon: Icons.water_drop,
    color: Color(0xFF0277BD),
    items: [
      ChecklistItem(
          item: 'Reusable water bottle (1 litre+)',
          isEssential: true,
          note: 'Eco-friendly, no plastic in forest'),
      ChecklistItem(item: 'Water purification tablets', isEssential: false),
      ChecklistItem(
          item: 'Energy bars / trail mix',
          isEssential: false,
          note: 'For long safari drives'),
      ChecklistItem(item: 'Dry fruits & nuts', isEssential: false),
      ChecklistItem(item: 'Electrolyte powder sachets', isEssential: false),
    ],
  ),
  ChecklistCategory(
    category: 'Gadgets & Misc',
    icon: Icons.devices,
    color: Color(0xFF6A1B9A),
    items: [
      ChecklistItem(item: 'Fully charged mobile phone', isEssential: true),
      ChecklistItem(
          item: 'Power bank (20,000 mAh)',
          isEssential: true,
          note: 'No charging inside forest'),
      ChecklistItem(item: 'Charging cables for all devices', isEssential: true),
      ChecklistItem(item: 'Torch / flashlight', isEssential: false),
      ChecklistItem(item: 'Whistle (safety signal)', isEssential: false),
      ChecklistItem(item: 'Pocket knife / multi-tool', isEssential: false),
      ChecklistItem(
          item: 'Reusable carry bags (no plastic)',
          isEssential: true,
          note: 'Mandatory eco-rule'),
      ChecklistItem(item: 'Small backpack / daypack', isEssential: false),
    ],
  ),
];

// Flat list for global indexing (used by AppState checklist)
List<String> get allChecklistItems => checklistCategories
    .expand((cat) => cat.items.map((item) => item.item))
    .toList();

// ─────────────────────────────────────────────────────────────
// 📅 SEASONAL CALENDAR
// ─────────────────────────────────────────────────────────────

class MonthInfo {
  final String month;
  final String shortMonth;
  final int monthIndex; // 1–12
  final String weather;
  final String temperature;
  final String forestStatus;
  final String wildlifeActivity;
  final String crowdLevel; // 'Low' | 'Medium' | 'High' | 'Peak'
  final String specialEvents;
  final List<String> highlights;
  final Color statusColor;
  final bool isOpen;

  const MonthInfo({
    required this.month,
    required this.shortMonth,
    required this.monthIndex,
    required this.weather,
    required this.temperature,
    required this.forestStatus,
    required this.wildlifeActivity,
    required this.crowdLevel,
    required this.specialEvents,
    required this.highlights,
    required this.statusColor,
    required this.isOpen,
  });
}

const List<MonthInfo> seasonalCalendar = [
  MonthInfo(
    month: 'January',
    shortMonth: 'Jan',
    monthIndex: 1,
    weather: 'Cool & Dry',
    temperature: '13°C – 27°C',
    forestStatus: 'Open',
    wildlifeActivity: 'Excellent — lions very active in the cool mornings',
    crowdLevel: 'High',
    specialEvents: 'Uttarayan kite festival (14 Jan) in nearby towns',
    highlights: [
      'Best photography light',
      'High lion sighting probability',
      'Birds migrating in'
    ],
    statusColor: Color(0xFF2E7D32),
    isOpen: true,
  ),
  MonthInfo(
    month: 'February',
    shortMonth: 'Feb',
    monthIndex: 2,
    weather: 'Pleasant & Clear',
    temperature: '15°C – 30°C',
    forestStatus: 'Open',
    wildlifeActivity: 'Excellent — ideal conditions across the board',
    crowdLevel: 'High',
    specialEvents: 'Bhavnath fair near Junagadh (Maha Shivratri)',
    highlights: [
      'Ideal weather',
      'Migratory birds present',
      'Clear forest views'
    ],
    statusColor: Color(0xFF2E7D32),
    isOpen: true,
  ),
  MonthInfo(
    month: 'March',
    shortMonth: 'Mar',
    monthIndex: 3,
    weather: 'Warm & Dry',
    temperature: '20°C – 36°C',
    forestStatus: 'Open',
    wildlifeActivity: 'Very good — animals near water sources',
    crowdLevel: 'Medium',
    specialEvents: 'Holi festival — colourful celebrations in Saurashtra',
    highlights: [
      'Animals near waterholes',
      'Fewer tourists',
      'Good value deals'
    ],
    statusColor: Color(0xFF388E3C),
    isOpen: true,
  ),
  MonthInfo(
    month: 'April',
    shortMonth: 'Apr',
    monthIndex: 4,
    weather: 'Hot & Dry',
    temperature: '25°C – 40°C',
    forestStatus: 'Open',
    wildlifeActivity: 'Good — lions rest in shade; best at dawn/dusk',
    crowdLevel: 'Medium',
    specialEvents: 'Navratri preparations begin',
    highlights: [
      'Best deals on hotels',
      'Concentrated at waterholes',
      'Fewer queues'
    ],
    statusColor: Color(0xFF558B2F),
    isOpen: true,
  ),
  MonthInfo(
    month: 'May',
    shortMonth: 'May',
    monthIndex: 5,
    weather: 'Very Hot',
    temperature: '30°C – 44°C',
    forestStatus: 'Open',
    wildlifeActivity: 'Good — animals predictably near water all day',
    crowdLevel: 'Low',
    specialEvents: 'Kesar mango season begins — try Gir mangoes!',
    highlights: [
      'Kesar mango season 🥭',
      'Animals very predictable',
      'Cheapest hotel rates'
    ],
    statusColor: Color(0xFFFF8F00),
    isOpen: true,
  ),
  MonthInfo(
    month: 'June',
    shortMonth: 'Jun',
    monthIndex: 6,
    weather: 'Pre-monsoon / Hot',
    temperature: '28°C – 42°C',
    forestStatus: 'Closing mid-June',
    wildlifeActivity: 'Moderate — forest closing soon after 15 June',
    crowdLevel: 'Very Low',
    specialEvents: 'Last chance before closure — monsoon prep',
    highlights: [
      'Last safaris before closure',
      'Very low tourist numbers',
      'Mangoes in full season'
    ],
    statusColor: Color(0xFFE65100),
    isOpen: true,
  ),
  MonthInfo(
    month: 'July',
    shortMonth: 'Jul',
    monthIndex: 7,
    weather: 'Monsoon — Heavy Rain',
    temperature: '25°C – 33°C',
    forestStatus: '⛔ CLOSED',
    wildlifeActivity: 'Forest closed to tourists — breeding season',
    crowdLevel: 'None',
    specialEvents: 'Lion breeding & cub-rearing season',
    highlights: [
      'Forest is CLOSED',
      'Plan alternate Gujarat destinations',
      'Somnath beach visits possible'
    ],
    statusColor: Color(0xFFD32F2F),
    isOpen: false,
  ),
  MonthInfo(
    month: 'August',
    shortMonth: 'Aug',
    monthIndex: 8,
    weather: 'Monsoon — Moderate Rain',
    temperature: '24°C – 32°C',
    forestStatus: '⛔ CLOSED',
    wildlifeActivity: 'Forest closed — animals thriving in private',
    crowdLevel: 'None',
    specialEvents: 'Independence Day (15 Aug) celebrations',
    highlights: [
      'Forest is CLOSED',
      'Girnar is green & beautiful',
      'Somnath is accessible'
    ],
    statusColor: Color(0xFFD32F2F),
    isOpen: false,
  ),
  MonthInfo(
    month: 'September',
    shortMonth: 'Sep',
    monthIndex: 9,
    weather: 'Late Monsoon',
    temperature: '24°C – 33°C',
    forestStatus: '⛔ CLOSED',
    wildlifeActivity: 'Forest closed — reopening preparation underway',
    crowdLevel: 'None',
    specialEvents: 'Navratri begins late September / early October',
    highlights: [
      'Forest is CLOSED',
      'Girnar trekking season opens',
      'Navratri festivities'
    ],
    statusColor: Color(0xFFD32F2F),
    isOpen: false,
  ),
  MonthInfo(
    month: 'October',
    shortMonth: 'Oct',
    monthIndex: 10,
    weather: 'Post-monsoon / Pleasant',
    temperature: '22°C – 35°C',
    forestStatus: 'Open from 16 Oct',
    wildlifeActivity: 'Very good — lush green forest, wildlife energetic',
    crowdLevel: 'Medium',
    specialEvents: 'Navratri festival — Garba dancing across Gujarat',
    highlights: [
      'Forest reopens!',
      'Green & fresh landscape',
      'Navratri cultural experience'
    ],
    statusColor: Color(0xFF2E7D32),
    isOpen: true,
  ),
  MonthInfo(
    month: 'November',
    shortMonth: 'Nov',
    monthIndex: 11,
    weather: 'Cool & Comfortable',
    temperature: '16°C – 30°C',
    forestStatus: 'Open',
    wildlifeActivity: 'Outstanding — best month overall',
    crowdLevel: 'Peak',
    specialEvents: 'Diwali festival — spectacular fireworks in Junagadh',
    highlights: [
      'BEST month to visit',
      'Maximum lion activity',
      'Perfect weather',
      'Diwali celebrations'
    ],
    statusColor: Color(0xFF1B5E20),
    isOpen: true,
  ),
  MonthInfo(
    month: 'December',
    shortMonth: 'Dec',
    monthIndex: 12,
    weather: 'Cool & Dry',
    temperature: '13°C – 26°C',
    forestStatus: 'Open',
    wildlifeActivity: 'Excellent — cool weather keeps animals very active',
    crowdLevel: 'Peak',
    specialEvents: 'New Year celebrations, winter bird watching',
    highlights: [
      'Peak tourist season',
      'Book 3 weeks ahead',
      'Excellent birdwatching',
      'Christmas wildlife camps'
    ],
    statusColor: Color(0xFF1B5E20),
    isOpen: true,
  ),
];

// ─────────────────────────────────────────────────────────────
// 🦜 DID YOU KNOW — Wildlife Facts
// ─────────────────────────────────────────────────────────────

class WildlifeFact {
  final String animal;
  final String fact;
  final String emoji;
  final Color color;

  const WildlifeFact({
    required this.animal,
    required this.fact,
    required this.emoji,
    required this.color,
  });
}

const List<WildlifeFact> wildlifeFacts = [
  WildlifeFact(
    animal: 'Asiatic Lion',
    fact:
        'Unlike African lions, Asiatic lions live in small family groups called prides. Males here often live separately from females except during mating.',
    emoji: '🦁',
    color: Color(0xFFFF8F00),
  ),
  WildlifeFact(
    animal: 'Indian Leopard',
    fact:
        'Leopards in Gir are highly adaptable and often found in the buffer zones. They are mostly nocturnal and expert tree climbers.',
    emoji: '🐆',
    color: Color(0xFF5D4037),
  ),
  WildlifeFact(
    animal: 'Mugger Crocodile',
    fact:
        'The Hiran River in Gir has one of India\'s highest densities of mugger crocodiles. They regulate their body temperature by basking on banks.',
    emoji: '🐊',
    color: Color(0xFF2E7D32),
  ),
  WildlifeFact(
    animal: 'Indian Porcupine',
    fact:
        'One of the most common but rarely seen animals in Gir. Porcupines are nocturnal and their quills can be up to 35 cm long.',
    emoji: '🦔',
    color: Color(0xFF795548),
  ),
  WildlifeFact(
    animal: 'Indian Eagle-Owl',
    fact:
        'Gir is home to over 300 bird species. The Indian eagle-owl is the largest owl in India, with a wingspan of up to 1.5 metres.',
    emoji: '🦅',
    color: Color(0xFF0277BD),
  ),
];

// ─────────────────────────────────────────────────────────────
// 📐 DISTANCE MATRIX (km between key places)
// ─────────────────────────────────────────────────────────────

const Map<String, Map<String, int>> distanceMatrix = {
  'Sasan Gir': {
    'Devalia Safari': 12,
    'Tulsi Shyam': 35,
    'Veraval': 40,
    'Somnath': 45,
    'Junagadh': 65,
    'Girnar': 60,
    'Keshod Airport': 55,
    'Rajkot Airport': 160,
    'Ahmedabad': 390,
  },
  'Somnath': {
    'Veraval': 5,
    'Sasan Gir': 45,
    'Diu Island': 90,
  },
};
