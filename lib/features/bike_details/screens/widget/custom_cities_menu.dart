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

      },
      builder: (context, state) {
        return cubit.citiesModel.data != null
            ?
        CustomDropDownMenu(
                text: 'AppStrings.subscribesCount',
                items: cubit.citiesModel.data!
                    .map(
                      (e) => DropdownMenuItem<String>(
                        onTap: () async{
                          cubit.dropdownAreaValue = null;
                           cubit.changeCurrentCityId(cityId: e.id!);
                        },
                        value: e.id.toString(),
                        child: Text(e.name.toString()),
                      ),
                    )
                    .toList(),
                dropdownValue: dropdownValue,
                onChanged: (String? value) {
                  setState(() {
                    dropdownValue = value!;
                  });

                  cubit.changeCity(value!);
                },
              )
            :  SizedBox(
          height: getSize(context) / 22,
        );
      },
    );
  }
}
