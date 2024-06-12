import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/getsize.dart';
import '../../../../core/widgets/custom_drop_down_menu.dart';
import '../../cubit/bike_details_cubit.dart';

class CustomCitiesMenu extends StatefulWidget {
  const CustomCitiesMenu({
    super.key,
  });

  @override
  State<CustomCitiesMenu> createState() => _CustomCitiesMenuState();
}

class _CustomCitiesMenuState extends State<CustomCitiesMenu> {
  String? dropdownValue;

  @override
  void initState() {
    // context.read<AddSubscribeCubit>().getSubsCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BikeDetailsCubit cubit = context.read<BikeDetailsCubit>();

    return BlocConsumer<BikeDetailsCubit, BikeDetailsStates>(
      listener: (context, state) {
        if (state is SuccessGEtDriverDataState) {
          dropdownValue = cubit.driverDataModel.data!.cityId.toString();
          cubit.changeCurrentCityId(
              cityId: cubit.driverDataModel.data!.cityId!);
        }
      },
      builder: (context, state) {
        return cubit.citiesModel.data != null
            ? CustomDropDownMenu(
                text: 'AppStrings.subscribesCount',
                items: cubit.citiesModel.data!
                    .asMap()
                    .map((index, e) => MapEntry(
                          index,
                          DropdownMenuItem<String>(
                            onTap: () async {
                              print('Tapped on item at index $index');
                              cubit.dropdownAreaValue = null;
                              cubit.changeArea('0');
                              cubit.changeCurrentCityId(cityId: index);
                              if (e.areas!.isNotEmpty) {
                                cubit.dropdownAreaValue =
                                    e.areas!.first.id.toString();
                                cubit.changeArea(e.id.toString());
                              }
                            },
                            value: e.id.toString(),
                            child: Text(e.name.toString()),
                          ),
                        ))
                    .values
                    .toList(),
                dropdownValue: dropdownValue,
                onChanged: (String? value) {
                  setState(() {
                    dropdownValue = value!;
                  });

                  cubit.changeCity(value!);
                },
              )

            //  CustomDropDownMenu(
            //     text: 'AppStrings.subscribesCount',
            //     items: cubit.citiesModel.data!
            //         .map(
            //           (e) => DropdownMenuItem<String>(
            //             onTap: () async {
            //               print(

            //                   cubit.citiesModel.data![cubit.cityIndex!].areas!);
            //               // if (e.areas!.isNotEmpty) {
            //               //   cubit.dropdownAreaValue =
            //               //       e.areas!.first.id.toString();
            //               // }
            //               cubit.dropdownAreaValue = null;
            //               cubit.changeCurrentCityId(cityId: );
            //             },
            //             value: e.id.toString(),
            //             child: Text(e.name.toString()),
            //           ),
            //         )
            //         .toList(),
            //     dropdownValue: dropdownValue,
            //     onChanged: (String? value) {
            //       setState(() {
            //         dropdownValue = value!;
            //       });

            //       cubit.changeCity(value!);
            //     },
            //   )
            : SizedBox(
                height: getSize(context) / 22,
              );
      },
    );
  }
}
