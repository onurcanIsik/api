import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gun_haberleri/Model/model.dart';
import 'package:gun_haberleri/Pages/hot_news.dart';
import 'package:gun_haberleri/Service/services.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(body: MyApp()),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  VeriCevap event = VeriCevap();
  late List<Tarihtebugun> data;

  Future<void> getData() async {
    data = await event.getEvent();
  }

  @override
  void initState() {
    event.getEvent();
    super.initState();
  }

  late DateTime now = DateTime.now();
  late DateFormat formatter = DateFormat('yyyy-MM-dd');
  late String formatted = formatter.format(now);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          drawer: Drawer(
            child: ListView(
              children: [
                DrawerHeader(
                  child: Container(
                    width: 200,
                    height: 100,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 206, 206, 206),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                            blurRadius: 1,
                            color: Colors.redAccent,
                            offset: Offset(1, 2),
                            spreadRadius: 1),
                      ],
                    ),
                    child: Column(
                      children: const [
                        SizedBox(height: 12),
                        Icon(
                          LineIcons.spider,
                          size: 70,
                          color: Colors.red,
                        ),
                        SizedBox(height: 8),
                        Center(
                          child: Text(
                            "SpiNews", //font değişikliği yapıcaz
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 26,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HotNews()));
                  },
                  child: Card(
                    elevation: 5,
                    shadowColor: const Color.fromARGB(255, 206, 206, 206),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: Colors.redAccent,
                    child: const ListTile(
                      title: Center(
                        child: Text(
                          "Günlük Haberler",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ),
                      leading: Icon(
                        LineIcons.cookie,
                        size: 30,
                        color: Color.fromARGB(255, 87, 7, 7),
                      ),
                    ),
                  ),
                ),
                const Divider(
                  color: Colors.redAccent,
                  height: 50,
                  endIndent: 40,
                  indent: 40,
                  thickness: 2,
                )
              ],
            ),
          ),
          appBar: AppBar(
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: const Icon(
                    LineIcons.stream,
                    size: 30,
                    color: Colors.redAccent,
                  ),
                );
              },
            ),
            actions: [
              Row(
                children: [
                  Text(formatted),
                  const SizedBox(width: 20),
                ],
              ),
            ],
            centerTitle: true,
            title: Text(
              "Geçmişte Neler Oldu ?",
              style: TextStyle(color: Colors.yellow[400], fontSize: 18),
            ),
          ),
          body: FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        color: const Color.fromARGB(255, 206, 206, 206),
                        child: ListTile(
                          title: Text(
                            data[index].olay!,
                            style: const TextStyle(color: Colors.black),
                          ),
                          subtitle: Row(
                            children: [
                              const Text(
                                "Olay Yılı = ",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 12, 29, 14),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                data[index].gun!,
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 12, 29, 14),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                "-",
                                style: TextStyle(color: Colors.black),
                              ),
                              Text(
                                data[index].ay!,
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 12, 29, 14),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                "-",
                                style: TextStyle(color: Colors.black),
                              ),
                              Text(
                                data[index].yil!,
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 12, 29, 14),
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(width: 100),
                              Text(
                                data[index].durum!,
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 148, 2, 2),
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              return const Center();
            },
          ),
        ),
      ),
    );
  }
}
