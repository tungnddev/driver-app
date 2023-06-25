class PackingSlipVM {
  List<PackingSlipItemVM> orders;
  List<PackingSlipItemVM> accessories;
  String dateTime;

  PackingSlipVM(this.orders, this.accessories, this.dateTime);


}

class PackingSlipItemVM {
  String invoice;
  String orderItem;
  String quantity;
  bool isSelecting;

  PackingSlipItemVM(this.invoice, this.orderItem, this.quantity,
      this.isSelecting);


}
