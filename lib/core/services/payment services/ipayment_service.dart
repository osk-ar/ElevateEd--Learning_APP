abstract interface class IpaymentService {
  Future<void> pay();
  Future<String> getPaymentKey(int amount, {String currency = "EGP"});
}
