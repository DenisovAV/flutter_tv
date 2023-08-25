import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum VideoSourceType {
  asset,
  file,
  network,
}
