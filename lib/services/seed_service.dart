// lib/services/seed_service.dart
// One-shot seeder: pushes all static Dart data into Firestore collections.
// Idempotent: uses deterministic IDs to prevent duplicates.

import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/static_data.dart';
import '../data/extra_data.dart';

class SeedService {
  SeedService._();
  static final SeedService instance = SeedService._();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<SeedResult> seedAll() async {
    final result = SeedResult();

    result.safariTimings = await _seedList(
      'safari_timings',
      safariTimings
          .map((e) => {
                'id': e.session.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '_'),
                'session': e.session,
                'time': e.time,
                'season': e.season,
              })
          .toList(),
      idKey: 'id',
    );

    result.safariZones = await _seedList(
      'safari_zones',
      safariZones
          .map((e) => {
                'name': e.name,
                'code': e.code,
                'description': e.description,
                'entryPoint': e.entryPoint,
                'highlight': e.highlight,
              })
          .toList(),
      idKey: 'name',
    );

    result.entryFees = await _seedList(
      'entry_fees',
      entryFees
          .map((e) => {
                'category': e.category,
                'feePerPerson': e.feePerPerson,
                'vehicleFee': e.vehicleFee,
                'guideCharge': e.guideCharge,
              })
          .toList(),
      idKey: 'category',
    );

    result.hotels = await _seedList(
      'hotels',
      hotels
          .map((e) => {
                'name': e.name,
                'location': e.location,
                'priceRange': e.priceRange,
                'priceMin': e.priceMin,
                'priceMax': e.priceMax,
                'contact': e.contact,
                'phone': e.phone,
                'website': e.website,
                'type': e.type,
                'description': e.description,
                'amenities': e.amenities,
                'rating': e.rating,
                'reviews': e.reviews,
              })
          .toList(),
      idKey: 'name',
    );

    result.localDishes = await _seedList(
      'local_dishes',
      localDishes
          .map((e) => {
                'name': e.name,
                'description': e.description,
                'bestFoundAt': e.bestFoundAt,
                'isVeg': e.isVeg,
              })
          .toList(),
      idKey: 'name',
    );

    result.cultureTraditions = await _seedList(
      'culture_traditions',
      cultureTraditions
          .map((e) => {
                'title': e.title,
                'description': e.description,
              })
          .toList(),
      idKey: 'title',
    );

    result.nearbyPlaces = await _seedList(
      'nearby_places',
      nearbyPlaces
          .map((e) => {
                'id': e.id,
                'name': e.name,
                'type': e.type,
                'shortDescription': e.shortDescription,
                'fullDescription': e.fullDescription,
                'distance': e.distance,
                'distanceKm': e.distanceKm,
                'rating': e.rating,
                'bestTime': e.bestTime,
                'entryFee': e.entryFee,
                'travelTips': e.travelTips,
                'website': e.website,
                'imagePath': e.imagePath,
              })
          .toList(),
      idKey: 'id',
    );

