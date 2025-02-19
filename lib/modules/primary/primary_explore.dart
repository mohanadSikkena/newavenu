import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newavenue/main.dart';
import 'package:newavenue/models/primary/primary_cubit.dart';
import 'package:newavenue/models/primary/primary_states.dart';
import 'package:newavenue/shared/components/custom_loading.dart';
import 'package:newavenue/shared/components/primary_widget.dart';
import 'package:newavenue/shared/router.dart';

import '../../shared/styles/styles.dart';

class PrimaryExploreScreen extends StatelessWidget {
  const PrimaryExploreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PrimaryCubit cubit = PrimaryCubit.get(context);
    return BlocConsumer<PrimaryCubit, PrimaryStates>(
        builder: (context, states) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
CustomRouter.pop();
                  },
                  icon: Icon(Icons.arrow_back_ios,
                      color: Theme.of(context).iconTheme.color)),
              elevation: 0.0,
            ),
            body: cubit.primaryExploreLoading
                ? Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Loading'),
                          const SizedBox(
                            height: 10,
                          ),
                          customLoading()
                        ]),
                  )
                : Container(
                    margin: const EdgeInsets.only(
                      left: 16,
                    ),
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: [
                        Text('Explore',
                            style: Theme.of(context).textTheme.displayLarge),
                        Text(
                          "\n${cubit.primaryProperties.length} properties",
                          style: f15TextGraySemibold_1,
                        ),
                        for (int i = 0; i < cubit.primaryProperties.length; i++)
                          primaryWidget(
                            context: context,
                            property: cubit.primaryProperties[i],
                          )
                      ],
                    ),
                  ),
          );
        },
        listener: (context, states) {});
  }
}
