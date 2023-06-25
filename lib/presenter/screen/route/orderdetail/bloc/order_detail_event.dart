class OrderDetailEvent {
}

class OrderDetailStartLoad extends OrderDetailEvent {
  int id;
  OrderDetailStartLoad(this.id);
}