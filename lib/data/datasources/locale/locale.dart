import 'package:get/get.dart';

class MyLocale implements Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ar': {
          // Login Screen
          '1.1': 'تسجيل الدخول',
          '1.2': 'البريد الالكتروني',
          '1.3': 'كلمة المرور',
          '1.4': 'مرحبا, من فضلك ادخل بريدك الالكتروني',
          '1.5': 'مرحبا, من فضلك ادخل كلمة المرور',
          '1.6': 'هل نسيت كلمة المرور؟',
          '1.7': 'جامعة قناة السويس',
          '1.8': 'كلية الحاسبات والمعلومات',
          '1.9': 'كلية حكومية مصرية',
          '1.10': 'من فضلك ادخل بريدك الالكتروني',
          '1.11': 'ادخل بريد الكتروني صحيح',
          '1.12': 'من فضلك ادخل كلمة المرور',
          '1.13': 'كلمة المرور يجب ان تكون على الاقل 6 احرف',
          '1.14': 'تم الضغط على زر تسجيل الدخول.',
          // Forgot Password Screen
          '2.1': 'استعادة كلمة المرور',
          '2.2': 'يرجى إدخال ايميلك الجامعي لتلقي رمز التحقق',
          '2.3': 'ارسل الرمز',
          // Home Screen
          '3.1': 'كلية الحاسبات والمعلومات',
          '3.2': 'الفرقة الأولى',
          '3.3': 'الفرقة الثانية',
          '3.4': 'الفرقة الثالثه',
          '3.5': 'الفرقة الرابعة',
          '3.6': 'الحضور',
          '3.7': 'التقويم',
          '3.8': 'الملاحظات',
          '3.9': 'الدردشة',
          '3.10': 'الاعدادات',
          '3.11': 'إضافة',
          '3.12': 'أخر الاخبار',
          '3.13': 'المقررات',
          // CustomBottomNavBar
          '3.14': 'الرئيسية',
          '3.15': 'الجدول',
          '3.16': 'الشخصية',
          '3.17': 'المزيد',
          // HorizontalCoursesList
          '3.18': 'الشبكات العصبية',
          '3.19': 'الحكومة الإلكترونية',
          '3.20': 'أمن المعلومات',
          '3.21': 'شبكات المؤسسات',
          '3.22': 'قواعد البيانات الوسائط المتعددة',
          '3.23': 'قواعد البيانات المتسلسلة زمنياً',
          // ProfileScreen
          '4.1': 'الصفحة الشخصية',
          '4.2': 'تحديث البيانات',
          '4.3': 'حدث خطأ في جلب البيانات',
          '4.4': 'إعادة المحاولة',
          '4.5': 'لا توجد بيانات متاحة',
          '4.6': 'الاسم:',
          '4.7': 'النوع:',
          '4.8': 'الكلية:',
          '4.9': 'الجامعة:',
          '4.10': 'المستوى:',
          '4.11': 'التخصص:',
          '4.12': 'المرحلة الجامعية:',
          '4.13': 'الرقم الجامعي:',
          '4.14': 'المعدل التراكمي:',
          '4.15': 'ساجد رقمت ابراهيم',
          '4.16': 'ذكر',
          '4.17': 'الحاسبات والمعلومات',
          '4.18': 'قناة السويس',
          '4.19': 'الفرقه الرابعة',
          '4.20': 'نظم المعلومات',
          '4.21': 'البكالريوس',
          '4.22': 'القسم',
          '4.23': 'الرتبة',
          '4.24': 'موقع المكتب',
          '4.25': 'رقم المدرس',
          '4.26': 'مدرس',
          '4.27': 'غير متاح',
          // Onboarding Screen
          '5.1': 'مرحبا بكم في كلية الحاسبات والمعلومات',
          '5.2': 'نقدم لكم منصه تعليميه متكامله',
          '5.3': 'تصفح جميع أخبار الكلية',
          '5.4': 'تحقق من دروسك اليومية وجدولك الأسبوعي',
          '5.5': 'قم بتأكيد الحضور',
          '5.6': 'هيا بنا نبدأ',
          '5.7': 'تخطي',
          '5.8': 'التالي',
          // More Screen
          '6.1': 'المزيد',
          '6.2': 'الإعدادات العامة',
          '6.3': 'الحساب',
          '6.4': 'الوضع الداكن',
          '6.5': 'إشعارات التطبيق',
          '6.6': 'تسجيل الخروج',
          '6.7': 'هل أنت متأكد أنك تريد تسجيل الخروج؟',
          '6.8': 'إلغاء',
          '6.9': 'تسجيل الخروج',
        },
        'en': {
          // Login Screen
          '1.1': 'Login',
          '1.2': 'Email',
          '1.3': 'Password',
          '1.4': 'Hi, please enter your email',
          '1.5': 'Hi, please enter your password',
          '1.6': 'Forgot Password?',
          '1.7': 'Suez Canal University',
          '1.8': 'Faculty of Computers and Information',
          '1.9': 'An Egyptian public university',
          '1.10': 'Please enter your email',
          '1.11': 'Enter a valid email address',
          '1.12': 'Please enter your password',
          '1.13': 'Password must be at least 6 characters',
          '1.14': 'Login button pressed.',
          // Forgot Password Screen
          '2.1': 'Recover your password',
          '2.2':
              'Please enter your university email to receive the verification code',
          '2.3': 'Send code',
          // Home Screen
          '3.1': 'Faculty of Computers and Information',
          '3.2': 'First Year',
          '3.3': 'Second Year',
          '3.4': 'Third Year',
          '3.5': 'Fourth Year',
          '3.6': 'Attendance',
          '3.7': 'Calendar',
          '3.8': 'Notes',
          '3.9': 'Chat',
          '3.10': 'Settings',
          '3.11': 'Add',
          '3.12': 'News',
          '3.13': 'Courses',
          // CustomBottomNavBar
          '3.14': 'Home',
          '3.15': 'Schedule',
          '3.16': 'Profile',
          '3.17': 'More',
          // HorizontalCoursesList
          '3.18': 'Neural Networks',
          '3.19': 'E-Government',
          '3.20': 'Information Security',
          '3.21': 'Institutional Networks',
          '3.22': 'Multimedia Databases',
          '3.23': 'Temporal Databases',
          // ProfileScreen
          '4.1': 'Profile Page',
          '4.2': 'Refresh Data',
          '4.3': 'An error occurred while fetching data',
          '4.4': 'Try Again',
          '4.5': 'No data available',
          '4.6': 'Name:',
          '4.7': 'Gender:',
          '4.8': 'College:',
          '4.9': 'University:',
          '4.10': 'Level:',
          '4.11': 'Specialization:',
          '4.12': 'Academic Degree:',
          '4.13': 'Student ID:',
          '4.14': 'GPA:',
          '4.15': 'Sagid Refat Ibrahim',
          '4.16': 'Male',
          '4.17': 'Computers and Information',
          '4.18': 'Suez Canal University',
          '4.19': 'Fourth Year',
          '4.20': 'Information Systems',
          '4.21': 'Bachelor',
          '4.22': 'Department',
          '4.23': 'Rank',
          '4.24': 'Office Location',
          '4.25': 'Teacher ID',
          '4.26': 'Teacher',
          '4.27': 'Not Available',
          // Onboarding Screen
          '5.1': 'Welcome to the Faculty of Computers and Information',
          '5.2': 'We offer you an integrated educational platform',
          '5.3': 'Browse all the faculty news',
          '5.4': 'Check your daily lessons and weekly schedule',
          '5.5': 'Confirm your attendance',
          '5.6': 'Get Started',
          '5.7': 'Skip',
          '5.8': 'Next',
          // More Screen
          '6.1': 'More',
          '6.2': 'General Settings',
          '6.3': 'Account',
          '6.4': 'Dark Mode',
          '6.5': 'App Notifications',
          '6.6': 'Logout',
          '6.7': 'Are you sure you want to logout?',
          '6.8': 'Cancel',
          '6.9': 'Logout',
        }
      };
}
