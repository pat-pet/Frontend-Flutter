import 'package:flutter/material.dart';
import 'package:frontend_flutter/src/api/profile_api.dart';
import 'package:frontend_flutter/src/pages/authentication/login_page.dart';
import 'package:frontend_flutter/src/utils/token_manager.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _name = '';
  String _email = '';
  String _statusAnimalCare = '';
  String _token = '';

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  void getProfile() async {
    final name =
        await SharedPrefManager.getString(SharedPrefManager.fullNameKey) ?? '';
    final email =
        await SharedPrefManager.getString(SharedPrefManager.emailKey) ?? '';
    final statusAnimalCare = await SharedPrefManager.getString(
            SharedPrefManager.statusAnimalCareKey) ??
        '';
    final token =
        await SharedPrefManager.getString(SharedPrefManager.tokenKey) ?? '';
    setState(() {
      _name = name;
      _email = email;
      _statusAnimalCare = statusAnimalCare;
      _token = token;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.network(
                    'https://picsum.photos/250?image=9',
                    height: 48,
                    width: 48,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(_email),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          const Text('Content'),
          Container(
            padding: const EdgeInsets.all(32),
            child: const Row(
              children: [
                Icon(Icons.person),
                SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Profile',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text('Customize your profile'),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios)
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(32),
            child: Row(
              children: [
                Switch(
                  value: _statusAnimalCare == 'on' ? true : false,
                  onChanged: (newValue) {
                    final newStatus = _statusAnimalCare == 'on' ? 'off' : 'on';
                    setState(() {
                      _statusAnimalCare = newStatus;
                    });
                    ProfileApi().editStatus(newStatus, _token);
                  },
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Turn Off Animal Care',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'By turned this off, you are not willing to be an animal care',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          GestureDetector(
            onTap: () async {
              await LoginManager.removeLogin();
              await SharedPrefManager.removeLogin();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            },
            child: Container(
              padding: const EdgeInsets.all(32),
              child: const Row(
                children: [
                  Icon(
                    Icons.exit_to_app,
                    color: Colors.red,
                  ),
                  SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Log Out',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
