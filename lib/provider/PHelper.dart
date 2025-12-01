import 'package:flutter/material.dart';
import 'package:how_many_i_spend/provider/provider-system.dart';
import 'package:how_many_i_spend/services/global-context.dart';
import 'package:provider/provider.dart';

class PHelper {

  static ProviderSystem system({BuildContext? context}) {
    return Provider.of<ProviderSystem>(context ?? GlobalContextKey.get(), listen: false);
  }
}