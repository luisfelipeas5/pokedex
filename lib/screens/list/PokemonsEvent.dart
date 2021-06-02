import 'package:flutter/material.dart';

@immutable
abstract class PokemonsEvent {}

class PokemonsLoadEvent extends PokemonsEvent {}