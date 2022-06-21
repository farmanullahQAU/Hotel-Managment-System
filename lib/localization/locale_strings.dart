import 'package:baidarg/localization/locale_constants.dart';
import 'package:get/get.dart';
class AppTranslation extends Translations {
@override
Map<String, Map<String, String>> get keys => {
'en_US': {
"Bean": 'Beans',
},
'ur': {
'Bean': LocaleConstants.lobya,
LocaleConstants.title:LocaleConstants.titleUrdu

}
};
}