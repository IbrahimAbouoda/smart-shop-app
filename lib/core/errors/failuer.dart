// ignore_for_file: deprecated_member_use

abstract class Failuer {}

class ServerFailuer extends Failuer {
  String messgae;

  ServerFailuer(this.messgae);
}

class NetworkFailuer extends Failuer {}

class CachFailuer extends Failuer {}
