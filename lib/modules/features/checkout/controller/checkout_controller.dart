import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:java_code/config/routes/app_routes.dart';
import 'package:java_code/modules/features/checkout/repositories/checkout_repositories.dart';
import 'package:java_code/modules/models/get_order_by_user_id/get_order_by_user_id.dart';
import 'package:java_code/modules/models/history_order_by_user_id/history_order_by_user_id.dart';
import 'package:java_code/modules/models/history_order_by_user_id/list_data_order.dart';
import 'package:java_code/modules/models/order_list_by_iduser_res_model/order_history.dart';
import 'package:java_code/modules/models/post_order_res/post_order_res.dart';
import 'package:java_code/shared/widgets/custom_button.dart';

class CheckoutController extends GetxController {
  static CheckoutController get to => Get.find();
  RxString loading = 'loading'.obs;

  CheckoutRepository repository = CheckoutRepository();
  GetOrderByUserId resultOrder = GetOrderByUserId();

  /// NAME BUTTON
  List<String> nameButton = [
    'underway'.tr,
    'history'.tr,
  ];

  RxInt current = 0.obs;
  RxInt keranjang = 0.obs;

  /// TEXT EMPTY
  List<String> textEmpty = [
    'Sudah Pesan? \nLacak pesananmu di sini.',
    'Makanan yang kamu pesan akan muncul disini agar kamu bisa menemukan menu favoritmu lagi!',
  ];

  var dropdownItems = [
    'all_status'.tr,
    'done'.tr,
    'canceled'.tr,
  ];

  RxString selectedDropdownItem = 'all_status'.tr.obs;

  List<Order>? listHistoryOrderFilterred = [];
  List<Order>? listHistoryOrderFilterredDone = [];
  List<Order>? listHistoryOrderFilterredBatal = [];
  List<Order>? listHistoryOrderDataAll = [];
  List<Order>? listHistoryOrderData = [];
  // OrderListByIdUserResModel? orderHistory;
  HistoryOrderByUserId orderHistory = HistoryOrderByUserId();

  /// MEMBUAT GETTER UNTUK MENDAMPILKAN LIST MENU SESUAI DENGAN KEBUTUHAN
  RxList<ListDataOrder>? listSemuaStatus = <ListDataOrder>[].obs;
  RxList<ListDataOrder>? listSelesai = <ListDataOrder>[].obs;
  RxList<ListDataOrder>? listDibatalkan = <ListDataOrder>[].obs;
  filterData(String data) async {
    selectedDropdownItem.value = data;

    // ignore: prefer_is_empty
    if (orderHistory.data?.listData?.length != 0) {
      switch (data) {
        case 'Selesai':
          listSelesai?.value = orderHistory.data!.listData!.where((e) => e.status == 3).toList();
          break;
        case 'Done':
          listSelesai?.value = orderHistory.data!.listData!.where((e) => e.status == 3).toList();
          break;
        case 'Dibatalkan':
          listSelesai?.value = orderHistory.data!.listData!.where((e) => e.status == 4).toList();
          break;
        case 'Canceled':
          listSelesai?.value = orderHistory.data!.listData!.where((e) => e.status == 4).toList();
          break;
        default:
          listSelesai?.value = orderHistory.data!.listData!;
          break;
      }

      update();
    }
  }

  DateTimeRange? selectedDateRange;
  DateTime? startDate;
  DateTime? endDate;

  String startDateString = "";
  String endDateString = "";

  DateFormat formatter = DateFormat('dd/MM/yy');
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  void showMyDatePicker() async {
    final DateTimeRange? result = await showDateRangePicker(
      context: Get.context!,
      firstDate: DateTime(2020, 1, 1),
      lastDate: DateTime(2030, 12, 31),
      currentDate: DateTime.now(),
      saveText: 'done'.tr,
    );

    if (result != null) {
      // Rebuild the UI
      selectedDateRange = result;
      startDate = result.start;
      endDate = result.end;

      startDateString = formatter.format(startDate!).toString();
      endDateString = formatter.format(endDate!).toString();

      await filterDataInDateRange();
    }
    update();
  }

  filterDataInDateRange() async {
    await filterData(selectedDropdownItem.value);
    List<Order> tempOrder = [];
    tempOrder.addAll(listHistoryOrderFilterred!);
    listHistoryOrderFilterred!.clear();

    for (var i = 0; i < tempOrder.length; i += 1) {
      var date = dateFormat.parse(tempOrder[i].tanggal!);
      if (date.compareTo(startDate!) >= 0 && date.compareTo(endDate!) <= 0) {
        listHistoryOrderFilterred!.add(tempOrder[i]);
      }
    }
  }

  /// GET ORDER BY ID USER
  Future<void> getOrderByIdUser() async {
    GetOrderByUserId res = await repository.getOrderByIdUser();

    if (res.statusCode == 200) {
      loading.value = 'sukses';
      keranjang.value = 1;
      // log('ISI VALUE GET ORDER : ${res.toJson()}');
      resultOrder = res;
      // log('ISI VALUE RESULT ORDER : ${resultOrder.toJson()}');
    } else if (res.statusCode == 204) {
      loading.value = 'empty';
      log('DATA EMPTY');
    } else {
      loading.value = 'error';
      log('DATA ERROR');
    }
  }

  /// GET ORDER BY ID USER
  Future<void> getHistoryOrder() async {
    HistoryOrderByUserId res = await repository.getHistoryOrder();

    if (res.statusCode == 200) {
      if (res.data != null) {
        log(res.toJson().toString());
        orderHistory = res;
        log('checkout controller orderHistory : ${orderHistory.toJson()}');
      }

      log('ISI VALUE RESULT ORDER : ${res.toJson()}');
    } else if (res.statusCode == 204) {
      log('DATA EMPTY');
    } else {
      log('DATA ERROR');
    }
  }

  initialFun() async {
    update();
    endDate = DateTime.now();
    startDate = endDate!.subtract(const Duration(days: 7));

    startDateString = formatter.format(startDate!).toString();
    endDateString = formatter.format(endDate!).toString();

    await getHistoryOrder();

    update();
  }

  Future<dynamic> pesanLagiFunction({required ListDataOrder order}) async {
    return showDialog(
      context: Get.context!,
      builder: (builder) {
        return AlertDialog(
          title: Text("re_order_asking".tr),
          actions: [
            GestureDetector(
              onTap: () async {
                PostOrderRes? isSent = await repository.reOrderReques(dataOrderMenu: order);

                Get.snackbar("order_menu_success_title".tr, "order_menu_success_message".trParams({'length': '${order.menu?.length ?? 0}', 'totalBayar': ' ${order.totalBayar}'}));
                // Get.close(1);
                // Get.to(PesananTrackingView(id: isSent.dataOrder!.idOrder!));
                Get.offAllNamed(AppRoutes.pesananTrackingView, arguments: {'id_order': isSent.data?.idOrder ?? 0});
              },
              child: SizedBox(
                width: 100,
                child: ButtonComponents(
                  buttonTitle: "ok".tr,
                ),
              ),
            )
          ],
        );
      },
    );
  }

  @override
  void onInit() async {
    await getOrderByIdUser();
    initialFun();
    selectedDropdownItem.value = 'all_status'.tr;
    update();
    super.onInit();
  }
}
