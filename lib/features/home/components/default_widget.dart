import 'package:easy_localization/easy_localization.dart ' as easy;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hero/core/utils/app_fonts.dart';
import 'package:hero/features/user_trip/cubit/user_trip_cubit.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/dialogs.dart';
import '../../../core/utils/getsize.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../cubit/home_cubit.dart';
import 'dart:async';
import 'package:easy_autocomplete/easy_autocomplete.dart';

import '../screen/home.dart';
class DefaultWidget extends StatefulWidget {
  const DefaultWidget({super.key, required this.isATrip});
final bool isATrip;
  @override
  State<DefaultWidget> createState() => _DefaultWidgetState();
}

class _DefaultWidgetState extends State<DefaultWidget> {
bool isFavourite = false;
  @override
  void initState() {
    isFavourite = false;
    context.read<HomeCubit>().paymentMoney = 0;
    context.read<HomeCubit>().distance = 0;
if(widget.isATrip)
  isFavourite = true;
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<HomeCubit, HomeState>(
  listener: (context, state) {
    if (state is ChangeFavouriteState){
      setState(() {
        isFavourite = false;
      });

   //  context.read<HomeCubit>(). paymentMoney = context.read<HomeCubit>().distance * context.read<HomeCubit>().settingsModel.data!.km!;
    }
if (state is SuccessCreateSchedualTripState){
  print('dddddsadas');
//  Navigator.pushReplacement(
//      context, MaterialPageRoute(builder: (context) => Home(),));
}
  },
  builder: (context, state) {
    HomeCubit cubit = context.read<HomeCubit>();
    return

      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
           // height: getSize(context) * 0.8,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: AppColors.black.withOpacity(0.25),
                      blurRadius: 10,
                      spreadRadius: 10,
                      offset: Offset(4, 4))
                ],
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: getSize(context) * 0.07,
                ),
                //search field
                Visibility(
                  visible: context.read<HomeCubit>().flag == 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: getSize(context)*0.7,
                          //  height: getSize(context)/4,
                          child: CustomTextField(
                            suffixIcon: IconButton(

                             // icon:Icon(Icons.favorite_border),
                              icon:isFavourite?  Icon(


                                Icons.favorite_outlined,color: Colors.red,)
                              :Icon(Icons.favorite_border),

                              onPressed: () {

                              if(cubit.location_control.text != "" &&cubit.destination!=LatLng(0, 0)){
                                setState(() {
                                  isFavourite = true;
                                });
                                cubit.addFavourite(address: cubit.location_control.text!, lat: cubit.destination.latitude.toString(), long: cubit.destination.longitude.toString(), context: context);
                              }
                              else{
                                errorGetBar("the location is empty ");
                              }
                            },),
                            title: 'search_location'.tr(),
                            backgroundColor: AppColors.white,
                            prefixWidget: SizedBox(
                                height: 10,
                                width: 10,
                                child:
                                Icon(Icons.pin_drop_outlined,size: 25,)
                              // MySvgWidget(
                              //   path: ImageAssets.mapIcon,
                              //   imageColor: AppColors.black,
                              //   size: 5,
                              // ),
                            ),
                            validatorMessage: 'loaction_msg'.tr(),
                            horizontalPadding: 2,
                            textInputType: TextInputType.text,
                            onchange: (p0) {
                              cubit.search(p0);
                        setState(() {
                          isFavourite =false;
                        });
                            },
                            controller: cubit.location_control,
                          ),
                        ),

