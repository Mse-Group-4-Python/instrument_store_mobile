import 'package:instrument_store_mobile/domain/entities/category_entity.dart';
import 'package:instrument_store_mobile/domain/entities/customer_entity.dart';
import 'package:instrument_store_mobile/domain/entities/customer_order_entity.dart';
import 'package:instrument_store_mobile/domain/entities/instrument_entity.dart';
import 'package:instrument_store_mobile/domain/entities/instrument_item_entity.dart';
import 'package:instrument_store_mobile/domain/entities/manufacturer_entity.dart';
import 'package:instrument_store_mobile/domain/entities/order_item_entity.dart';
import 'package:instrument_store_mobile/domain/entities/order_status_entity.dart';
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
import 'package:instrument_store_mobile/domain/services/services.dart';

import 'bases/base_repo.dart';

class CategoryRepo extends BaseRepo<
    int,
    CategoryEntity,
    CategoryModel,
    GetCategoriesQuery,
    PostCategoryBody,
    PutCategoryBody> implements CategoryService {
  CategoryRepo() : super(path: '/categories');
}

class CustomerRepo extends BaseRepo<
    int,
    CustomerEntity,
    CustomerModel,
    GetCustomersQuery,
    PostCustomerBody,
    PutCustomerBody> implements CustomerService {
  CustomerRepo() : super(path: '/customers');
}

class CustomerOrderRepo extends BaseRepo<
    int,
    CustomerOrderEntity,
    CustomerOrderModel,
    GetCustomerOrdersQuery,
    PostCustomerOrderBody,
    PutCustomerOrderBody> implements CustomerOrderService {
  CustomerOrderRepo() : super(path: '/customer-orders');
}

class InstrumentItemRepo extends BaseRepo<
    int,
    InstrumentItemEntity,
    InstrumentItemModel,
    GetInstrumentItemsQuery,
    PostInstrumentItemBody,
    PutInstrumentItemBody> implements InstrumentItemService {
  InstrumentItemRepo() : super(path: '/instrument-items');
}

class InstrumentRepo extends BaseRepo<
    int,
    InstrumentEntity,
    InstrumentModel,
    GetInstrumentsQuery,
    PostInstrumentBody,
    PutInstrumentBody> implements InstrumentService {
  InstrumentRepo() : super(path: '/instruments');
}

class ManufacturerRepo extends BaseRepo<
    int,
    ManufacturerEntity,
    ManufacturerModel,
    GetManufacturersQuery,
    PostManufacturerBody,
    PutManufacturerBody> implements ManufacturerService {
  ManufacturerRepo() : super(path: '/manufacturers');
}

class OrderItemRepo extends BaseRepo<
    int,
    OrderItemEntity,
    OrderItemModel,
    GetOrderItemsQuery,
    PostOrderItemBody,
    PutOrderItemBody> implements OrderItemService {
  OrderItemRepo() : super(path: '/order-items');
}

class OrderStatusRepo extends BaseRepo<
    int,
    OrderStatusEntity,
    OrderStatusModel,
    GetOrderStatusesQuery,
    PostOrderStatusBody,
    PutOrderStatusBody> implements OrderStatusService {
  OrderStatusRepo() : super(path: '/order-statuses');
}
