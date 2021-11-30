import 'package:flutter/material.dart';
import 'package:minesweeper/models/default_levels.dart';

Row getDefaultLevelButtons(
    Function canChangeValues, Function setState, Function reloadVariables) {
  return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
    EasyLevel().getButton(canChangeValues, setState, reloadVariables),
    MediumLevel().getButton(canChangeValues, setState, reloadVariables),
    HardLevel().getButton(canChangeValues, setState, reloadVariables),
  ]);
}
