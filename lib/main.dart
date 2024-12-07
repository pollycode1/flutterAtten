import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

void main() => runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => const MyApp(), // Wrap your app
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // ignore: deprecated_member_use
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const AttendancePage(),
    );
  }
}
class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  // สร้างสถานะการมาเรียนของนักเรียน 41 คน (ค่าเริ่มต้น false = สีแดง)
  List<bool> attendanceStatus = List.generate(41, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('สถานะการมาเรียน'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5, // 5 ปุ่มต่อ 1 แถว
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
            childAspectRatio: 1.0, // ปรับให้ปุ่มเป็นสี่เหลี่ยมจัตุรัส
          ),
          itemCount: 41,
          itemBuilder: (context, index) {
            return ElevatedButton(
              onPressed: () {
                // สลับสถานะเมื่อกดปุ่ม
                setState(() {
                  attendanceStatus[index] = !attendanceStatus[index];
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: attendanceStatus[index] ? Colors.green : Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // ขอบกลม
                ),
                padding: EdgeInsets.zero, // กำจัด padding default ของปุ่ม
              ),
              child: Center(
                child: Text(
                  '${index + 1}', // ชื่อปุ่มตามเลขที่
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center, // จัดข้อความให้อยู่กึ่งกลาง
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
