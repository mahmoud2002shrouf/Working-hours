# employees_attendance

### README (English)

# Employee Work Hours Management App

## Overview
This application is designed to manage employee work hours. Employees can check in at the start of their work shift and check out when they finish. The app will automatically calculate the total working hours for each session. Additionally, the app allows users to view a scheduled history of all working hours throughout the year or month. 

## Features
- **Check In/Check Out System**: Employees can record their work start and end times using a simple interface.
- **Automatic Work Hour Calculation**: The app calculates the total hours worked based on the check-in and check-out times.
- **Work History**: Users can view the history of their working hours, organized by year or month.
- **Data Scheduling**: All work hours are properly scheduled, making it easier for users to track their attendance over time.

## Packages Used
- **supabase_flutter**: Used for backend functionality such as database management and authentication.
- **flutter_dotenv**: For managing environment variables in the app.
- **provider**: State management solution for handling app state efficiently.
- **font_awesome_flutter**: Provides access to the FontAwesome icon set for enhanced UI design.
- **slide_to_act**: A slider widget to trigger actions, used for the check-in and check-out feature.
- **intl**: Manages internationalization and date formatting in the app, crucial for scheduling.
- **simple_month_year_picker**: Allows users to easily select a month or year for viewing the work history.
- **location**: Used to fetch the employee's location during check-in and check-out, ensuring they are at the correct workplace.

## How It Works
1. Employees perform a **check-in** when they begin their shift by sliding the check-in widget.
2. At the end of the workday, employees perform a **check-out** using a similar widget.
3. The app calculates the **total hours** worked and stores this data in the backend.
4. Users can view their work hours for a **specific month or year** through a simple month-year picker interface.

---

### README (Arabic)

# تطبيق إدارة ساعات عمل الموظف

## نظرة عامة
تم تصميم هذا التطبيق لإدارة ساعات عمل الموظفين. يمكن للموظفين تسجيل حضورهم عند بدء العمل (Check-In) وتسجيل انتهاء عملهم (Check-Out) عند الانتهاء. سيقوم التطبيق تلقائيًا بحساب ساعات العمل لكل جلسة. بالإضافة إلى ذلك، يتيح التطبيق للمستخدمين عرض تاريخ ساعات العمل المجدولة على مدار السنة أو الشهر.

## الميزات
- **نظام Check In/Check Out**: يمكن للموظفين تسجيل أوقات بدء العمل وانتهائه بسهولة.
- **حساب ساعات العمل تلقائيًا**: يقوم التطبيق بحساب الساعات الإجمالية للعمل بناءً على أوقات التسجيل.
- **تاريخ العمل**: يمكن للمستخدمين عرض تاريخ ساعات العمل مجدولًا حسب السنة أو الشهر.
- **جدولة البيانات**: جميع ساعات العمل مجدولة بشكل صحيح، مما يسهل على المستخدمين تتبع الحضور مع مرور الوقت.

## الحزم المستخدمة
- **supabase_flutter**: تُستخدم للوظائف الخلفية مثل إدارة قواعد البيانات والمصادقة.
- **flutter_dotenv**: لإدارة المتغيرات البيئية في التطبيق.
- **provider**: لحل إدارة الحالة بشكل فعال داخل التطبيق.
- **font_awesome_flutter**: يوفر الوصول إلى مجموعة أيقونات FontAwesome لتحسين واجهة المستخدم.
- **slide_to_act**: ويدجت للسحب من أجل تفعيل إجراءات معينة، يُستخدم لتسجيل الدخول والخروج.
- **intl**: لإدارة الترجمة وتنسيق التواريخ في التطبيق، وهو أمر مهم للجدولة.
- **simple_month_year_picker**: يسمح للمستخدمين باختيار الشهر أو السنة لعرض تاريخ ساعات العمل.
- **location**: تُستخدم للحصول على موقع الموظف أثناء تسجيل الدخول والخروج، لضمان وجودهم في مكان العمل الصحيح.

## كيفية عمل التطبيق
1. يقوم الموظفون بعمل **Check-In** عند بدء نوبتهم عن طريق سحب ويدجت التسجيل.
2. عند نهاية اليوم، يقوم الموظفون بعمل **Check-Out** باستخدام ويدجت مشابهة.
3. يقوم التطبيق بحساب **الساعات الإجمالية** للعمل ويخزن هذه البيانات في النظام الخلفي.
4. يمكن للمستخدمين عرض ساعات العمل الخاصة بهم لشهر أو سنة **محددة** من خلال واجهة بسيطة لاختيار الشهر والسنة.

---

This structure provides a clear, professional description of your app that can be added to your README file for both English and Arabic speakers.
