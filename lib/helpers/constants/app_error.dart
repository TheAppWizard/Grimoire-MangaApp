

import 'dart:math';

class AppError {
  static const String genericErrorMessage = 'Ops!! An error occurred. Please try again later.';
  static const String networkErrorMessage = 'Network error occurred. Please check your internet connection and try again.';
}

class AppDataNotFound {
  static const List<String> noDataMessages = [
    "Sorry, we couldn't find any treasure in this data mine! Let's dig a little deeper together.",
    "Looks like we've hit the data doldrums. Fear not, we'll navigate through this and find what you're looking for.",
    "Our data detectors are on high alert, but alas, they've come up empty-handed. Time for a data expedition!",
    "Seems like our data elves are on strike, leaving us with empty shelves. Let's conjure up a new strategy to fill them!",
    "Houston, we have a data anomaly! Our search has reached intergalactic emptiness. Time to launch a new query rocket.",
    "Data drought alert! Our search has come up dry. Let's sprinkle some data magic and conjure up what we need.",
    "The data universe seems to be playing hide and seek with us today. Let's sharpen our search skills and uncover its secrets!",
    "Data desert ahead! Looks like we've wandered into an oasis of zeroes and ones. Let's chart a new course to find the oasis we seek.",
    "Looks like we've hit a data roadblock. Time to take a detour and explore new avenues for information.",
    "Our data spelunking expedition has hit a dead end. But fear not, for in the labyrinth of information, there's always another path to explore!"
  ];
}

String selectRandomNoDataMessage() {
  final Random random = Random();
  return AppDataNotFound.noDataMessages[random.nextInt(AppDataNotFound.noDataMessages.length)];
}