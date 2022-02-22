import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:gun_haberleri/Model/model_two.dart';
import 'package:gun_haberleri/Service/services_two.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class HotNews extends StatefulWidget {
  const HotNews({Key? key}) : super(key: key);

  @override
  _HotNewsState createState() => _HotNewsState();
}

class _HotNewsState extends State<HotNews> {
  VeriCevap2 event = VeriCevap2();
  late List<Articles> data;
  Future<void> getData() async {
    data = await event.getEvent2();
  }

  bool alreadySave = false;

  @override
  void initState() {
    super.initState();
    event.getEvent2();
  }

  String sayac = "deneme";

  Widget urlToImagee = Image.asset("assets/Images/placeholder.png");

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.redAccent[100],
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            setState(() {
              EasyRefresh;
            });
          },
          child: const Icon(
            LineIcons.spider,
            color: Colors.redAccent,
            size: 30,
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.red,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
          ),
          title: const Text(
            "SpiNews",
            style: TextStyle(color: Colors.white, fontSize: 23),
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
                  return Column(
                    children: [
                      Uri.parse(data[index].urlToImage!).isAbsolute 
                          ? Image.network(data[index].urlToImage!)
                          : urlToImagee,
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: Colors.black,
                        elevation: 5,
                        child: ListTile(
                          title: Text(
                            data[index].title!,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                          subtitle: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    data[index].name!,
                                    style:
                                        const TextStyle(color: Colors.white70),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      LineIcons.alternateLongArrowRight,
                                      color: Colors.blue,
                                    ),
                                    onPressed: () {
                                      {
                                        setState(() {
                                          launch(data[index].url!);
                                        });
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                    ],
                  );
                },
              );
            }
            return const Center();
          },
        ),
      ),
    );
  }
}
