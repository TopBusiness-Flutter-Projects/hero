import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_fonts.dart';

class CustomTextFormField extends StatefulWidget {
  final String? labelText;
  final Function()? onTap;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final String? initialValue;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final bool isMessage;
  final bool isPassword;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  //FocusNode myFocusNode = FocusNode();
  const CustomTextFormField(
      {super.key,
      required this.labelText,
      this.prefixIcon,
      this.validator,
      this.suffixIcon,
      this.keyboardType = TextInputType.text,
      this.isMessage = false,
      this.controller,
      this.initialValue,
      this.onChanged,
      this.onTap,
      this.isPassword = false,
      this.onSubmitted,});

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  FocusNode myFocusNode = FocusNode();

  void initState() {
    super.initState();

    myFocusNode.addListener(() {
      setState(() {
        // color = Colors.black;
      });
    });
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.isMessage?150:null,

      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: TextFormField(
            controller: widget.controller,
            onTap: widget.onTap,
            onTapOutside: (event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            focusNode: myFocusNode,
            style: getBoldStyle(),
            onChanged: widget.onChanged,
            validator: widget.validator,
            keyboardType: widget.keyboardType,
            initialValue: widget.initialValue,
            obscureText: widget.isPassword ?? false,
            maxLines: widget.isMessage ? 5 : 1,
            minLines: widget.isMessage ?5 : 1,
            onFieldSubmitted: widget.onSubmitted,
            decoration: InputDecoration(

                filled: true,
                fillColor: AppColors.white,
                labelText: widget.labelText,
                labelStyle: getRegularStyle(

                    fontHeight: 1.5,
                    color: myFocusNode.hasFocus
                        ? AppColors.primary
                        : AppColors.gray6),
                prefixIcon: widget.prefixIcon,
                // prefixIconColor: myFocusNode.hasFocus ? ColorManager.primary : ColorManager.primaryGrey,
                suffixIcon: widget.suffixIcon,
                contentPadding: EdgeInsets.all(8),
                hintStyle:
                    getRegularStyle(color: AppColors.gray6, fontSize: 14),
                errorStyle: getRegularStyle(color: AppColors.red),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.gray6, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(8))),

                // focused border style
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primary, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(8))),

                // error border style
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.red, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.red, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(8))))),
      ),
    );
  }
}