    result.transportOptions = await _seedList(
      'transport_options',
      transportOptions
          .map((e) => {
                'id': '${e.mode}_${e.from}'.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '_'),
                'mode': e.mode,
                'from': e.from,
                'duration': e.duration,
                'distance': e.distance,
                'frequency': e.frequency,
                'fare': e.fare,
                'tips': e.tips,
              })
          .toList(),
      idKey: 'id',
    );

    result.nearbyStations = await _seedList(
      'nearby_stations',
      nearbyStations
          .map((e) => {
                'name': e.name,
                'type': e.type,
                'distance': e.distance,
                'code': e.code,
              })
          .toList(),
      idKey: 'name',
    );

    result.emergencyContacts = await _seedList(
      'emergency_contacts',
      emergencyContacts
          .map((e) => {
                'name': e.name,
                'number': e.number,
                'category': e.category,
                'note': e.note,
              })
          .toList(),
      idKey: 'name',
    );

    result.firstAidTips = await _seedList(
      'first_aid_tips',
      firstAidTips
          .map((e) => {
                'situation': e.situation,
                'immediateAction': e.immediateAction,
                'steps': e.steps,
                'callNumber': e.callNumber,
              })
          .toList(),
      idKey: 'situation',
    );

    result.quickFacts = await _seedList(
      'quick_facts',
      quickFacts
          .map((e) => {
                'label': e.label,
                'value': e.value,
              })
          .toList(),
      idKey: 'label',
    );

    result.wildlifeFacts = await _seedList(
      'wildlife_facts',
      wildlifeFacts
          .map((e) => {
                'animal': e.animal,
                'fact': e.fact,
                'emoji': e.emoji,
              })
          .toList(),
      idKey: 'animal',
    );

    // Seed Itineraries
    result.itineraries = await _seedList(
      'itineraries',
      [...oneDayItinerary, ...twoDayItinerary].map((d) => {
        'id': d.title.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '_'),
        'day': d.day,
        'title': d.title,
        'theme': d.theme,
        'steps': d.steps.map((s) => {
          'time': s.time,
          'activity': s.activity,
          'description': s.description,
          'location': s.location,
        }).toList(),
      }).toList(),
      idKey: 'id',
    );

    // Seed Checklist Template
    result.checklist = await _seedList(
      'checklist_template',
      checklistCategories.map((c) => {
        'category': c.category,
        'items': c.items.map((i) => {
          'item': i.item,
          'isEssential': i.isEssential,
          'note': i.note,
        }).toList(),
      }).toList(),
      idKey: 'category',
    );

    // Settings / misc text
    await _db.collection('settings').doc('meta').set({
      'safariRules': safariRules,
      'ecoTips': ecoTips,
      'bookingProcess': bookingProcess,
      'bestSeasonInfo': bestSeasonInfo,
      'officialBookingUrl': officialBookingUrl,
      'forestOfficePhone': forestOfficePhone,
      'seededAt': FieldValue.serverTimestamp(),
    });
    result.settings = 1;

    return result;
  }

  Future<int> _seedList(
    String collection,
    List<Map<String, dynamic>> docs, {
    String? idKey,
  }) async {
    final col = _db.collection(collection);
    for (var i = 0; i < docs.length; i += 400) {
      final batch = _db.batch();
      final end = (i + 400 > docs.length) ? docs.length : i + 400;
      for (var j = i; j < end; j++) {
        final data = Map<String, dynamic>.from(docs[j]);
        final id = idKey != null ? data[idKey]?.toString() : null;
        final ref = id != null ? col.doc(id) : col.doc();
        data['updatedAt'] = FieldValue.serverTimestamp();
        batch.set(ref, data, SetOptions(merge: true));
      }
      await batch.commit();
    }
    return docs.length;
  }
}

class SeedResult {
  int safariTimings = 0;
  int safariZones = 0;
  int entryFees = 0;
  int hotels = 0;
  int localDishes = 0;
  int cultureTraditions = 0;
  int nearbyPlaces = 0;
  int transportOptions = 0;
  int nearbyStations = 0;
  int emergencyContacts = 0;
  int firstAidTips = 0;
  int quickFacts = 0;
  int wildlifeFacts = 0;
  int itineraries = 0;
  int checklist = 0;
  int settings = 0;

  int get total =>
      safariTimings +
      safariZones +
      entryFees +
      hotels +
      localDishes +
      cultureTraditions +
      nearbyPlaces +
      transportOptions +
      nearbyStations +
      emergencyContacts +
      firstAidTips +
      quickFacts +
      wildlifeFacts +
      itineraries +
      checklist +
      settings;

  @override
  String toString() => '''
safari_timings: $safariTimings
safari_zones: $safariZones
entry_fees: $entryFees
hotels: $hotels
local_dishes: $localDishes
culture_traditions: $cultureTraditions
nearby_places: $nearbyPlaces
transport_options: $transportOptions
nearby_stations: $nearbyStations
emergency_contacts: $emergencyContacts
first_aid_tips: $firstAidTips
quick_facts: $quickFacts
wildlife_facts: $wildlifeFacts
itineraries: $itineraries
checklist: $checklist
settings: $settings
TOTAL: $total
''';
}
