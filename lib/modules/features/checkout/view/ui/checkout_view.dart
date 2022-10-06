import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:java_code/modules/features/checkout/controller/checkout_controller.dart';
import 'package:java_code/modules/features/checkout/view/components/checkout_empty_state.dart';
import 'package:java_code/modules/features/home/view/components/state_view_status_menu/empty_state_view.dart';
import 'package:java_code/modules/features/home/view/components/state_view_status_menu/error_state_view.dart';
import 'package:java_code/modules/features/no_connecntion/view/ui/no_connection_view.dart';
import 'package:java_code/modules/global_controllers/check_connection_controller.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '/modules/features/checkout/view/components/checkout_riwayat.dart';
import '/config/themes/colours.dart';

import '/modules/features/checkout/view/components/checkout_sedang_berjalan.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.bgColors,
      body: Obx(
        () => ConnectionManagerController.to.connectionType.value != 0
            ?

            /// pengkondisian status keadaan
            ConditionalSwitch.single(
                context: context,
                valueBuilder: (context) => CheckoutController.to.loading.value,
                caseBuilders: {
                  'loading': (context) => Center(
                        child: LoadingAnimationWidget.prograssiveDots(color: Colours.green2, size: 100),
                      ),
                  'empty': (context) => const EmptyStateView(),
                  'error': (context) => const ErrorStateView()
                },
                fallbackBuilder: (context) => SafeArea(
                  child: Column(
                    children: [
                      // APPBAR
                      Material(
                        elevation: 2,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30.sp),
                          bottomRight: Radius.circular(30.sp),
                        ),
                        child: Container(
                          width: ScreenUtil().screenWidth,
                          height: 66.h,
                          decoration: BoxDecoration(
                            color: Colours.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30.sp),
                              bottomRight: Radius.circular(30.sp),
                            ),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 15.h),
                              Container(
                                height: 40.h,
                                margin: EdgeInsets.only(left: 46.sp),
                                width: ScreenUtil().screenWidth,
                                child: ListView.builder(
                                  itemCount: 2,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Obx(
                                      () => InkWell(
                                        onTap: () {
                                          CheckoutController.to.current.value = index;
                                          if (index == 1) {
                                            CheckoutController.to.filterData('all_status'.tr);
                                          }
                                        },
                                        child: SizedBox(
                                          width: 173.w,
                                          child: Column(
                                            children: [
                                              Text(
                                                CheckoutController.to.nameButton[index],
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 20.sp,
                                                  color: CheckoutController.to.current.value == index ? Colours.green2 : Colours.darkGrey,
                                                ),
                                              ),
                                              SizedBox(height: 8.h),
                                              Visibility(
                                                child: Container(
                                                  height: 5.h,
                                                  width: 65.w,
                                                  decoration: BoxDecoration(
                                                    color: CheckoutController.to.current.value == index ? Colours.green2 : Colors.transparent,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 25.h),
                      // CONTENT
                      Obx(
                        () => CheckoutController.to.keranjang.value != 0
                            ? CheckoutController.to.current.value == 0
                                // SEDANG BERJALAN
                                ? const CheckoutSedangBerjalan()
                                // RIWAYAT
                                : const CheckoutRiwayat()
                            // EMPTY
                            : Obx(
                                () => CheckoutEmptyState(current: CheckoutController.to.current, textEmpty: CheckoutController.to.textEmpty),
                              ),
                      ),
                    ],
                  ),
                ),
              )
            : const NoConnectionView(),
      ),
    );
  }
}
