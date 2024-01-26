import 'package:instrument_store_mobile/domain/models/category_model.dart';
import 'package:instrument_store_mobile/domain/models/customer_model.dart';
import 'package:instrument_store_mobile/domain/models/customer_order_model.dart';
import 'package:instrument_store_mobile/domain/models/instrument_item_model.dart';
import 'package:instrument_store_mobile/domain/models/instrument_model.dart';
import 'package:instrument_store_mobile/domain/models/manufacturer_model.dart';
import 'package:instrument_store_mobile/domain/models/order_item_model.dart';
import 'package:instrument_store_mobile/domain/models/order_status_model.dart';
import 'package:instrument_store_mobile/domain/requests/category/get_categories_query.dart';
import 'package:instrument_store_mobile/domain/requests/category/post_category_body.dart';
import 'package:instrument_store_mobile/domain/requests/category/put_category_body.dart';
import 'package:instrument_store_mobile/domain/requests/customer/get_customers_query.dart';
import 'package:instrument_store_mobile/domain/requests/customer/post_customer_body.dart';
import 'package:instrument_store_mobile/domain/requests/customer/put_customer_body.dart';
import 'package:instrument_store_mobile/domain/requests/customer_order/get_customer_orders_query.dart';
import 'package:instrument_store_mobile/domain/requests/customer_order/post_customer_order_body.dart';
import 'package:instrument_store_mobile/domain/requests/customer_order/put_customer_order_body.dart';
import 'package:instrument_store_mobile/domain/requests/instrument/get_instruments_query.dart';
import 'package:instrument_store_mobile/domain/requests/instrument/post_instrument_body.dart';
import 'package:instrument_store_mobile/domain/requests/instrument/put_instrument_body.dart';
import 'package:instrument_store_mobile/domain/requests/instrument_item/get_instrument_items_query.dart';
import 'package:instrument_store_mobile/domain/requests/instrument_item/post_instrument_item_body.dart';
import 'package:instrument_store_mobile/domain/requests/instrument_item/put_instrument_item_body.dart';
import 'package:instrument_store_mobile/domain/requests/manufacturer/get_manufacturers_query.dart';
import 'package:instrument_store_mobile/domain/requests/manufacturer/post_manufacturer_body.dart';
import 'package:instrument_store_mobile/domain/requests/manufacturer/put_manufacturer_body.dart';
import 'package:instrument_store_mobile/domain/requests/order_item/get_order_items_query.dart';
import 'package:instrument_store_mobile/domain/requests/order_item/post_order_item_body.dart';
import 'package:instrument_store_mobile/domain/requests/order_item/put_order_item_body.dart';
import 'package:instrument_store_mobile/domain/requests/order_status/get_order_statuses_query.dart';
import 'package:instrument_store_mobile/domain/requests/order_status/post_order_status_body.dart';
import 'package:instrument_store_mobile/domain/requests/order_status/put_order_status_body.dart';
import 'package:instrument_store_mobile/infrastructure/repositories/api_repo.dart';

import 'bases/base_service.dart';

mixin ServiceMixin {
  ServiceFactory get serviceFactory => ServiceFactory.instance;
}

class ServiceFactory {
  ServiceFactory._();

  static final ServiceFactory _instance = ServiceFactory._();

  static ServiceFactory get instance {
    return _instance;
  }

  void init({
    InstrumentService? instrumentService,
    CategoryService? categoryService,
    CustomerService? customerService,
    CustomerOrderService? customerOrderService,
    InstrumentItemService? instrumentItemService,
    ManufacturerService? manufacturerService,
    OrderItemService? orderItemService,
    OrderStatusService? orderStatusService,
  }) {
    _instrumentService = instrumentService ?? InstrumentRepo();
    _categoryService = categoryService ?? CategoryRepo();
    _customerService = customerService ?? CustomerRepo();
    _customerOrderService = customerOrderService ?? CustomerOrderRepo();
    _instrumentItemService = instrumentItemService ?? InstrumentItemRepo();
    _manufacturerService = manufacturerService ?? ManufacturerRepo();
    _orderItemService = orderItemService ?? OrderItemRepo();
    _orderStatusService = orderStatusService ?? OrderStatusRepo();
  }

  late final InstrumentService _instrumentService;
  InstrumentService get instrumentService => _instrumentService;

  late final CategoryService _categoryService;
  CategoryService get categoryService => _categoryService;

  late final CustomerService _customerService;
  CustomerService get customerService => _customerService;

  late final CustomerOrderService _customerOrderService;
  CustomerOrderService get customerOrderService => _customerOrderService;

  late final InstrumentItemService _instrumentItemService;
  InstrumentItemService get instrumentItemService => _instrumentItemService;

  late final ManufacturerService _manufacturerService;
  ManufacturerService get manufacturerService => _manufacturerService;

  late final OrderItemService _orderItemService;
  OrderItemService get orderItemService => _orderItemService;

  late final OrderStatusService _orderStatusService;
  OrderStatusService get orderStatusService => _orderStatusService;
}

abstract class CategoryService extends BaseService<int, CategoryModel,
    GetCategoriesQuery, PostCategoryBody, PutCategoryBody> {}

abstract class CustomerService extends BaseService<int, CustomerModel,
    GetCustomersQuery, PostCustomerBody, PutCustomerBody> {}

abstract class CustomerOrderService extends BaseService<int, CustomerOrderModel,
    GetCustomerOrdersQuery, PostCustomerOrderBody, PutCustomerOrderBody> {}

abstract class InstrumentItemService extends BaseService<
    int,
    InstrumentItemModel,
    GetInstrumentItemsQuery,
    PostInstrumentItemBody,
    PutInstrumentItemBody> {}

abstract class InstrumentService extends BaseService<int, InstrumentModel,
    GetInstrumentsQuery, PostInstrumentBody, PutInstrumentBody> {}

abstract class ManufacturerService extends BaseService<int, ManufacturerModel,
    GetManufacturersQuery, PostManufacturerBody, PutManufacturerBody> {}

abstract class OrderItemService extends BaseService<int, OrderItemModel,
    GetOrderItemsQuery, PostOrderItemBody, PutOrderItemBody> {}

abstract class OrderStatusService extends BaseService<int, OrderStatusModel,
    GetOrderStatusesQuery, PostOrderStatusBody, PutOrderStatusBody> {}
