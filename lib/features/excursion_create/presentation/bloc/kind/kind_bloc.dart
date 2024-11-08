// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import 'kind_event.dart';
// import 'kind_state.dart';
//
// class KindBloc extends Bloc<KindEvent, KindState> {
//
//   KindBloc() : super(const KindInitial(selectedKinds: [])) {
//     on<KindEvent>(
//           (event, emit) async {
//         if (event is UpdateKindsRequested) {
//           await _selectKinds(event, emit);
//         }
//       },
//     );
//   }
//
//   Future<void> _selectKinds(
//       UpdateKindsRequested event, Emitter<KindState> emit) async {
//     emit(KindInProgress(selectedKinds: event.kinds));
//     try {
//       List<String> newKinds = List.from(event.kinds);
//       if (newKinds.contains(event.kind)) {
//         newKinds.remove(event.kind);
//       } else {
//         newKinds.add(event.kind);
//       }
//       emit(KindsUpdateSuccess.withKinds(kindList: newKinds));
//     } catch (_) {
//       emit(KindFailure(errorMsg: 'Error in kinds update request.', selectedKinds: event.kinds));
//     }
//   }
// }
