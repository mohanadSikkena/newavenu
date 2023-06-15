import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newavenue/models/app/app_cubit.dart';
import 'package:newavenue/models/app/app_states.dart';
import 'package:newavenue/shared/styles/colors.dart';
import 'package:newavenue/shared/styles/styles.dart';

import '../../models/drawer/menu_item.dart';

class DrawerMenuScreen extends StatelessWidget {
  final MenuItem currentItem;
  final ValueChanged<MenuItem> onSelectedItem;
  const DrawerMenuScreen(
      {Key? key, required this.currentItem, required this.onSelectedItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(),

          child: Image(
            width: 150.w,
            image: const AssetImage('images/white_logo_crop.png'),
          ),
        ),
        const Spacer(),
        ...MenuItems.all.map(drawerWidgets).toList(),
        const Spacer(),
        Container(
          alignment: Alignment.bottomLeft,
          margin: EdgeInsets.only(bottom: 30.h),
          child: ListTile(
            onTap: () {
              ZoomDrawer.of(context)!.close();
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return BlocBuilder<AppCubit, AppStates>(
                      builder: (context, state) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              leading: Text(
                                "Dark mode",
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                            ),
                            ListTile(
                              title: const Text("Dark mode"),

                              leading: Radio(
                                groupValue: ThemeMode.dark,
                                value: AppCubit.get(context).currentMode,
                                onChanged: (v) {
                                  AppCubit.get(context).changeDarkMode(value: ThemeMode.dark);
                                },
                              ),
                              onTap: (){
                                AppCubit.get(context).changeDarkMode(value: ThemeMode.dark);
                              },
                            ),
                            ListTile(
                              title: const Text("Light Mode"),
                              leading: Radio(
                                groupValue: ThemeMode.light,
                                value: AppCubit.get(context).currentMode,
                                onChanged: (v) {
                                  AppCubit.get(context).changeDarkMode(value: ThemeMode.light);
                                },
                              ),
                                onTap: (){
                                  AppCubit.get(context).changeDarkMode(value: ThemeMode.light);
                                }
                            ),
                            ListTile(
                              title: const Text("System Default"),
                              leading: Radio(
                                groupValue: ThemeMode.system,
                                value: AppCubit.get(context).currentMode,
                                onChanged: (v) {
                                  AppCubit.get(context).changeDarkMode(value: ThemeMode.system);
                                },
                              ),
                                onTap: (){
                                  AppCubit.get(context).changeDarkMode(value: ThemeMode.system);
                                }
                            ),
                          ],
                        );
                      },
                    );
                  });
            },
            leading: const FaIcon(FontAwesomeIcons.lightbulb, color: white),
            title: Text(
              "Mode",
              style: f17TextWhiteMedium,
            ),
          ),
        )
      ],
    );
  }

  Widget drawerWidgets(MenuItem item) => ListTile(
        leading: Icon(item.icon, color: white),
        title: Text(
          item.name,
          style: f17TextWhiteMedium,
        ),
        onTap: () {
          onSelectedItem(item);
        },
      );
}
