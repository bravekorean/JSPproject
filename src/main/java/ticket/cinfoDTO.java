package ticket;

public class cinfoDTO {
String imp_uid;
String merchant_uid;
int amount;
String pay_method;
String buyer_name;
String buyer_tel;
public String getImp_uid() {
	return imp_uid;
}
public void setImp_uid(String imp_uid) {
	this.imp_uid = imp_uid;
}
public String getMerchant_uid() {
	return merchant_uid;
}
public void setMerchant_uid(String merchant_uid) {
	this.merchant_uid = merchant_uid;
}
public int getAmount() {
	return amount;
}
public void setAmount(int amount) {
	this.amount = amount;
}
public String getPay_method() {
	return pay_method;
}
public void setPay_method(String pay_method) {
	this.pay_method = pay_method;
}
public String getBuyer_name() {
	return buyer_name;
}
public void setBuyer_name(String buyer_name) {
	this.buyer_name = buyer_name;
}
public String getBuyer_tel() {
	return buyer_tel;
}
public void setBuyer_tel(String buyer_tel) {
	this.buyer_tel = buyer_tel;
}
}
