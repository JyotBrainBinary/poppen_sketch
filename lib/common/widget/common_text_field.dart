import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sketch/utils/color_res.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField(
      {super.key,
      this.hintText,
      this.maxLines,
      this.prefixIcon,
      this.borderColor,
      this.containtPadding,
      this.istitle,
      this.isMobile,
      this.mobileWidget,
      this.title,

      this.controller});
  final String? hintText;
  final int? maxLines;
  final String? prefixIcon;
  final Color? borderColor;
  final double? containtPadding;
  final bool? istitle;
  final String? title;
  final bool? isMobile;
  final Widget? mobileWidget;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return istitle ?? false
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 3),
                child: Text(
                  title ?? "",
                  style: const TextStyle(
                    color: ColorRes.colorBlack,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              SizedBox(
                // height: 43,
                child: TextFormField(
                  controller: controller,

                  // minLines: 8,
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                  maxLines: maxLines ?? 1,

                  decoration: InputDecoration(
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(26),
                        borderSide: const BorderSide(
                          width: 1,
                          color: ColorRes.colorEBEBEB, //this has no effect
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(26),
                        borderSide: const BorderSide(
                          width: 1,
                          color: ColorRes.colorEBEBEB, //this has no effect
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(26),
                        borderSide: const BorderSide(
                          width: 1,
                          color: Colors.red, //this has no effect
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(26),
                        borderSide: BorderSide(
                          width: 1,
                          color: borderColor != null
                              ? borderColor!
                              : ColorRes.colorEBEBEB, //this has no effect
                        ),
                      ),
                      contentPadding: EdgeInsets.only(
                          top: containtPadding != null ? containtPadding! : 20,
                          left: isMobile == true ? 20 : 10),
                      filled: true,
                      hintText: hintText ?? "",
                      prefixIcon: prefixIcon == null && isMobile == null
                          ? const SizedBox()
                          : isMobile == true
                              ? mobileWidget
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Image.asset(
                                    prefixIcon ?? '',
                                  ),
                                ),
                      // prefixIconColor: ColorRes.black,

                      prefixIconConstraints: const BoxConstraints(
                          minHeight: 14,
                          maxHeight: 22,
                          maxWidth: 40,
                          minWidth: 15),
                      hintStyle: const TextStyle(
                        color: ColorRes.colorB5B5B5,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: borderColor != null
                              ? borderColor!
                              : ColorRes.colorEBEBEB, //this has no effect
                        ),
                        borderRadius: BorderRadius.circular(26),
                      ),
                      fillColor: ColorRes.colorWhite),
                ),
              ),
            ],
          )
        : TextFormField(
            // minLines: 8,
            controller: controller,

            style: const TextStyle(color: Colors.black, fontSize: 14),
            maxLines: maxLines ?? 1,

            decoration: InputDecoration(
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(26),
                  borderSide: const BorderSide(
                    width: 1,
                    color: ColorRes.colorEBEBEB, //this has no effect
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(26),
                  borderSide: BorderSide(
                    width: 1,
                    color: borderColor != null
                        ? borderColor!
                        : ColorRes.colorEBEBEB, //this has no effect
                  ),
                ),
                contentPadding: EdgeInsets.only(
                    top: containtPadding != null ? containtPadding! : 20,
                    left: 10),
                filled: true,
                hintText: hintText ?? "",
                prefixIcon: prefixIcon == null
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Image.asset(
                          prefixIcon ?? '',
                        ),
                      ),
                // prefixIconColor: ColorRes.black,

                prefixIconConstraints: const BoxConstraints(
                    minHeight: 14, maxHeight: 22, maxWidth: 40, minWidth: 15),
                hintStyle: const TextStyle(
                  color: ColorRes.colorB5B5B5,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: borderColor != null
                        ? borderColor!
                        : ColorRes.colorEBEBEB, //this has no effect
                  ),
                  borderRadius: BorderRadius.circular(26),
                ),
                fillColor: ColorRes.colorWhite),
          );
  }
}
