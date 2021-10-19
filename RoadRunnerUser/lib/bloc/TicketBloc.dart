import 'package:flutter/material.dart';
import 'package:roadrunner/HomePage/ticketscreen.dart';
import 'package:roadrunner/Modals/generate_ticket.dart';
import 'package:roadrunner/repository/TicketRepository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TicketBloc {
  final TicketRepository _repository = TicketRepository();
  final BehaviorSubject<GenerateTicket> _raiseReq =
  BehaviorSubject<GenerateTicket>();

  raiseReq(int _id, String _subject, String _description, BuildContext context) async {
    GenerateTicket response = await _repository.fetchTicket(
        _id, _subject, _description, context);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    _raiseReq.sink.add(response);
  }
  dispose() {
    _raiseReq.close();

    print("DISPOSED");
  }
    unSubscribeEvents(){
      _raiseReq.add(null);


  }
  BehaviorSubject<GenerateTicket> get raiseRequest =>
      _raiseReq;
}
final bloc = TicketBloc();