import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:todo_app/create_todo.dart';
import 'package:todo_app/utils.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String selectedItem = 'todo';

  final List<Map<String, dynamic>> unCompletedData = [];

  final List<Map<String, dynamic>> completedData = [];

  final List<Map<String, dynamic>> data = [
    {
      'title': 'Flutter Web',
      'description':
          'simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s,',
      'date_time': 'Yesterday',
      'status': false
    },
    {
      'title': 'Study Flutter',
      'description':
          'simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s,',
      'date_time': 'Today',
      'status': true
    },
    {
      'title': 'Dart Language',
      'description':
          'simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s,',
      'date_time': 'Tommorrow',
      'status': true
    },
    {
      'title': 'Tour',
      'description':
          'simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s,',
      'date_time': 'Yesterday',
      'status': false
    },
    {
      'title': 'Flutter Framework',
      'description':
          'simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s,',
      'date_time': 'Today',
      'status': true
    },
    {
      'title': 'Flutter',
      'description':
          'simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s,',
      'date_time': 'Thurs, 15 Feb',
      'status': true
    },
    {
      'title': 'Flutter Web',
      'description':
          'simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s,',
      'date_time': 'Yesterday',
      'status': false
    }
  ];

  @override
  void initState() {
    for (Map<String, dynamic> element in data) {
      if (element['status']) {
        unCompletedData.add(element);
      } else {
        if (!element['status']) {
          completedData.add(element);
        }
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Center(
          child: FlutterLogo(
            size: 30,
          ),
        ),
        title: const Text(
          'My Tasks',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        actions: [
          PopupMenuButton<String>(
              onSelected: (value) {
                setState(() {
                  selectedItem = value;
                });
              },
              icon: const Icon(Icons.menu),
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                    child: Text('Todo'),
                    value: 'todo',
                  ),
                  const PopupMenuItem(
                    child: Text('Completed'),
                    value: 'completed',
                  )
                ];
              }),
          IconButton(onPressed: () {}, icon: const Icon(Icons.search))
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Get.to(const CreateToDo());
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return CreateToDo();
            }));
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 50,
          )),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle_outline_outlined,
                          color: customColor(
                              date: selectedItem == 'todo'
                                  ? unCompletedData[index]['date_time']
                                  : completedData[index]['date_time']),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                selectedItem == 'todo'
                                    ? unCompletedData[index]['title']
                                    : completedData[index]['title'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              Text(
                                selectedItem == 'todo'
                                    ? unCompletedData[index]['description']
                                    : completedData[index]['description'],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.notifications,
                              color: customColor(
                                  date: selectedItem == 'todo'
                                      ? unCompletedData[index]['date_time']
                                      : completedData[index]['date_time']),
                            ),
                            Text(
                              selectedItem == 'todo'
                                  ? unCompletedData[index]['date_time']
                                  : completedData[index]['date_time'],
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: customColor(
                                      date: selectedItem == 'todo'
                                          ? unCompletedData[index]['date_time']
                                          : completedData[index]['date_time'])),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 2,
            );
          },
          itemCount: selectedItem == 'todo'
              ? unCompletedData.length
              : completedData.length),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: InkWell(
            onTap: () {
              showBarModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return ListView.separated(
                        itemBuilder: (context, index) {
                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.check_circle_outline_outlined,
                                    color: customColor(
                                        date: completedData[index]
                                            ['date_time']),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          completedData[index]['title'],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        Text(
                                          completedData[index]['description'],
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.notifications,
                                        color: customColor(
                                            date: completedData[index]
                                                ['date_time']),
                                      ),
                                      Text(
                                        completedData[index]['date_time'],
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: customColor(
                                                date: completedData[index]
                                                    ['date_time'])),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 5,
                          );
                        },
                        itemCount: completedData.length);
                  });
            },
            child: Material(
              borderRadius: BorderRadius.circular(15),
              color: const Color.fromRGBO(29, 38, 104, 1),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      size: 30,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Text(
                      'Completed',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    const Spacer(),
                    Text(
                      '${completedData.length}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
