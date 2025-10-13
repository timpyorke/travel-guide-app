import 'package:flutter/widgets.dart';
import 'package:flutter_localization/flutter_localization.dart';

mixin AppLocale {
  static const String languageEnglishUs = 'languageEnglishUs';
  static const String languageThai = 'languageThai';
  static const String languageChinese = 'languageChinese';

  static const String preferenceCoastal = 'preferenceCoastal';
  static const String preferenceCultural = 'preferenceCultural';
  static const String preferenceFoodie = 'preferenceFoodie';
  static const String preferencePhotography = 'preferencePhotography';
  static const String preferenceOutdoors = 'preferenceOutdoors';
  static const String preferenceWellness = 'preferenceWellness';
  static const String preferenceNightlife = 'preferenceNightlife';
  static const String preferenceFamily = 'preferenceFamily';

  static const String profileNameGuest = 'profileNameGuest';
  static const String profileTaglineDefault = 'profileTaglineDefault';
  static const String profileTaglineGuest = 'profileTaglineGuest';
  static const String profileTaglineSignedIn = 'profileTaglineSignedIn';
  static const String profileHomeBasePrompt = 'profileHomeBasePrompt';
  static const String profileTravelPreferencesTitle =
      'profileTravelPreferencesTitle';
  static const String profileAccountSettingsTitle =
      'profileAccountSettingsTitle';
  static const String profileAdjustAction = 'profileAdjustAction';
  static const String profileDetailsTitle = 'profileDetailsTitle';
  static const String profileDetailsSubtitle = 'profileDetailsSubtitle';
  static const String profileHomeBaseTitle = 'profileHomeBaseTitle';
  static const String profileLanguageTitle = 'profileLanguageTitle';
  static const String profileNotificationsTitle =
      'profileNotificationsTitle';
  static const String profilePrivacyTitle = 'profilePrivacyTitle';
  static const String profilePrivacySubtitle = 'profilePrivacySubtitle';
  static const String profileSupportTitle = 'profileSupportTitle';
  static const String profileSupportSubtitle = 'profileSupportSubtitle';
  static const String profileSignOut = 'profileSignOut';
  static const String profileGuestCtaDescription =
      'profileGuestCtaDescription';
  static const String profileLanguageAllOff = 'profileLanguageAllOff';
  static const String profileNotificationTripReminders =
      'profileNotificationTripReminders';
  static const String profileNotificationProductUpdates =
      'profileNotificationProductUpdates';
  static const String profileNotificationPartnerOffers =
      'profileNotificationPartnerOffers';

  static const String commonSignIn = 'commonSignIn';
  static const String commonCreateAccount = 'commonCreateAccount';
  static const String commonCancel = 'commonCancel';
  static const String commonSave = 'commonSave';
  static const String commonSaveChanges = 'commonSaveChanges';

  static const String profilePrivacySheetTitle =
      'profilePrivacySheetTitle';
  static const String profilePrivacyShareActivity =
      'profilePrivacyShareActivity';
  static const String profilePrivacyShareActivitySubtitle =
      'profilePrivacyShareActivitySubtitle';
  static const String profilePrivacyPersonalizedTips =
      'profilePrivacyPersonalizedTips';
  static const String profilePrivacyPersonalizedTipsSubtitle =
      'profilePrivacyPersonalizedTipsSubtitle';
  static const String profilePrivacyFooter = 'profilePrivacyFooter';
  static const String profilePrivacyUpdated = 'profilePrivacyUpdated';

  static const String profileLanguageSheetTitle =
      'profileLanguageSheetTitle';
  static const String profileLanguageSheetDescription =
      'profileLanguageSheetDescription';
  static const String profileLanguageUpdated = 'profileLanguageUpdated';

  static const String profileSupportSheetTitle =
      'profileSupportSheetTitle';
  static const String profileSupportFaqTitle = 'profileSupportFaqTitle';
  static const String profileSupportFaqSubtitle =
      'profileSupportFaqSubtitle';
  static const String profileSupportFaqComingSoon =
      'profileSupportFaqComingSoon';
  static const String profileSupportEmailTitle =
      'profileSupportEmailTitle';
  static const String profileSupportEmailSubtitle =
      'profileSupportEmailSubtitle';
  static const String profileSupportEmailToast =
      'profileSupportEmailToast';
  static const String profileSupportChatTitle =
      'profileSupportChatTitle';
  static const String profileSupportChatSubtitle =
      'profileSupportChatSubtitle';
  static const String profileSupportChatToast =
      'profileSupportChatToast';

  static const String profileEditorTitle = 'profileEditorTitle';
  static const String profileEditorDisplayNameLabel =
      'profileEditorDisplayNameLabel';
  static const String profileEditorTaglineLabel =
      'profileEditorTaglineLabel';
  static const String profileEditorTaglineHint =
      'profileEditorTaglineHint';
  static const String profileEditorPreferencesTitle =
      'profileEditorPreferencesTitle';
  static const String profileEditorNameEmpty =
      'profileEditorNameEmpty';
  static const String profilePreferencesTaglineFallback =
      'profilePreferencesTaglineFallback';
  static const String profileEditorUpdated = 'profileEditorUpdated';

  static const String profileNotificationsSheetTitle =
      'profileNotificationsSheetTitle';
  static const String profileNotificationsTripRemindersSubtitle =
      'profileNotificationsTripRemindersSubtitle';
  static const String profileNotificationsProductUpdatesSubtitle =
      'profileNotificationsProductUpdatesSubtitle';
  static const String profileNotificationsPartnerOffersSubtitle =
      'profileNotificationsPartnerOffersSubtitle';
  static const String profileNotificationsUpdated =
      'profileNotificationsUpdated';

  static const String profileAuthSheetTitle = 'profileAuthSheetTitle';
  static const String profileAuthSheetMessage =
      'profileAuthSheetMessage';
  static const String profileSignedInAs = 'profileSignedInAs';
  static const String profileSignedOut = 'profileSignedOut';

  static const Map<String, dynamic> en = <String, dynamic>{
    languageEnglishUs: 'English (US)',
    languageThai: 'Thai',
    languageChinese: 'Chinese',

    preferenceCoastal: 'Coastal',
    preferenceCultural: 'Cultural',
    preferenceFoodie: 'Foodie',
    preferencePhotography: 'Photography',
    preferenceOutdoors: 'Outdoors',
    preferenceWellness: 'Wellness',
    preferenceNightlife: 'Nightlife',
    preferenceFamily: 'Family-friendly',

    profileNameGuest: 'Traveler Guest',
    profileTaglineDefault: 'Sunrise chaser • Food lover',
    profileTaglineGuest: 'Sign in to personalize suggestions',
    profileTaglineSignedIn: 'Always chasing golden hours',
    profileHomeBasePrompt: 'Set a home base to personalize trips',
    profileTravelPreferencesTitle: 'Travel Preferences',
    profileAccountSettingsTitle: 'Account Settings',
    profileAdjustAction: 'Adjust',
    profileDetailsTitle: 'Profile details',
    profileDetailsSubtitle: 'Update name & travel style',
    profileHomeBaseTitle: 'Travel home base',
    profileLanguageTitle: 'App language',
    profileNotificationsTitle: 'Notifications',
    profilePrivacyTitle: 'Privacy',
    profilePrivacySubtitle: 'Manage visibility and data',
    profileSupportTitle: 'Support',
    profileSupportSubtitle: 'FAQ and contact options',
    profileSignOut: 'Sign out',
    profileGuestCtaDescription:
        'Sign in to save plans, sync preferences, and access exclusive itineraries.',
    profileLanguageAllOff: 'All notifications off',
    profileNotificationTripReminders: 'Trip reminders',
    profileNotificationProductUpdates: 'Product updates',
    profileNotificationPartnerOffers: 'Partner offers',

    commonSignIn: 'Sign in',
    commonCreateAccount: 'Create account',
    commonCancel: 'Cancel',
    commonSave: 'Save',
    commonSaveChanges: 'Save changes',

    profilePrivacySheetTitle: 'Privacy controls',
    profilePrivacyShareActivity: 'Share anonymous activity',
    profilePrivacyShareActivitySubtitle:
        'Improve recommendations by sharing aggregated travel engagement data.',
    profilePrivacyPersonalizedTips: 'Personalized tips',
    profilePrivacyPersonalizedTipsSubtitle:
        'Use your saved plans and preferences to tailor insights.',
    profilePrivacyFooter:
        'You can request a data export or account deletion at any time through support.',
    profilePrivacyUpdated: 'Privacy preferences updated',

    profileLanguageSheetTitle: 'Choose app language',
    profileLanguageSheetDescription:
        'Interface translations roll out progressively. Choosing a language ensures you receive updates as soon as they are available.',
    profileLanguageUpdated: 'Language updated',

    profileSupportSheetTitle: 'Need a hand?',
    profileSupportFaqTitle: 'Browse FAQs',
    profileSupportFaqSubtitle:
        'View top questions about planning, saving, and privacy.',
    profileSupportFaqComingSoon: 'FAQ center coming soon.',
    profileSupportEmailTitle: 'Email support',
    profileSupportEmailSubtitle: 'We typically reply within 24 hours.',
    profileSupportEmailToast: 'Email composer not wired yet.',
    profileSupportChatTitle: 'Live chat',
    profileSupportChatSubtitle:
        'Connect with our travel team (weekdays 9-6 PST).',
    profileSupportChatToast: 'Chat support launching soon.',

    profileEditorTitle: 'Edit profile',
    profileEditorDisplayNameLabel: 'Display name',
    profileEditorTaglineLabel: 'Travel tagline',
    profileEditorTaglineHint: 'Ex. Sunrise chaser • Food lover',
    profileEditorPreferencesTitle: 'Travel preferences',
    profileEditorNameEmpty: 'Name cannot be empty.',
    profilePreferencesTaglineFallback: 'Inspired traveler',
    profileEditorUpdated: 'Profile updated',

    profileNotificationsSheetTitle: 'Notification preferences',
    profileNotificationsTripRemindersSubtitle:
        'Stay on top of upcoming itineraries and saved routes.',
    profileNotificationsProductUpdatesSubtitle:
        'Learn about new destinations and app features.',
    profileNotificationsPartnerOffersSubtitle:
        'Get curated deals and exclusive promotions.',
    profileNotificationsUpdated: 'Notification preferences updated',

    profileAuthSheetTitle: 'Ready to personalize?',
    profileAuthSheetMessage:
        'Sign in or create a Travel Guide account to save plans, sync preferences, and unlock exclusive itineraries.',
    profileSignedInAs: 'Signed in as {name}',
    profileSignedOut: 'Signed out',
  };

  static const Map<String, dynamic> th = <String, dynamic>{
    languageEnglishUs: 'อังกฤษ (สหรัฐอเมริกา)',
    languageThai: 'ไทย',
    languageChinese: 'จีน',

    preferenceCoastal: 'ชายฝั่ง',
    preferenceCultural: 'วัฒนธรรม',
    preferenceFoodie: 'สายกิน',
    preferencePhotography: 'การถ่ายภาพ',
    preferenceOutdoors: 'กิจกรรมกลางแจ้ง',
    preferenceWellness: 'สุขภาพ',
    preferenceNightlife: 'เที่ยวกลางคืน',
    preferenceFamily: 'เหมาะสำหรับครอบครัว',

    profileNameGuest: 'แขกนักเดินทาง',
    profileTaglineDefault: 'ผู้ไล่ล่าพระอาทิตย์ • สายกิน',
    profileTaglineGuest: 'ลงชื่อเข้าใช้เพื่อรับคำแนะนำเฉพาะคุณ',
    profileTaglineSignedIn: 'ไล่ตามแสงทองเสมอ',
    profileHomeBasePrompt: 'ตั้งค่าฐานทริปเพื่อปรับแต่งการเดินทาง',
    profileTravelPreferencesTitle: 'ความชอบการท่องเที่ยว',
    profileAccountSettingsTitle: 'การตั้งค่าบัญชี',
    profileAdjustAction: 'ปรับ',
    profileDetailsTitle: 'รายละเอียดโปรไฟล์',
    profileDetailsSubtitle: 'อัปเดตชื่อและสไตล์การท่องเที่ยว',
    profileHomeBaseTitle: 'ฐานท่องเที่ยวหลัก',
    profileLanguageTitle: 'ภาษาของแอป',
    profileNotificationsTitle: 'การแจ้งเตือน',
    profilePrivacyTitle: 'ความเป็นส่วนตัว',
    profilePrivacySubtitle: 'จัดการการมองเห็นและข้อมูล',
    profileSupportTitle: 'การสนับสนุน',
    profileSupportSubtitle: 'คำถามที่พบบ่อยและช่องทางติดต่อ',
    profileSignOut: 'ออกจากระบบ',
    profileGuestCtaDescription:
        'ลงชื่อเข้าเพื่อบันทึกแผน ซิงค์ความชอบ และเข้าถึงเส้นทางพิเศษ',
    profileLanguageAllOff: 'ปิดการแจ้งเตือนทั้งหมด',
    profileNotificationTripReminders: 'การเตือนทริป',
    profileNotificationProductUpdates: 'อัปเดตผลิตภัณฑ์',
    profileNotificationPartnerOffers: 'ดีลจากพาร์ทเนอร์',

    commonSignIn: 'ลงชื่อเข้าใช้',
    commonCreateAccount: 'สร้างบัญชี',
    commonCancel: 'ยกเลิก',
    commonSave: 'บันทึก',
    commonSaveChanges: 'บันทึกการแก้ไข',

    profilePrivacySheetTitle: 'การควบคุมความเป็นส่วนตัว',
    profilePrivacyShareActivity: 'แชร์กิจกรรมแบบไม่ระบุตัวตน',
    profilePrivacyShareActivitySubtitle:
        'ปรับปรุงคำแนะนำโดยแบ่งปันข้อมูลการเดินทางแบบรวม',
    profilePrivacyPersonalizedTips: 'คำแนะนำเฉพาะบุคคล',
    profilePrivacyPersonalizedTipsSubtitle:
        'ใช้แผนและความชอบที่บันทึกไว้เพื่อสร้างคำแนะนำเฉพาะคุณ',
    profilePrivacyFooter:
        'คุณสามารถขอส่งออกข้อมูลหรือขอลบบัญชีได้ทุกเวลาผ่านทีมสนับสนุน',
    profilePrivacyUpdated: 'อัปเดตการตั้งค่าความเป็นส่วนตัวแล้ว',

    profileLanguageSheetTitle: 'เลือกภาษาของแอป',
    profileLanguageSheetDescription:
        'การแปลอินเทอร์เฟซกำลังทยอยปล่อย การเลือกภาษาจะทำให้คุณได้รับการอัปเดตทันทีที่พร้อม',
    profileLanguageUpdated: 'อัปเดตภาษาแล้ว',

    profileSupportSheetTitle: 'ต้องการความช่วยเหลือหรือไม่?',
    profileSupportFaqTitle: 'ดูคำถามที่พบบ่อย',
    profileSupportFaqSubtitle:
        'ดูคำถามยอดนิยมเกี่ยวกับการวางแผน การบันทึก และความเป็นส่วนตัว',
    profileSupportFaqComingSoon: 'ศูนย์คำถามที่พบบ่อยจะพร้อมเร็วๆ นี้',
    profileSupportEmailTitle: 'อีเมลถึงทีมสนับสนุน',
    profileSupportEmailSubtitle: 'โดยปกติตอบกลับภายใน 24 ชั่วโมง',
    profileSupportEmailToast: 'ยังไม่พร้อมใช้งานการเขียนอีเมล',
    profileSupportChatTitle: 'แชทสด',
    profileSupportChatSubtitle:
        'พูดคุยกับทีมท่องเที่ยวของเรา (จันทร์-ศุกร์ 9-18 น. PST)',
    profileSupportChatToast: 'การสนับสนุนผ่านแชทกำลังจะเปิดให้บริการเร็วๆ นี้',

    profileEditorTitle: 'แก้ไขโปรไฟล์',
    profileEditorDisplayNameLabel: 'ชื่อที่แสดง',
    profileEditorTaglineLabel: 'สโลแกนการท่องเที่ยว',
    profileEditorTaglineHint: 'เช่น ผู้ไล่ล่าพระอาทิตย์ • สายกิน',
    profileEditorPreferencesTitle: 'ความชอบการท่องเที่ยว',
    profileEditorNameEmpty: 'ต้องระบุชื่อ',
    profilePreferencesTaglineFallback: 'นักเดินทางผู้เปี่ยมแรงบันดาลใจ',
    profileEditorUpdated: 'อัปเดตโปรไฟล์แล้ว',

    profileNotificationsSheetTitle: 'การตั้งค่าการแจ้งเตือน',
    profileNotificationsTripRemindersSubtitle:
        'ติดตามทริปและเส้นทางที่บันทึกล่วงหน้า',
    profileNotificationsProductUpdatesSubtitle:
        'เรียนรู้จุดหมายและฟีเจอร์ใหม่ๆ ของแอป',
    profileNotificationsPartnerOffersSubtitle:
        'รับดีลคัดสรรและโปรโมชันพิเศษ',
    profileNotificationsUpdated: 'อัปเดตการตั้งค่าการแจ้งเตือนแล้ว',

    profileAuthSheetTitle: 'พร้อมปรับให้เป็นของคุณหรือยัง?',
    profileAuthSheetMessage:
        'ลงชื่อเข้าใช้หรือสร้างบัญชี Travel Guide เพื่อบันทึกแผน ซิงค์ความชอบ และปลดล็อกเส้นทางพิเศษ',
    profileSignedInAs: 'ลงชื่อเข้าใช้ในชื่อ {name}',
    profileSignedOut: 'ออกจากระบบแล้ว',
  };

  static const Map<String, dynamic> zh = <String, dynamic>{
    languageEnglishUs: '英语（美国）',
    languageThai: '泰语',
    languageChinese: '中文',

    preferenceCoastal: '海岸',
    preferenceCultural: '文化',
    preferenceFoodie: '美食',
    preferencePhotography: '摄影',
    preferenceOutdoors: '户外',
    preferenceWellness: '身心健康',
    preferenceNightlife: '夜生活',
    preferenceFamily: '适合家庭',

    profileNameGuest: '旅行访客',
    profileTaglineDefault: '追逐日出 • 热爱美食',
    profileTaglineGuest: '登录以获取个性化推荐',
    profileTaglineSignedIn: '始终追逐金色时刻',
    profileHomeBasePrompt: '设置常用出发地以获得个性化行程',
    profileTravelPreferencesTitle: '旅行偏好',
    profileAccountSettingsTitle: '账户设置',
    profileAdjustAction: '调整',
    profileDetailsTitle: '个人资料详情',
    profileDetailsSubtitle: '更新姓名与旅行风格',
    profileHomeBaseTitle: '常用出发地',
    profileLanguageTitle: '应用语言',
    profileNotificationsTitle: '通知',
    profilePrivacyTitle: '隐私',
    profilePrivacySubtitle: '管理可见性和数据',
    profileSupportTitle: '客服支持',
    profileSupportSubtitle: '常见问题与联系方式',
    profileSignOut: '退出登录',
    profileGuestCtaDescription: '登录即可保存行程、同步偏好并访问专属攻略。',
    profileLanguageAllOff: '所有通知已关闭',
    profileNotificationTripReminders: '行程提醒',
    profileNotificationProductUpdates: '产品更新',
    profileNotificationPartnerOffers: '合作优惠',

    commonSignIn: '登录',
    commonCreateAccount: '创建账号',
    commonCancel: '取消',
    commonSave: '保存',
    commonSaveChanges: '保存更改',

    profilePrivacySheetTitle: '隐私控制',
    profilePrivacyShareActivity: '分享匿名活动数据',
    profilePrivacyShareActivitySubtitle:
        '通过分享汇总的出行参与数据来改进推荐。',
    profilePrivacyPersonalizedTips: '个性化提示',
    profilePrivacyPersonalizedTipsSubtitle:
        '利用已保存的行程和偏好定制洞见。',
    profilePrivacyFooter: '如需导出数据或删除账号，可随时联系支持团队。',
    profilePrivacyUpdated: '隐私偏好已更新',

    profileLanguageSheetTitle: '选择应用语言',
    profileLanguageSheetDescription:
        '界面翻译将陆续推出，选择语言可在更新后第一时间体验。',
    profileLanguageUpdated: '语言已更新',

    profileSupportSheetTitle: '需要帮助吗？',
    profileSupportFaqTitle: '查看常见问题',
    profileSupportFaqSubtitle: '查看有关行程规划、收藏和隐私的常见问题。',
    profileSupportFaqComingSoon: '常见问题中心即将上线。',
    profileSupportEmailTitle: '邮件支持',
    profileSupportEmailSubtitle: '我们通常会在 24 小时内回复。',
    profileSupportEmailToast: '邮件撰写功能尚未接入。',
    profileSupportChatTitle: '在线客服',
    profileSupportChatSubtitle:
        '工作日 9 点至 18 点（太平洋时间）与旅行团队实时聊天。',
    profileSupportChatToast: '聊天支持即将上线。',

    profileEditorTitle: '编辑资料',
    profileEditorDisplayNameLabel: '显示名称',
    profileEditorTaglineLabel: '旅行标语',
    profileEditorTaglineHint: '例如：追逐日出 • 热爱美食',
    profileEditorPreferencesTitle: '旅行偏好',
    profileEditorNameEmpty: '姓名不能为空。',
    profilePreferencesTaglineFallback: '灵感十足的旅行者',
    profileEditorUpdated: '个人资料已更新',

    profileNotificationsSheetTitle: '通知偏好',
    profileNotificationsTripRemindersSubtitle: '掌握即将到来的行程与已保存路线。',
    profileNotificationsProductUpdatesSubtitle: '了解新的目的地和应用功能。',
    profileNotificationsPartnerOffersSubtitle: '获取精选优惠和专属促销。',
    profileNotificationsUpdated: '通知偏好已更新',

    profileAuthSheetTitle: '准备好个性化体验了吗？',
    profileAuthSheetMessage:
        '登录或创建 Travel Guide 账号即可保存行程、同步偏好并解锁专属攻略。',
    profileSignedInAs: '已登录为 {name}',
    profileSignedOut: '已退出登录',
  };
}

