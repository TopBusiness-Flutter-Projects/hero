// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
//
// import '../../../../core/utils/assets_manager.dart';
// import '../../../../core/widgets/custom_text_form_field.dart';
//
// class CustomAddLink extends StatelessWidget {
//   const CustomAddLink({
//     super.key,
//     required this.title,
//     required this.hint,
//     this.validator,
//     this.onPressed,
//     this.controller,  this.isReward =false,  this.body, this.titleStyle, this.keyboardType,
//   });
//
//   final String title;
//   final TextStyle? titleStyle;
//   final String? body;
//   final String hint;
//   final bool isReward;
//   final void Function()? onPressed;
//   final String? Function(String?)? validator;
//   final TextEditingController? controller;
//   final TextInputType? keyboardType;
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<HomeCubit, HomeState>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         HomeCubit cubit = context.read<HomeCubit>();
//         return Padding(
//           padding:  EdgeInsets.only(
//                 bottom: MediaQuery.of(context).viewInsets.bottom),
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//             child: SingleChildScrollView(
//               physics: NeverScrollableScrollPhysics(),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                 isReward?  Align(
//                     alignment: Alignment.center,
//                     child: SvgPicture.asset(
//                       AppImages.greyLine,
//                       fit: BoxFit.fill,
//                     ),
//                   ):  Align(
//                     alignment: Alignment.centerLeft,
//                     child: GestureDetector(
//                         onTap: () => Navigator.pop(context),
//                         child: AppIcons.close),
//                   ),
//                   Text(
//                     title,
//                     style:titleStyle?? getBoldStyle(color:isReward  ?
//                        AppColors.rewardColor
//                         : AppColors.primaryText,fontSize: 18),
//                     textAlign: TextAlign.start,
//                   ),
//                   if(isReward)
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 5),
//                     child: Text(
//                       body!,
//                       style: getMediumStyle(fontSize: 16),
//                       textAlign: TextAlign.start,
//                     ),
//                   ),
//                   CustomTextField(
//                     labelText: hint,
//                     validator: validator,
//                     controller: controller,
//                     keyboardType:  keyboardType,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 15),
//                     child: CustomButton(
//                       buttonColor: AppColors.white,
//                       textColor: AppColors.primary,
//                       text: AppStrings.sure,
//                       onPressed: onPressed,
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
