import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uas_medical/app/modules/pendaftaran/controllers/pendaftaran_controller.dart';

class RiwayatPasienPage extends StatefulWidget {
  final String pasienId;
  final String namaPasien;

  const RiwayatPasienPage({
    super.key,
    required this.pasienId,
    required this.namaPasien,
  });

  @override
  State<RiwayatPasienPage> createState() => _RiwayatPasienPageState();
}

class _RiwayatPasienPageState extends State<RiwayatPasienPage> {
  final PendaftaranController controller = Get.find<PendaftaranController>();

  bool isLoading = true;
  List<Map<String, dynamic>> riwayat = [];

  @override
  void initState() {
    super.initState();
    muatRiwayat();
  }

  Future<void> muatRiwayat() async {
    setState(() => isLoading = true);
    final data = await controller.getRiwayatPasien(widget.pasienId);
    setState(() {
      riwayat = data;
      isLoading = false;
    });
  }

  String formatTanggal(String? isoString) {
    if (isoString == null || isoString.isEmpty) return '-';
    try {
      final date = DateTime.parse(isoString);
      const bulan = [
        '',
        'Januari',
        'Februari',
        'Maret',
        'April',
        'Mei',
        'Juni',
        'Juli',
        'Agustus',
        'September',
        'Oktober',
        'November',
        'Desember'
      ];
      return '${date.day} ${bulan[date.month]} ${date.year}';
    } catch (_) {
      return isoString;
    }
  }

  String formatRupiah(dynamic angka) {
    final nilai = angka is int ? angka : int.tryParse('$angka') ?? 0;
    return 'Rp ${nilai.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (match) => '${match[1]}.',
        )}';
  }

  Color warnaStatusRawat(String? status) {
    if (status == 'Rawat Inap') return Colors.orange;
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat: ${widget.namaPasien}'),
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: muatRiwayat,
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : riwayat.isEmpty
                ? ListView(
                    // ListView agar RefreshIndicator tetap bisa ditarik walau kosong
                    children: const [
                      SizedBox(height: 120),
                      Icon(Icons.history_toggle_off,
                          size: 64, color: Colors.grey),
                      SizedBox(height: 12),
                      Center(
                        child: Text(
                          'Belum ada riwayat pemeriksaan',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ),
                    ],
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: riwayat.length,
                    itemBuilder: (context, index) {
                      final r = riwayat[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      r['diagnosa']?.toString().isNotEmpty ==
                                              true
                                          ? r['diagnosa']
                                          : 'Belum ada diagnosa',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: warnaStatusRawat(r['status_rawat'])
                                          .withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      r['status_rawat'] ?? '-',
                                      style: TextStyle(
                                        color:
                                            warnaStatusRawat(r['status_rawat']),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              _baris(Icons.calendar_today,
                                  formatTanggal(r['tanggal_periksa'])),
                              _baris(Icons.medical_services,
                                  'dr. ${r['nama_dokter'] ?? '-'}'),
                              _baris(Icons.local_hospital,
                                  'Poli ${r['nama_poli'] ?? '-'}'),
                              if (r['catatan'] != null &&
                                  r['catatan'].toString().isNotEmpty)
                                _baris(Icons.note_alt, r['catatan'].toString()),
                              const Divider(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Biaya Pemeriksaan',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 13),
                                  ),
                                  Text(
                                    formatRupiah(r['biaya_pemeriksaan']),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }

  Widget _baris(IconData icon, String teks) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey[700]),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              teks,
              style: TextStyle(color: Colors.grey[800], fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
