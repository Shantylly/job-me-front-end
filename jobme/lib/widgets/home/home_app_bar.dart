import 'package:flutter/material.dart';
import 'package:front/utils/local_storage.dart';

class HomeAppBar extends StatelessWidget with PreferredSizeWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 5,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            icon: Image.asset('assets/logo_jobme.png'),
            iconSize: 80,
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          Container(
            margin: const EdgeInsets.all(40),
            constraints: const BoxConstraints(
                minWidth: 20, maxWidth: 500, minHeight: 35, maxHeight: 35),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[50],
                prefixIcon: const Icon(Icons.search),
                hintText: 'Rechercher...',
                contentPadding: const EdgeInsets.all(10),
                hintStyle: const TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(
                    width: 1.0,
                  ),
                ),
              ),
            ),
          ),
          // To applied offers
          LocalStorage.getString('type') == "applicant"
              ? IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/profile');
                  },
                  iconSize: 40,
                  icon: const Icon(
                    Icons.work_outline,
                    color: Colors.black,
                  ),
                )
              : const SizedBox.shrink(),
          // To profile
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
            iconSize: 40,
            icon: const Icon(
              Icons.account_circle_rounded,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
