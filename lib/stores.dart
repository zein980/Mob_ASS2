import 'package:ass2/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit.dart';

class stores extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    IconData fav = Icons.favorite_border;
    bool f = false;
    // Function to insert a new store
    void insertNewStore() {
      // Assuming you have the store details available here

      String storeName = " Zara ";
      String storeImage = "im/2021-08-09.jpg";
      String storeCity = " 6th Of October ";

      // Call the method to insert the store data
      cubit_App.get(context).insert_data_Store(
        name: storeName,
        image: storeImage,
        city: storeCity,
      );

      // Refresh the UI to reflect the new store
      cubit_App.get(context).get_data_Stores();
    }
    return BlocConsumer<cubit_App, states_App>(
        listener: (context, state) {},
        builder: (context, state) {
          return Center(
            child: Column(
              children: [
                const SizedBox(height: 30.0),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   // const SizedBox(height: 20.0),
                    Text(
                      " List of stores",
                      style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 30,
                          fontWeight: FontWeight.bold

                      ),
                    ),

                  ],
                ),
                const SizedBox(height: 25.0),
                ElevatedButton(
                  onPressed: insertNewStore,
                  child: const Text("Add New Store"),
                ),
                Expanded(
                  child: cubit_App.get(context).stores_data.isEmpty
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.separated(
                          itemCount: cubit_App.get(context).stores_data.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              height: 20,
                            );
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              decoration: BoxDecoration(
                                  color: Colors.white12,
                                  borderRadius: BorderRadius.circular(15)),
                              height: 150,
                              child: Center(
                                child: ListTile(
                                  title: Text(
                                      "${cubit_App.get(context).stores_data[index]["name"]}"),
                                  leading: CircleAvatar(
                                      backgroundImage: AssetImage(
                                          "${cubit_App.get(context).stores_data[index]["image"]}")),
                                  subtitle: Text(
                                      "${cubit_App.get(context).stores_data[index]["city"]}"),
                                  trailing: IconButton(
                                      onPressed: () {
                                        cubit_App
                                            .get(context)
                                            .favorite_data
                                            .forEach((element) {
                                          if (element["name"] ==
                                              cubit_App
                                                  .get(context)
                                                  .stores_data[index]["name"]) {
                                            f = true;
                                          }
                                        });
                                        if (f == false) {
                                          cubit_App.get(context).inseart_database_fav(
                                              name:
                                                  "${cubit_App.get(context).stores_data[index]["name"]}",
                                              image:
                                                  "${cubit_App.get(context).stores_data[index]["image"]}",
                                              city:
                                                  "${cubit_App.get(context).stores_data[index]["city"]}");
                                          cubit_App.get(context).get_data_fav();
                                        }
                                      },
                                      icon: Icon(
                                        fav,
                                        color: Colors.deepPurple,
                                      )),
                                ),
                              ),
                            );
                          },
                        ),
                )
              ],
            ),
          );
        });
  }
}
