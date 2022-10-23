abstract class OrderView {
  onNetworkError();

  onSuccessGetOrder(Map data);
  onFailGetOrder(Map data);

  onSuccessGetMenu(Map data);
  onFaildGetMenu(Map data);
  onSuccessAddOrder(Map data);
  onFaildAddOrder(Map data);
}
