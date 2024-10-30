import 'package:cities_of_the_world/screens/home/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import '../../app/common/utils.dart';
import '../setting/setting_screen.dart';
import 'widgets/city_list_view.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cities of the World"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              closeKeyboard(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: const Column(
        children: [
          SearchBarWidget(),
          Expanded(child: CityListView()),
        ],
      ),
    );
  }
}
