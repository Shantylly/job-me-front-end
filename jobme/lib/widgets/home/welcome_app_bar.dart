import 'package:flutter/material.dart';

class WelcomeAppBar extends StatelessWidget with PreferredSizeWidget {
  const WelcomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 5,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: Image.asset('assets/logo_jobme.png'),
        onPressed: () => Navigator.pushReplacementNamed(context, '/'),
      ),
      title: RichText(
        text: const TextSpan(
          children: [
            WidgetSpan(child: Icon(Icons.email, size: 14, color: Colors.black)),
            TextSpan(text: " hello@job-me.fr        "),
            WidgetSpan(child: Icon(Icons.phone, size: 14, color: Colors.black)),
            TextSpan(text: " 07.56.89.45.60 "),
          ],
        ),
      ),
      actions: [
        // To Login
        TextButton.icon(
          onPressed: () => Navigator.pushNamed(context, '/login'),
          icon: const Icon(Icons.login),
          label: const Text("Connexion"),
        ),
        //To register
        TextButton.icon(
          onPressed: () => Navigator.pushNamed(context, '/register'),
          icon: const Icon(Icons.meeting_room),
          label: const Text("S'inscrire"),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
