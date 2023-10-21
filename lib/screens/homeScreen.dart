import 'package:flutter/material.dart';
import 'package:googles/provider/homeProvider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = ScrollController();
  @override
  void initState() {
    super.initState();
    int pageNo = 1;
    final favProvider = Provider.of<HomeProvider>(context, listen: false);

    favProvider.apiData(context, pageNo);
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        pageNo++;
        favProvider.apiData(context, pageNo);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Screen'),
        ),
        body: Consumer<HomeProvider>(
          builder: (context, value, child) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              value.usersList.isEmpty
                  ? const Center(child: CircularProgressIndicator.adaptive())
                  : Expanded(
                      child: ListView.builder(
                        controller: controller,
                        itemCount: value.usersList.length + 1,
                        itemBuilder: (context, index) {
                          if (index < value.usersList.length) {
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    value.usersList[index]['firstImage']),
                              ),
                              title: Text(value.usersList[index]['firstLabel']),
                              subtitle: Text(
                                  value.usersList[index]['userId']['fullName']),
                            );
                          } else {
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 32),
                              child: Center(
                                  child: CircularProgressIndicator.adaptive()),
                            );
                          }
                        },
                      ),
                    )
            ],
          ),
        ));
  }
}
