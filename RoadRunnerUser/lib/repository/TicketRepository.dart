import 'package:flutter/cupertino.dart';
import 'package:roadrunner/Modals/generate_ticket.dart';

import 'api_provider.dart';

class TicketRepository {
  ApiProvider _apiProvider = ApiProvider();

  Future<GenerateTicket> fetchTicket(int _id,String _subject,String _description,BuildContext context){
    return _apiProvider.raiserequest(_id,_subject,_description,context);
  }

}