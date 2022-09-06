import 'package:book/pages/bookmark_page.dart';
import 'package:book/pages/settings.dart';
import 'package:book/provider/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final int _value = 1;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Drawer(
      child: Column(
        children: [
          Image.asset('assets/newa.jpg'),
          ListTile(
            leading: const Icon(Icons.newspaper),
            title: const Text('Daily News'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications_rounded),
            title: const Text('Notifications'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: const Text('Notifications'),
                        content: SizedBox(
                            height: height * .12,
                            width: width * .07,
                            child: Consumer<NotificationProvider>(
                              builder: ((context, value, child) {
                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        Radio(
                                            value: 1,
                                            groupValue: _value,
                                            onChanged: (v) {
                                              v = context.read<NotificationProvider>().disabled;
                                            }),
                                        const SizedBox(width: 10),
                                        const Text('Enable')
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Radio(
                                            value: context.watch<NotificationProvider>().disabled,
                                            groupValue: _value,
                                            onChanged: (v) {
                                              v = context.read<NotificationProvider>().disabled;
                                            }),
                                        SizedBox(width: width * .01),
                                        const Text('Disable')
                                      ],
                                    ),
                                  ],
                                );
                              }),
                            )),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel'))
                        ],
                      ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.bookmark),
            title: const Text('Bookmarks'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const BookmarkPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Settings()));
            },
          ),
          Container(
            decoration: const BoxDecoration(color: Color.fromARGB(100, 158, 158, 158)),
            width: width * .7,
            height: height * .001,
          ),
          const ListTile(
            leading: Icon(Icons.info),
            title: Text('Info'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
          ),
          Container(
            decoration: const BoxDecoration(color: Color.fromARGB(100, 158, 158, 158)),
            width: width * .7,
            height: height * .001,
          ),
          Padding(
            padding: EdgeInsets.only(top: height * .25),
            child: const Text('Version 1.1.0'),
          )
        ],
      ),
    );
  }
}