                        Flexible(
                          child: TextButton(onPressed: () {
                            Navigator.pushNamed(
                                context, Routes.favoriteRoute);
                          }, child: Text("favourites".tr(),style: getBoldStyle(color: AppColors.red),)),
                        )
                      ],
                    ),
                  ),

                ),
                SizedBox(
                  height: 15,
                ),
    //       Container(
    //           padding: EdgeInsets.all(10),
    //           alignment: Alignment.center,
    //           child: EasyAutocomplete(
    //               suggestions: ['Afeganistan', 'Albania', 'Algeria', 'Australia', 'Brazil', 'German', 'Madagascar', 'Mozambique', 'Portugal', 'Zambia'],
    //               cursorColor: Colors.purple,
    //               decoration: InputDecoration(
    //                   contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
    //                   focusedBorder: OutlineInputBorder(
    //                       borderRadius: BorderRadius.circular(5),
    //                       borderSide: BorderSide(
    //                           color: Colors.purple,
    //                           style: BorderStyle.solid
    //                       )
    //                   ),
    //                   enabledBorder: OutlineInputBorder(
    //                       borderRadius: BorderRadius.circular(5),
    //                       borderSide: BorderSide(
    //                           color: Colors.purple,
    //                           style: BorderStyle.solid
    //                       )
    //                   )
    //               ),
    //               suggestionBuilder: (data) {
    //                 return Container(
    //                     margin: EdgeInsets.all(1),
    //                     padding: EdgeInsets.all(5),
    //                     decoration: BoxDecoration(
    //                         color: Colors.purple,
    //                         borderRadius: BorderRadius.circular(5)
    //                     ),
    //                     child: Text(
    //                         data,
    //                         style: TextStyle(
    //                             color: Colors.white
    //                         )
    //                     )
    //                 );
    //               },
    //               onChanged: (value) => print(value)
    //   )
    // ),


                if(cubit.placesList.isNotEmpty)
                SizedBox(
                  height: getSize(context)/4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: ListView.separated(

                        itemBuilder: (context, index) => InkWell(

                            onTap: () {

                              cubit.location_control.text =cubit.placesList[index].name;
                              cubit.setSearchResult(LatLng(cubit.placesList[index].geometry.location.lat, cubit.placesList[index].geometry.location.lng));
                              cubit.placesList =[];

                            },
                            child:

                            Text(cubit.placesList[index].name,style: getMediumStyle(
                              color: AppColors.blue
                            ),)),
                        separatorBuilder: (context, index) => SizedBox(height: 2,),
                        itemCount: cubit.placesList.length),
                  ),
                ),
                Row(
                //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Text("payment_method").tr(),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text("payment_quantity").tr(),
                    ),
                  ],
                ),
                //cash

                Row(
                 // mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: getSize(context)/3,
                      height: getSize(context)/6.5,
                      child: RadioListTile(
                        title: Text("cash").tr(),
                        value: cubit.payment,
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 10),
                        tileColor: AppColors.black1,
                        activeColor: AppColors.primary,
                        selected: true,
                        groupValue: cubit.payment,
                        onChanged: (value) {
                          cubit.changeRadioButton(value);
                        },
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text("${cubit.paymentMoney.toStringAsFixed(1)}"),
                    ),
                  ],
                ),
                //SizedBox(height: 5,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //ride_later
                    CustomButton(
                      text: "ride_later".tr(),
                      color: AppColors.primary,
                      borderRadius: 16,
                      onClick: () async {
                        print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
                        await cubit.selectDateAndTime(context);
                      },
                      width: getSize(context) / 2,
                    ),
                    //  ride_now"
                    Container(
                      //   padding: EdgeInsets.symmetric(horizontal: 1),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              width: 3, color: AppColors.primary)),
                      child: CustomButton(
                        borderRadius: 16,
                        text: "ride_now".tr(),
                        color: AppColors.white,
                        textcolor: AppColors.primary,
                        onClick: () async {
                         // cubit.bottomContainerInitialState=false;
                          // cubit.bottomContainerLoadingState = true;

                         // cubit.startTimer(context);
                          context.read<UserTripCubit>().getWaitingDriverStage();
                          await  cubit.createTrip(tripType: cubit.flag==1?"with":"without",context: context);
                          // cubit.changeToRideNowState();
                        },
                        width: getSize(context) / 3,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 8,)
              ],
            )),
      )
   // )
    ;
  },
);
  }
}
