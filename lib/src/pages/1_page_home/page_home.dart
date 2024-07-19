import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servicemangerapp/src/data/provider/firebase_provider.dart';
import 'package:servicemangerapp/src/pages/2_pages_buttom/page_clients/page_list_clientes.dart';
import 'package:servicemangerapp/src/pages/2_pages_buttom/page_make_service_order/page_make_service_order.dart';
import 'package:servicemangerapp/src/pages/2_pages_buttom/page_my_service_orders/page_my_service_orders.dart';
import 'package:servicemangerapp/src/pages/widgets/buttomHomePageWidget.dart';
import 'package:servicemangerapp/src/pages/widgets/buttomHomePageWidget2.dart';
import 'package:servicemangerapp/src/pages/widgets/drawerWIdget.dart';
import 'package:servicemangerapp/src/pages/widgets/statusServiceWidget.dart';
import 'package:servicemangerapp/src/utils/utils.dart';

class PageHome extends StatelessWidget {
  PageHome({super.key});
  ManagerProvider managerProvider = Get.put(ManagerProvider());
  @override
  Widget build(BuildContext context) {
    managerProvider.getUserProfile();
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(Icons.menu));
          },
        ),
      ),
      drawer:  Drawerwidget(managerProvider: managerProvider,),
             
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'lib/assets/logo-app.png',
                  fit: BoxFit.fitHeight,
                  height: 100,
                ),
                StatusServiceWidget(),
                ButtomHomePageWidget2(
                  func: (() {
                    Get.to(() => PageListClientes());
                  }),
                  nameButtom: 'Clientes',
                ),
                ButtomHomePageWidget2(
                  func: (() {
                    int numberServiceOrder = Utils.gerenateNumerServiceOrder();
                    Get.to(() => PageMakeServiceOrder(
                          numberServiceOrder: numberServiceOrder,
                        ));
                  }),
                  nameButtom: 'Criar Ordem de Serviço',
                ),
                ButtomHomePageWidget2(
                  func: (() {
                    Get.to(() => PageMyServiceOrders());
                  }),
                  nameButtom: 'Minhas Ordens de Serviço',
                ),
                ButtomHomePageWidget2(
                  func: (() {}),
                  nameButtom: 'Orçamentos',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
