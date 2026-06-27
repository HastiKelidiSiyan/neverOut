import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:never_out/models/category_model.dart';

class Categories {
  static const foodAndGroceries = Category(
    id: 'food_and_groceries',
    name: 'Food & Groceries',
    icons: [
      FontAwesomeIcons.appleWhole,
      FontAwesomeIcons.solidLemon,
      FontAwesomeIcons.leaf,
      FontAwesomeIcons.pepperHot,
      FontAwesomeIcons.seedling,
      FontAwesomeIcons.carrot,
      FontAwesomeIcons.fish,
      FontAwesomeIcons.drumstickBite,
      FontAwesomeIcons.cheese,
      FontAwesomeIcons.egg,
      FontAwesomeIcons.wineBottle,
      FontAwesomeIcons.bottleWater,
      FontAwesomeIcons.burger,
      FontAwesomeIcons.pizzaSlice,
      FontAwesomeIcons.iceCream,
      FontAwesomeIcons.breadSlice,
      FontAwesomeIcons.wheatAwn,
      FontAwesomeIcons.bacon,
      FontAwesomeIcons.jar,
      FontAwesomeIcons.iceCream,
      FontAwesomeIcons.stroopwafel,
      FontAwesomeIcons.hotdog,
      FontAwesomeIcons.jarWheat,
      FontAwesomeIcons.cookie,
      FontAwesomeIcons.bowlRice,
      FontAwesomeIcons.cakeCandles,
    ],
  );

  static const cleaningSupplies = Category(
    id: 'cleaning_supplies',
    name: 'Cleaning Supplies',
    icons: [
      FontAwesomeIcons.pumpSoap,
      FontAwesomeIcons.soap,
      FontAwesomeIcons.bucket,
      FontAwesomeIcons.broom,
      FontAwesomeIcons.shieldVirus,
      FontAwesomeIcons.bath,
      FontAwesomeIcons.jugDetergent,
      FontAwesomeIcons.toiletPaper,
      FontAwesomeIcons.sprayCan,
      FontAwesomeIcons.boxTissue,
    ],
  );

  static const personalCareAndHygiene = Category(
    id: 'personal_care_and_hygiene',
    name: 'Personal Care & Hygiene',
    icons: [
      FontAwesomeIcons.sprayCanSparkles,
      FontAwesomeIcons.bottleDroplet,
      FontAwesomeIcons.shower,
      FontAwesomeIcons.handSparkles,
      FontAwesomeIcons.spa,
      FontAwesomeIcons.heartPulse,
      FontAwesomeIcons.pills,
      FontAwesomeIcons.tablets,
      FontAwesomeIcons.capsules,
      FontAwesomeIcons.bandage,
      FontAwesomeIcons.pumpMedical,
      FontAwesomeIcons.prescriptionBottleMedical,
      FontAwesomeIcons.maskFace,
      FontAwesomeIcons.dumbbell,
      FontAwesomeIcons.kitMedical,
    ],
  );

  static const kitchenEssentials = Category(
    id: 'kitchen_essentials',
    name: 'Kitchen Essentials',
    icons: [
      FontAwesomeIcons.kitchenSet,
      FontAwesomeIcons.utensils,
      FontAwesomeIcons.bowlFood,
      FontAwesomeIcons.blender,
      FontAwesomeIcons.mugHot,
      FontAwesomeIcons.jar,
      FontAwesomeIcons.wineGlass,
      FontAwesomeIcons.plateWheat,
      FontAwesomeIcons.sheetPlastic,
      FontAwesomeIcons.mugSaucer,
      FontAwesomeIcons.sink,
      FontAwesomeIcons.martiniGlassCitrus,
      FontAwesomeIcons.bagShopping,
      FontAwesomeIcons.boxesPacking,
      FontAwesomeIcons.beerMugEmpty,
      FontAwesomeIcons.spoon,
      FontAwesomeIcons.mitten,
    ],
  );

  static const homeSupplies = Category(
    id: 'home_supplies',
    name: 'Home Supplies',
    icons: [
      FontAwesomeIcons.houseChimney,
      FontAwesomeIcons.couch,
      FontAwesomeIcons.bed,
      FontAwesomeIcons.chair,
      FontAwesomeIcons.solidLightbulb,
      FontAwesomeIcons.batteryFull,
      FontAwesomeIcons.toolbox,
      FontAwesomeIcons.screwdriverWrench,
      FontAwesomeIcons.fan,
      FontAwesomeIcons.plug,
      FontAwesomeIcons.faucet,
      FontAwesomeIcons.tape,
      FontAwesomeIcons.shoePrints,
    ],
  );

  static const misc = Category(
    id: 'misc',
    name: 'Miscellaneous',
    icons: [
      FontAwesomeIcons.box,
      FontAwesomeIcons.boxOpen,
      FontAwesomeIcons.book,
      FontAwesomeIcons.tag,
      FontAwesomeIcons.tags,
      FontAwesomeIcons.solidStar,
      FontAwesomeIcons.gift,
      FontAwesomeIcons.solidBookmark,
      FontAwesomeIcons.ellipsis,
    ],
  );

  static const List<Category> all = [
    foodAndGroceries,
    cleaningSupplies,
    personalCareAndHygiene,
    kitchenEssentials,
    homeSupplies,
    misc,
  ];
}
