import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/config/themes/text_styles.dart';
import 'package:ElevatED/features/presentation/0_common/default_appbar.dart';
import 'package:ElevatED/features/presentation/settings/screens/widgets/paragraph_widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.backgroundColor,
      appBar: defaultAppbar("privacy_policy".tr()),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "privacy_policy".tr(),
              style: getBoldStyle(fontSize: 24, color: ThemeColors.textColor),
            ),
            const SizedBox(height: 8),
            Text(
              'last_updated'.tr(),
              style: getRegularStyle(
                  fontSize: 16.sp, color: ThemeColors.textColor),
            ),
            const SizedBox(height: 16),
            Text(
              'privacy_policy_description'.tr(),
              style: getRegularStyle(
                  fontSize: 16.sp, color: ThemeColors.textColor),
            ),
            const SizedBox(height: 16),
            sectionTitle('interpretation_and_definitions'.tr()),
            subSectionTitle('interpretation'.tr()),
            textBody('interpretation_text'.tr()),
            subSectionTitle('definitions'.tr()),
            bulletPoint('account_definition'.tr()),
            bulletPoint('affiliate_definition'.tr()),
            bulletPoint('application_definition'.tr()),
            bulletPoint('company_definition'.tr()),
            bulletPoint('country_definition'.tr()),
            bulletPoint('device_definition'.tr()),
            bulletPoint('personal_data_definition'.tr()),
            bulletPoint('service_definition'.tr()),
            bulletPoint('service_provider_definition'.tr()),
            bulletPoint('third_party_social_media_service_definition'.tr()),
            bulletPoint('usage_data_definition'.tr()),
            bulletPoint('you_definition'.tr()),
            sectionTitle('collecting_and_using_personal_data'.tr()),
            subSectionTitle('types_of_data_collected'.tr()),
            subSectionTitle('personal_data'.tr()),
            textBody('personal_data_collected'.tr()),
            bulletPoint('email_address'.tr()),
            bulletPoint('first_and_last_name'.tr()),
            bulletPoint('phone_number'.tr()),
            bulletPoint('usage_data'.tr()),
            subSectionTitle('usage_data'.tr()),
            textBody('usage_data_details'.tr()),
            subSectionTitle(
                'information_from_third-Party_social_media_services'.tr()),
            bulletPoint('google'.tr()),
            bulletPoint('facebook'.tr()),
            bulletPoint('instagram'.tr()),
            bulletPoint('twitter'.tr()),
            bulletPoint('linkedIn'.tr()),
            sectionTitle('use_of_your_personal_data'.tr()),
            bulletPoint('to_provide_and_maintain_our_service'.tr()),
            bulletPoint('to_manage_your_account'.tr()),
            bulletPoint('for_the_performance_of_a_contract'.tr()),
            bulletPoint('to_contact_you'.tr()),
            bulletPoint('to_provide_you_with_news_and_offers'.tr()),
            sectionTitle('security_of_your_personal_data'.tr()),
            textBody('security_info'.tr()),
            sectionTitle('children’s_privacy'.tr()),
            textBody('children’s_privacy_info'.tr()),
            sectionTitle('changes_to_this_privacy_policy'.tr()),
            textBody('changes_to_this_privacy_policy_info'.tr()),
            sectionTitle('contact_us'.tr()),
            RichText(
              text: TextSpan(
                text: 'elevated.support@gmail.com',
                style: const TextStyle(color: Colors.blue),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    launchUrl(Uri.parse('mailto:elevated.suport@gmail.com'));
                  },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
