import 'package:flutter/material.dart';
import 'package:futsal_client_front/common/styles/colors.dart';
import 'package:futsal_client_front/common/styles/sizes.dart';
import 'package:futsal_client_front/common/styles/text_styles.dart';
import 'package:futsal_client_front/reservation_status/component/reservation_state/reservation_state_item_2.dart';
import 'package:futsal_client_front/reservation_status/model/entity/reservation_entity.dart';
import 'package:futsal_client_front/reservation_status/model/state/reservation_list_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReservationStateList extends ConsumerStatefulWidget {
  final ReservationStatusListState state;
  final List<ReservationStatusEntity>? reservationStatusList;
  final void Function(int) onClick;

  const ReservationStateList({
    Key? key,
    required this.state,
    required this.reservationStatusList,
    required this.onClick,
  }) : super(key: key);

  @override
  ConsumerState<ReservationStateList> createState() =>
      _ReservationStateListState();
}

class _ReservationStateListState extends ConsumerState<ReservationStateList> {
  @override
  Widget build(BuildContext context) {
    switch (widget.state.runtimeType) {
      case ReservationStatusListStateNone:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: const AssetImage("assets/image/black_logo.png"),
                width: kIconLargeSize * 5,
                height: kIconLargeSize * 5,
              ),
              Text(
                "아직 예약이 오픈되지 않았습니다.",
                style: kTextMainStyle.copyWith(fontSize: kTextLargeSize),
              ),
              SizedBox(height: kPaddingMiddleSize),
            ],
          ),
        );
      case ReservationStatusListStateLoading:
        return const Center(child: CircularProgressIndicator());
      case ReservationStatusListStateSuccess:
        return Column(
          children: widget.reservationStatusList!
              .asMap()
              .entries
              .map(
                (e) => Expanded(
                  child: Stack(
                    children: [
                      if (widget.reservationStatusList!.length - 1 != e.key)
                        Positioned(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: kPaddingLargeSize +
                                  (kIconMiddleSize - kBorderWidth) / 2,
                            ),
                            child: Container(
                              color: kMainColor,
                              width: kBorderWidth,
                            ),
                          ),
                        ),
                      Column(
                        children: [
                          Expanded(
                            child: ReservationStateItem2(
                              index: e.key,
                              entity: e.value,
                              onPressed: () => widget.onClick(e.value.reservationId),
                              isLast:
                                  widget.reservationStatusList!.length - 1 ==
                                      e.key,
                            ),
                          ),
                          SizedBox(height: kPaddingLargeSize),
                        ],
                      )
                    ],
                  ),
                ),
              )
              .toList(),
        );
      case ReservationStatusListStateError:
        return Container();
    }
    return Container();
  }
}

class CustomCancelListController extends ChangeNotifier {
  late final List<int> _cancelIdList;

  CustomCancelListController() {
    _cancelIdList = [];
  }

  List<int> get cancelIdList => _cancelIdList;

  void onClick(int id) {
    if (isChecked(id)) {
      _cancelIdList.remove(id);
    } else {
      _cancelIdList.add(id);
      _cancelIdList.sort();
    }
    notifyListeners();
  }

  void reset() {
    _cancelIdList.clear();
    notifyListeners();
  }

  bool isChecked(int id) {
    return _cancelIdList.contains(id);
  }
}
