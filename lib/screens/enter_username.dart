import 'package:flutter/material.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:task_app/data/database.dart';
import 'package:task_app/screens/home.dart';

class EnterUsername extends StatefulWidget {
  const EnterUsername({super.key});

  @override
  State<EnterUsername> createState() => _EnterUsernameState();
}

class _EnterUsernameState extends State<EnterUsername> {
  final TextEditingController _controller = TextEditingController();
  String _username = '';

  _setUsername(String username) {
    setState(() {
      _username = username;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColoredBox(
        color: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Text(
                  'Hey! How should I call you?',
                  style: TextStyle(
                    color: TWTwoColors.gray.shade800,
                    decoration: TextDecoration.none,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 42),
                  child: CircleAvatar(
                    backgroundImage:
                        const ExactAssetImage('lib/images/icon.png'),
                    backgroundColor: TWTwoColors.gray.shade800,
                    radius: 60,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: TextField(
                    controller: _controller,
                    onChanged: _setUsername,
                    autocorrect: false,
                    maxLength: 12,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      color: TWTwoColors.gray.shade800,
                      decoration: TextDecoration.none,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'username',
                      helperStyle: const TextStyle(color: Colors.white),
                      prefixIcon: const Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                      suffixIcon: Icon(
                        Icons.edit,
                        color: TWTwoColors.gray.shade800,
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    enableFeedback: _username.isNotEmpty,
                    minimumSize: const MaterialStatePropertyAll(
                      Size.fromHeight(40),
                    ),
                    backgroundColor: MaterialStatePropertyAll(
                      _username.isEmpty
                          ? TWTwoColors.violet.shade300
                          : TWTwoColors.violet.shade500,
                    ),
                    overlayColor: _username.isEmpty
                        ? MaterialStatePropertyAll(
                            TWTwoColors.violet.shade300,
                          )
                        : null,
                  ),
                  onPressed: () {
                    Database().setUsername(_controller.text);
                    _controller.clear();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Home()),
                    );
                  },
                  child: const Text('Next'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