class AppLocaleUtils {
  const AppLocaleUtils._();

  static final FlutterLocalization _localization =
      FlutterLocalization.instance;

  static String translate(BuildContext context, String key) {
    return _translate(key);
  }

  static String translateWithParams(
    BuildContext context,
    String key,
    Map<String, String> params,
  ) {
    String value = _translate(key);
    params.forEach((String token, String parameter) {
      value = value.replaceAll('{$token}', parameter);
    });
    return value;
  }

  static String _translate(String key) {
    final Locale locale = _localization.currentLocale ??
        const Locale('en', 'US');

    final Map<String, dynamic> localeMap = _resolveMap(locale);
    final String? value = localeMap[key] as String?;
    if (value != null) {
      return value;
    }
    final String? fallback = AppLocale.en[key] as String?;
    return fallback ?? key;
  }

  static Map<String, dynamic> _resolveMap(Locale locale) {
    switch (locale.languageCode) {
      case 'th':
        return AppLocale.th;
      case 'zh':
        return AppLocale.zh;
      case 'en':
      default:
        return AppLocale.en;
    }
  }
}

extension AppLocaleExtension on String {
  String tr(BuildContext context) {
    return AppLocaleUtils.translate(context, this);
  }

  String trParams(BuildContext context, Map<String, String> params) {
    return AppLocaleUtils.translateWithParams(context, this, params);
  }
}
