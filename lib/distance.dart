import 'package:ass2/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'cubit.dart';


class distance extends StatelessWidget {
  distance({super.key});
  Map<String, List<double>> latlang = {
    "El maadi": [30.835951, 29.231001],
    "6th of Octobar": [30.562120, 31.788839],
    "Nasr City": [30.016893, 31.377033],
  };
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<cubit_App, states_App>(
      builder: (context, state) {
        return Center(
          child: Column(
            children: [
              const SizedBox(height: 30.0),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Distance",
                    style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Expanded(
                child: ((cubit_App.get(context).servicse == false) ||
                    (cubit_App.get(context).per ==
                        LocationPermission.denied))
                    ? const Center(
                  child: Text("check Permission and Open Loaction"),
                )
                    : ListView.separated(
                  itemCount: cubit_App.get(context).favorite_data.length,
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
                              "Distance : ${(Geolocator.distanceBetween(cubit_App.get(context).current?.latitude?? 0, cubit_App.get(context).current?.longitude?? 0, latlang["${cubit_App.get(context).favorite_data[index]["city"]}"]?.first?? 0, latlang["${cubit_App.get(context).favorite_data[index]["city"]}"]?.last?? 0) / 1000).round()} K"),

                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}