import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}
class _AddProductState extends State<AddProduct> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  bool isPost = false; // ← هنا مكانه الصحيح

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('إضافة منتج')),

      // إصلاح الشرط: عرض مؤشر التحميل عند isPost == true
      body: isPost
          ? Center(child: LinearProgressIndicator())
          : SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'الاسم',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'الوصف',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'السعر',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: addProduct,
                child: Text('إضافة المنتج'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addProduct() async {
    Dio dio = Dio();

    Map<String, dynamic> data = {
      "name": nameController.text.trim(),
      "description": descriptionController.text.trim(),
      "price": double.tryParse(priceController.text.trim()) ?? 0,
    };

    setState(() {
      isPost = true;
    });

    try {
      Response res = await dio.post(
        'https://kamel.free.beeceptor.com/api/users',
        data: data,
      );
      print(res.data);
    } catch (e) {
      print("خطأ أثناء الإرسال: $e");
    }

    setState(() {
      isPost = false;
    });
  }
}
