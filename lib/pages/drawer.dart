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
  int _value = 1;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(height: 40),
          ListTile(
            leading: Icon(Icons.newspaper),
            title: Text('Daily News'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
          ),
          ListTile(
            leading: Icon(Icons.notifications_rounded),
            title: Text('Notifications'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text('Notifications'),
                        content: SizedBox(
                            height: 100,
                            width: 70,
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
                                        SizedBox(width: 10),
                                        Text('Enable')
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
                                        SizedBox(width: 10),
                                        Text('Disable')
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
                              child: Text('Cancel'))
                        ],
                      ));
            },
          ),
          ListTile(
            leading: Icon(Icons.bookmark),
            title: Text('Bookmarks'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => BookmarkPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()));
            },
          ),
          Container(
            decoration: BoxDecoration(color: Color.fromARGB(100, 158, 158, 158)),
            width: 400,
            height: 1,
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Info'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
          ),
          Container(
            decoration: BoxDecoration(color: Color.fromARGB(100, 158, 158, 158)),
            width: 400,
            height: 1,
          ),
          Padding(
            padding: EdgeInsets.only(top: 250),
            child: Text('Version 1.1.0'),
          )
        ],
      ),
    );
  }
}
