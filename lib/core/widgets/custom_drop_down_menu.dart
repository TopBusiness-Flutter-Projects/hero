import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_fonts.dart';
import '../utils/getsize.dart';
import 'custom_bordered_container.dart';

class CustomDropDownMenu extends StatefulWidget {
  const CustomDropDownMenu({super.key, this.items, required this.text,  this.onChanged, this.dropdownValue});
final List<DropdownMenuItem<String>>? items;
final String text;
final String? dropdownValue;

final  void Function(String?)? onChanged;

  @override
  State<CustomDropDownMenu> createState() => _CustomDropDownMenuState();
}

class _CustomDropDownMenuState extends State<CustomDropDownMenu> {
  //String? dropdownValue;

  @override
  Widget build(BuildContext context) {

    return    Container(
      width: double.maxFinite,
      padding:
      EdgeInsets.symmetric(horizontal: getSize(context) / 32),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.gray6),
          borderRadius: BorderRadius.all(
              Radius.circular(getSize(context) / 66))),

      child: Center(
        child: DropdownButtonFormField2<String>(
isExpanded: true,
         // isExpanded: true,
          decoration: InputDecoration(
            fillColor: AppColors.white,
            filled: true,
            //  contentPadding: const EdgeInsets.symmetric(vertical: 16),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          value: widget.dropdownValue,
          style: getRegularStyle(fontSize: 15),
          onChanged:widget.onChanged,

          items: widget.items,
        // hint: Text(
        //   "",
        //   maxLines: 1,
        //   style: TextStyle(
        //       fontWeight: FontWeight.w700,
        //       fontSize: getSize(context) / 24,
        //       color: AppColors.primary),
        // ),

          validator: (value) {
            if (value == null) {
              return null;
            }
            return null;
          },

          buttonStyleData: const ButtonStyleData(
            padding: EdgeInsets.only(right: 8),
          ),
          iconStyleData: IconStyleData(
            iconSize: 0,
          ),
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            padding: EdgeInsets.symmetric(horizontal: 16),
          ),
        ),
      )
    );








  // CustomBorderedContainer(
  //       isDropDown: true,
  //       child:  DropdownButtonHideUnderline(
  //     child: DropdownButton<String>(
  //       icon: AppIcons.arrowDown,
  //       hint: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Text(
  //             widget. text,
  //             style: getRegularStyle(color: AppColors.primaryGrey),
  //           ),
  //           //AppIcons.arrowDown
  //         ],
  //       ),
  //       value: widget.dropdownValue,
  //       style: getRegularStyle(),
  //       onChanged:widget.onChanged,
  //       // onChanged: (String? value) {
  //       //   setState(() {
  //       //     widget.dropdownValue = value!;
  //       //     widget.  onPressed;
  //       //
  //       //     // cubit.setInterestId(dropdownValue!);
  //       //     //  print("dddd${cubit.checkInterestId}");
  //       //   });
  //       // },
  //       items: widget.items,
  //       // items: cubit.interestsModel!.data!
  //       //     .map(
  //       //       (e) => DropdownMenuItem<String>(
  //       //     value: e.id.toString(),
  //       //     child: Text(e.name!),
  //       // ),
  //       //)
  //       //    .toList(),
  //     ),
  //   ));
  }
}
