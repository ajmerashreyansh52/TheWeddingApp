import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';



int daysToGo() {
  final target = DateTime(2025, 11, 13); // wedding date
  return target.difference(DateTime.now()).inDays;
}


void main() => runApp(const WeddingApp());

class WeddingApp extends StatelessWidget {
  const WeddingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sneha ❤️ Shreyansh',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF9C27B0),
        // Primary family
        fontFamily: 'NotoSans',
        // Fallback when a glyph isn’t in NotoSans (e.g., Hindi/❤️)
        fontFamilyFallback: const ['NotoSansDevanagari'],
      ),
      home: const HomeLanding(),
    );
  }
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

// ------------------ LANDING / HOME PAGE ------------------
class HomeLanding extends StatelessWidget {
  const HomeLanding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/couple.jpg', // <-- put your photo here
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
          // Optional dark overlay for readability
          Positioned.fill(
            child: Container(color: const Color(0xAA000000)),
          ),
                    // Center-top wedding title
          Align(
            alignment: Alignment.topCenter,
            child: SafeArea(
              minimum: const EdgeInsets.only(top: 40),
              child: Text(
                'Sneha ❤️ Shreyansh',
                style: GoogleFonts.greatVibes(
                  textStyle: const TextStyle(
                    fontSize: 42,           // bigger for landing screen
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 6,
                        color: Colors.black54,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Bottom-centered button
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              minimum: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    // Navigate into your existing app shell (tabs)
                    Navigator.of(context).pushReplacement(
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 350),
                        pageBuilder: (_, __, ___) => const AppShell(),
                        transitionsBuilder: (_, animation, __, child) {
                          return FadeTransition(opacity: animation, child: child);
                        },
                      ),
                    );
                  },
                  child: const Text(
                    'Continue',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class _AppShellState extends State<AppShell> {
  int index = 0;
  final pages = const [
    HomePage(),
    EventsPage(),
    MenuPage(),
    GalleryPage(),
    ContactsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sneha ❤️ Shreyansh',style: GoogleFonts.greatVibes(
            textStyle: const TextStyle(fontSize: 26,fontWeight: FontWeight.w600,color: Colors.black,),
          ),
        ),
      ),

      body: pages[index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) => setState(() => index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.event), label: 'Events'),
          NavigationDestination(icon: Icon(Icons.restaurant_menu), label: 'Menu'),
          NavigationDestination(icon: Icon(Icons.photo_library), label: 'Gallery'),
          NavigationDestination(icon: Icon(Icons.call), label: 'Contacts'),
        ],
      ),
    );
  }
}

/* ------------------ PAGES ------------------ */

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Welcome!', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Text(
          '11-13 Nov 2025 · Surat',
          style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
        ),
        StreamBuilder<DateTime>(
          stream: Stream.periodic(const Duration(days: 1), (_) => DateTime.now()),
          builder: (context, snapshot) {
            return Text(
              '${daysToGo()} days to go',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            );
          },
        ),

        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: const [
                Icon(Icons.favorite, size: 28),
                SizedBox(width: 12),
                Expanded(child: Text('Thanks for being part of our big day!')),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: const Icon(Icons.map),
              title: const Text('Sirvi Samaj Bhavan'),
              subtitle: const Text('Open in Google Maps'),
              trailing: const Icon(Icons.open_in_new),
              onTap: () async {
                // Use a place search (no API key needed). Change the query if venue differs.
                final uri = Uri.parse(
                  'https://www.google.com/maps/search/?api=1&query=Sirvi%20Samaj%20Bhavan%20Surat',
                );
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              },
            ),
          ),

      ],
    );
  }
}

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final events = <Map<String, String>>[
      {'name': 'Mehendi',       'date': '11 Nov',   'time': '12:00 PM', 'venue': '3rd Floor Diwan Rohitdasji Hall'},
      {'name': 'DJ Night',      'date': '11 Nov',   'time': '07:00 PM', 'venue': '3rd Floor Diwan Rohitdasji Hall'},
      {'name': 'Peela Chawal',  'date': '12 Nov',   'time': '09:00 AM', 'venue': '3rd Floor Diwan Rohitdasji Hall'},
      {'name': 'Haldi',         'date': '12 Nov',   'time': '11:00 AM', 'venue': '3rd Floor Diwan Rohitdasji Hall'},
      {'name': 'Sangeet',       'date': '12 Nov',   'time': '07:00 PM', 'venue': '3rd Floor Diwan Rohitdasji Hall'},
      {'name': 'Mayra',         'date': '13 Nov',   'time': '09:00 AM', 'venue': '1st Floor Kesar Jyoti Hall'},
      {'name': 'Baraat',        'date': '13 Nov',   'time': '02:00 PM', 'venue': 'Venue B'},
      {'name': 'Phere',         'date': '13 Nov',   'time': '05:00 PM', 'venue': 'Venue C'},
      {'name': 'Reception',     'date': '13 Nov',   'time': '07:00 PM', 'venue': '1st Floor Kesar Jyoti Hall'},
    ];
    // Group events by date
    final Map<String, List<Map<String, String>>> eventsByDate = {};
    for (final e in events) {
      final date = e['date'] ?? '';
      eventsByDate.putIfAbsent(date, () => []).add(e);
    }

return ListView(
  padding: const EdgeInsets.all(16),
  children: eventsByDate.entries.map((entry) {
    final date = entry.key;
    final dayEvents = entry.value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Date header
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            date,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // Events for this date
        ...dayEvents.map((event) {
          return ListTile(
            leading: const Icon(Icons.event_available),
            title: Text(event['name'] ?? ''),
            subtitle: Text('${event['time']} • ${event['venue']}'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: maybe open event details or map
            },
          );
        }),
        const Divider(),
      ],
    );
  }).toList(),
);

  }
}

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final menu = {
      'Breakfast': ['Poha', 'Idli', 'Tea/Coffee'],
      'Lunch': ['Paneer Tikka', 'Dal', 'Naan', 'Rice'],
      'Dinner': ['Chaat', 'Pulao', 'Desserts'],
    };
    return ListView(
      padding: const EdgeInsets.all(16),
      children: menu.entries.map((e) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(e.key, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8, runSpacing: 8,
                  children: e.value.map((dish) => Chip(label: Text(dish))).toList(),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, mainAxisSpacing: 8, crossAxisSpacing: 8),
      itemCount: 9,
      itemBuilder: (_, i) => Container(
        color: Colors.grey.shade300,
        child: const Icon(Icons.photo, size: 42),
      ),
    );
  }
}

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final contacts = <Map<String, String>>[
      {'role': 'Bride Side Coordinator', 'name': 'Ritik Jain',      'phone': '+91-6000281445'},
      {'role': 'Groom Side Coordinator', 'name': 'Puneet Ajmera',   'phone': '+91-9429509507'},
      {'role': 'Sirvi Samaj Bhavan',     'name': 'Front Desk',      'phone': '+91-2612347789'},
    ];
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: contacts.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (_, i) => ListTile(
        leading: const Icon(Icons.contact_phone),
        title: Text(contacts[i]['role']!),
        subtitle: Text('${contacts[i]['name']} · ${contacts[i]['phone']}'),
        onTap: () {
          // later: tap to call or open WhatsApp
        },
      ),
    );
  }
}
