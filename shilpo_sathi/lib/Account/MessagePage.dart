import 'package:flutter/material.dart';
import 'ChatPage.dart';

class MessagePage extends StatefulWidget {
  final Map<String, String>? initialUser;

  MessagePage({this.initialUser});

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  final String currentUserId = 'currentUser';

  late List<Map<String, String>> users;

  @override
  void initState() {
    super.initState();
    users = [
      {
        'userId': 'user456',
        'firstName': 'Jawadun',
        'lastName': 'Noor',
        'profileImage': 'assets/images/jawad.jpg',
      },
      {
        'userId': 'user789',
        'firstName': 'Mohaiminul',
        'lastName': 'Nirob',
        'profileImage': 'assets/images/nirob.jpg',
      },
    ];

    if (widget.initialUser != null) {
      final exists = users.any((u) => u['userId'] == widget.initialUser!['userId']);
      if (!exists) {
        users.insert(0, widget.initialUser!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredUsers = users.where((user) {
      final fullName = "${user['firstName']} ${user['lastName']}".toLowerCase();
      return user['userId'] != currentUserId && fullName.contains(_searchQuery);
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: AppBar(
        title: const Text('Messages', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: _searchController,
              onChanged: (value) => setState(() => _searchQuery = value.toLowerCase()),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search people...',
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: filteredUsers.isEmpty
                ? const Center(child: Text('No users found.'))
                : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: filteredUsers.length,
              itemBuilder: (context, index) {
                final user = filteredUsers[index];
                final userName = "${user['firstName']} ${user['lastName']}".trim();
                final profileImage = user['profileImage'] ?? 'assets/images/default_avatar.png';

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChatPage(
                          userId: user['userId']!,
                          userName: userName,
                          userAvatar: profileImage,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundImage: AssetImage(profileImage),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userName,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Tap to message',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.chat_bubble_outline, color: Colors.grey),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
