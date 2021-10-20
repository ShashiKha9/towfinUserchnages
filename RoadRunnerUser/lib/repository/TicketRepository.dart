import 'package:flutter/cupertino.dart';
import 'package:roadrunner/Modals/generate_ticket.dart';
import 'package:roadrunner/Modals/ticket_list_response.dart';

import 'api_provider.dart';

class TicketRepository {
  ApiProvider _apiProvider = ApiProvider();

  Future<GenerateTicket> raiserequest(int _id,String _subject,String _description,String accessToken,String tokenType,BuildContext context) {
    return _apiProvider.raiserequest(
        _id, _subject, _description, tokenType, accessToken, context);
  }
    Future<Ticket_list_response> ticketlist(int _id,String accessToken,String tokenType,BuildContext context){
      return _apiProvider.tickelist(_id,tokenType,accessToken,context);
  }

}