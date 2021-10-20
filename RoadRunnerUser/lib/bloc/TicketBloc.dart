import 'package:flutter/material.dart';
import 'package:roadrunner/HomePage/ticketscreen.dart';
import 'package:roadrunner/Modals/generate_ticket.dart';
import 'package:roadrunner/Modals/ticket_list_response.dart';
import 'package:roadrunner/Utils/helperutils.dart';
import 'package:roadrunner/repository/TicketRepository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TicketBloc {
  final TicketRepository _repository = TicketRepository();
  final BehaviorSubject<GenerateTicket> _raiseReq =
  BehaviorSubject<GenerateTicket>();
  final BehaviorSubject<Ticket_list_response> _ticketlist =
  BehaviorSubject<Ticket_list_response>();

  raiserequest(int _id, String _subject, String _description,String accessToken,String tokenType, BuildContext context) async {
    GenerateTicket response = await _repository.raiserequest(
        _id, _subject, _description,accessToken,tokenType, context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString(SharedPrefsKeys.ACCESS_TOKEN);
    prefs.getString(SharedPrefsKeys.TOKEN_TYPE,);

    _raiseReq.sink.add(response);
  }
  ticketlist(int _id,String accessToken,String tokenType, BuildContext context) async {
    Ticket_list_response response = await _repository.ticketlist(
        _id,accessToken,tokenType, context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString(SharedPrefsKeys.ACCESS_TOKEN);
    prefs.getString(SharedPrefsKeys.TOKEN_TYPE,);

    _ticketlist.sink.add(response);
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
  BehaviorSubject<Ticket_list_response> get ticketList  =>
      _ticketlist;
}
final bloc = TicketBloc();