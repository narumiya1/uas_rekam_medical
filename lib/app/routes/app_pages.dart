import 'package:get/get.dart';

import '../modules/dokter/bindings/dokter_binding.dart';
import '../modules/dokter/views/dokter_view.dart';
import '../modules/halaman_laporan_pkm/bindings/halaman_laporan_pkm_binding.dart';
import '../modules/halaman_laporan_pkm/views/halaman_laporan_pkm_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/laporan/bindings/laporan_binding.dart';
import '../modules/laporan/views/laporan_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/obat/bindings/obat_binding.dart';
import '../modules/obat/views/obat_view.dart';
import '../modules/pasien/bindings/pasien_binding.dart';
import '../modules/pasien/views/pasien_view.dart';
import '../modules/pendaftaran/bindings/pendaftaran_binding.dart';
import '../modules/pendaftaran/views/pendaftaran_view.dart';
import '../modules/poli/bindings/poli_binding.dart';
import '../modules/poli/views/poli_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.PASIEN,
      page: () => const PasienView(),
      binding: PasienBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.DOKTER,
      page: () => const DokterView(),
      binding: DokterBinding(),
    ),
    GetPage(
      name: _Paths.OBAT,
      page: () => const ObatView(),
      binding: ObatBinding(),
    ),
    GetPage(
      name: _Paths.POLI,
      page: () => const PoliView(),
      binding: PoliBinding(),
    ),
    GetPage(
      name: _Paths.PENDAFTARAN,
      page: () => const PendaftaranView(),
      binding: PendaftaranBinding(),
    ),
    GetPage(
      name: _Paths.LAPORAN,
      page: () => const LaporanView(),
      binding: LaporanBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.HALAMAN_LAPORAN_PKM,
      page: () => const HalamanLaporanPkmView(),
      binding: HalamanLaporanPkmBinding(),
    ),
  ];
}
