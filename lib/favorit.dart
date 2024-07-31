import 'package:ass2/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit.dart';
import 'login.dart';

class favorite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                    Text(
                      " Favorite Stores ",
                      style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Expanded(
                  child: cubit_App.get(context).stores_data.isEmpty
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.separated(
                          itemCount:
                              cubit_App.get(context).favorite_data.length,
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
                                      "${cubit_App.get(context).favorite_data[index]["name"]}"),
                                  leading: CircleAvatar(
                                      backgroundImage: AssetImage(
                                          "${cubit_App.get(context).favorite_data[index]["image"]}")),
                                  subtitle: Text(
                                      "${cubit_App.get(context).favorite_data[index]["city"]}"),
                                  trailing: IconButton(
                                      onPressed: () {
                                        cubit_App.get(context).delete_data(
                                            "${cubit_App.get(context).favorite_data[index]["name"]}");
                                        cubit_App.get(context).get_data_fav();
                                      },
                                      icon: const Icon(
                                        Icons.favorite,
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
