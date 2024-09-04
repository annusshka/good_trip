import 'package:freezed_annotation/freezed_annotation.dart';

part 'welcome_info.freezed.dart';
part 'welcome_info.g.dart';

@freezed
class WelcomeInfo with _$WelcomeInfo {
  const WelcomeInfo._();

  const factory WelcomeInfo({
    required String text,
    required String subtext,
    required String image,
  }) = _WelcomeInfo;

  factory WelcomeInfo.fromJson(Map<String, Object?> json) =>
      _$WelcomeInfoFromJson(json);

}
