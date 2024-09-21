library fire_weather_index_model;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'fire_weather_index_model.g.dart';

abstract class FireWeatherIndexModel
    implements Built<FireWeatherIndexModel, FireWeatherIndexModelBuilder> {
  FireWeatherIndexModel._();

  factory FireWeatherIndexModel(
          [void Function(FireWeatherIndexModelBuilder) updates]) =
      _$FireWeatherIndexModel;

  static Serializer<FireWeatherIndexModel> get serializer =>
      _$fireWeatherIndexModelSerializer;

  //@BuiltValueField(wireName: 'list')
  //BuiltList<FireWeatherIndex> get list;
}
//{
//  "coord": {
//     "lon":-103,
//     "lat": 24
// },
//  "list": [
//    {
//     "main": {
//        "fwi":70.53
//     },
//     "danger_rating:{
//        "description:"Extreme",
//        "value": "5"
//    },
//    "dt": "1677142800",
//    }
//  ]
//}
