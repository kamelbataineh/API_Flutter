import 'package:api_flutter/beeceptor/model/ProductModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class GetProduct extends StatefulWidget {
  const GetProduct({super.key});

  @override
  State<GetProduct> createState() => _GetProductState();
}

List<Productmodel>? products;

class _GetProductState extends State<GetProduct> {
  @override
  void initState() {
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('المنتجات')),
      body: products != null
          ? ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: products!.length,
        itemBuilder: (context, index) {
          Productmodel product = products![index];
          return Card(
            margin:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blueAccent,
                    child: Text(
                      product.id.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text1(
                          product.description.toString(),
                          size: 16,
                        ),
                        const SizedBox(height: 4),
                        Text1(
                          'السعر: \$${product.price.toString()}',
                          size: 14,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      )
          : const Center(child: CircularProgressIndicator()),
    );
  }

  void getdata() async {
    try {
      final dio = Dio();
      Response res = await dio.get(
        'https://kamel.free.beeceptor.com/api/users',
      );
      print("البيانات الراجعة: ${res.data}");

      List productTest = res.data;
      products = [];
      for (int i = 0; i < productTest.length; i++) {
        Map<String, dynamic> productItem = productTest[i];
        Productmodel productmodel = Productmodel.toMap(productItem);
        products!.add(productmodel);
      }

      setState(() {});
    } catch (e) {
      print("حصل خطأ أثناء جلب البيانات: $e");
    }
  }

  Widget Text1(String txt, {double size = 5}) {
    return Text(
      txt,
      style: TextStyle(fontSize: size),
      maxLines: 2,
      overflow: TextOverflow.fade,
    );
  }
}
