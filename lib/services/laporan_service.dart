import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class LaporanService {
  static Future<void> generatePdf({
    required String title,
    required List<Map<String, dynamic>> data,
  }) async {
    final pdf = pw.Document();

    final headers = data.first.keys.toList();

    final rows = data.map((e) {
      return e.values.map((v) => v.toString()).toList();
    }).toList();

    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                title,
                style: const pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Table.fromTextArray(
                headers: headers,
                data: rows,
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
    );
  }
}
