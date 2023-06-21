package ticket;

import java.sql.Date;

public class ticketDTO {
int num;
String userid;
String phonenumber;
int price;
int payinfo;
int time;
int age;
String productinfo;
java.sql.Date regidate;

public int getNum() {
	return num;
}
public void setNum(int num) {
	this.num = num;
}
public int getTime() {
	return time;
}
public void setTime(int time) {
	this.time = time;
}
public int getAge() {
	return age;
}
public void setAge(int age) {
	this.age = age;
}
public String getUserid() {
	return userid;
}
public void setUserid(String userid) {
	this.userid = userid;
}
public String getPhonenumber() {
	return phonenumber;
}
public void setPhonenumber(String phonenumber) {
	this.phonenumber = phonenumber;
}
public int getPrice() {
	return price;
}
public void setPrice(int price) {
	this.price = price;
}
public int getPayinfo() {
	return payinfo;
}
public void setPayinfo(int payinfo) {
	this.payinfo = payinfo;
}
public String getProductinfo() {
	return productinfo;
}
public void setProductinfo(String productinfo) {
	this.productinfo = productinfo;
}
public java.sql.Date getRegidate() {
	return regidate;
}
public void setRegidate(java.sql.Date regidate) {
	this.regidate = regidate;
}
}
