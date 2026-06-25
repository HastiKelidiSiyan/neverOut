import 'package:flutter/material.dart';
import '../models/category_model.dart';

class Categories {
  static const foodAndGroceries = Category(
    id: 'food_and_groceries',
    name: 'Food & Groceries',
    icons: [
      Icons.local_grocery_store,
      Icons.shopping_basket,
      Icons.apple,
      Icons.egg,
      Icons.bakery_dining,
      Icons.lunch_dining,
      Icons.rice_bowl,
      Icons.icecream,
      Icons.coffee,
      Icons.local_cafe,
      Icons.local_drink,
      Icons.fastfood,
      Icons.restaurant,
      Icons.set_meal,
      Icons.cake,
      Icons.cookie,
    ],
  );

  static const cleaningSupplies = Category(
    id: 'cleaning_supplies',
    name: 'Cleaning Supplies',
    icons: [
      Icons.cleaning_services,
      Icons.soap,
      Icons.sanitizer,
      Icons.delete,
      Icons.delete_outline,
      Icons.water_drop,
      Icons.clean_hands,
    ],
  );

  static const personalCareAndHygiene = Category(
    id: 'personal_care_and_hygiene',
    name: 'Personal Care & Hygiene',
    icons: [
      Icons.face,
      Icons.shower,
      Icons.health_and_safety,
      Icons.clean_hands,
      Icons.spa,
      Icons.favorite,
      Icons.medication,
      Icons.monitor_heart,
    ],
  );

  static const kitchenEssentials = Category(
    id: 'kitchen_essentials',
    name: 'Kitchen Essentials',
    icons: [
      Icons.kitchen,
      Icons.flatware,
      Icons.restaurant,
      Icons.blender,
      Icons.microwave,
      Icons.soup_kitchen,
      Icons.coffee_maker,
      Icons.local_dining,
    ],
  );

  static const homeSupplies = Category(
    id: 'home_supplies',
    name: 'Home Supplies',
    icons: [
      Icons.home,
      Icons.lightbulb,
      Icons.handyman,
      Icons.chair,
      Icons.table_restaurant,
      Icons.weekend,
      Icons.bed,
      Icons.door_front_door,
      Icons.garage,
      Icons.window,
      Icons.battery_full,
      Icons.extension,
    ],
  );

  static const laundryAndFabricCare = Category(
    id: 'laundry_and_fabric_care',
    name: 'Laundry & Fabric Care',
    icons: [
      Icons.local_laundry_service,
      Icons.iron,
      Icons.checkroom,
      Icons.dry_cleaning,
      Icons.style,
      Icons.wash,
    ],
  );

  static const misc = Category(
    id: 'misc',
    name: 'Miscellaneous',
    icons: [
      Icons.category,
      Icons.inventory_2,
      Icons.inventory,
      Icons.shopping_cart,
      Icons.sell,
      Icons.label,
      Icons.bookmark,
      Icons.star,
      Icons.more_horiz,
      Icons.more_vert,
    ],
  );

  static const List<Category> all = [
    foodAndGroceries,
    cleaningSupplies,
    personalCareAndHygiene,
    kitchenEssentials,
    homeSupplies,
    laundryAndFabricCare,
    misc,
  ];
}