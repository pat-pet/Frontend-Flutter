import 'package:flutter/material.dart';
import 'package:frontend_flutter/components/item_pet_care.dart';
import 'package:frontend_flutter/src/model/register_model.dart';
import 'package:frontend_flutter/src/pages/main/chat/chat_detail_page.dart';
import 'package:frontend_flutter/src/utils/token_manager.dart';
import 'package:frontend_flutter/src/view_models/chat_provider.dart';
import 'package:frontend_flutter/src/view_models/home_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _name = "";
  String _status = "off";

  @override
  void initState() {
    super.initState();
    getName();
    getStatus();
    Future.microtask(() {
      Provider.of<HomeProvider>(context, listen: false).getUsers();
    });
  }

  void getStatus() async {
    String status = await SharedPrefManager.getString(
            SharedPrefManager.statusAnimalCareKey) ??
        "";
    setState(() {
      _status = status;
    });
  }

  void getName() async {
    String name =
        await SharedPrefManager.getString(SharedPrefManager.fullNameKey) ?? "";
    setState(() {
      _name = name;
    });
  }

  Widget header() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF1A1F2A),
            Color(0xFF3282B8),
          ],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
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
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 4),
                Text.rich(
                  TextSpan(
                    children: <TextSpan>[
                      const TextSpan(text: 'You '),
                      TextSpan(
                        text: _status == "off" ? 'turned off ' : 'turned on ',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const TextSpan(
                        text: 'your availability to take care others pet ',
                      )
                    ],
                  ),
                  softWrap: true,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget animalCareList(List<UserModel> users) {
    return Container(
      margin: const EdgeInsets.only(top: 14, left: 14, right: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pick You Animal Care',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          GridView.count(
            primary: false,
            shrinkWrap: true,
            crossAxisCount: 2,
            padding: const EdgeInsets.symmetric(vertical: 14),
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            children: users.map((user) {
              return ItemPetCare(
                name: user.fullName ?? "",
                onChatClicked: () {
                  Provider.of<ChatProvider>(context, listen: false)
                      .setUser(user);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChatDetailScreen(),
                    ),
                  );
                },
              );
            }).toList(),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, value, child) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header(),
              animalCareList(value.users),
            ],
          ),
        );
      },
    );
  }
}
