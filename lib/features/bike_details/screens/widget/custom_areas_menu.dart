import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/getsize.dart';
import '../../../../core/widgets/custom_drop_down_menu.dart';
import '../../cubit/bike_details_cubit.dart';

class CustomAreasMenu extends StatefulWidget {
  const CustomAreasMenu({
    super.key,
  });

  @override
  State<CustomAreasMenu> createState() => _CustomAreasMenuState();
}

class _CustomAreasMenuState extends State<CustomAreasMenu> {


  @override
  void initState() {
    // context.read<AddSubscribeCubit>().getSubsCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BikeDetailsCubit cubit = context.read<BikeDetailsCubit>();

    return  BlocConsumer<BikeDetailsCubit, BikeDetailsStates>(
      listener: (context, state) {
        if (state is SuccessGEtDriverDataState){
          cubit.dropdownAreaValue =cubit.driverDataModel.data!.driverDetails!.areaId.toString();
        }
      },
      builder: (context, state) {
        return cubit.citiesModel.data != null && cubit.cityIndex != null 
            ? CustomDropDownMenu(
          text: 'AppStrings.subscribesCount',
          items: cubit.citiesModel.data![cubit.cityIndex!].areas!
              .map(
                (e) => DropdownMenuItem<String>(
              onTap: () {
              //  cubit.changeCurrentCityId(cityId: e.id!);
              },
              value: e.id.toString(),
              child: Text(e.name.toString()),
            ),
          )
              .toList(),
          dropdownValue:cubit.dropdownAreaValue,
          onChanged: (String? value) {
            setState(() {
              cubit.dropdownAreaValue = value!;
            });

            cubit.changeArea(value!);
          },
        )
            :  SizedBox(
          height: getSize(context) / 22,
        );
      },
    );
  }
}
