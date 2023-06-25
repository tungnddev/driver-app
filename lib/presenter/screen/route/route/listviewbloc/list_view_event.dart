class RouteListViewEvent {

}

class RouteListViewStartLoad extends RouteListViewEvent {
  DateTime dateTime;
  RouteListViewStartLoad(this.dateTime);
}