package musical;

public class muscialDTO {
private String title;
private String Content;
private String id;
private int price;
private java.sql.Date mdate;
private int visitcount;
private int num;
public String getTitle() {
	return title;
}
public void setTitle(String title) {
	this.title = title;
}
public String getContent() {
	return Content;
}
public void setContent(String content) {
	Content = content;
}
public String getId() {
	return id;
}
public void setId(String id) {
	this.id = id;
}
public int getPrice() {
	return price;
}
public void setPrice(int price) {
	this.price = price;
}
public java.sql.Date getMdate() {
	return mdate;
}
public void setMdate(java.sql.Date mdate) {
	this.mdate = mdate;
}
public int getVisitcount() {
	return visitcount;
}
public void setVisitcount(int visitcount) {
	this.visitcount = visitcount;
}
public int getNum() {
	return num;
}
public void setNum(int num) {
	this.num = num;
}
}
