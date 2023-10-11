import 'package:flutter/material.dart';
import 'package:futsal_client_front/reservation_status/view/reservation_status_view.dart';

class TabInfo {
  final String label;
  final Widget tab;

  const TabInfo({required this.label, required this.tab});
}

const TABS = [
  TabInfo(label: '예약 현황', tab: ReservationStatusView()),
];
