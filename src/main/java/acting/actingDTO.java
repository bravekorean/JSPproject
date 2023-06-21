package acting;

public class actingDTO {
	
private String title;
private String Content;
private String id;
private int price;
private java.sql.Date adate;
private int visitcount;
private int num;

public int getNum() {
	return num;
}
public void setNum(int num) {
	this.num = num;
}
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
public java.sql.Date getAdate() {
	return adate;
}
public void setAdate(java.sql.Date adate) {
	this.adate = adate;
}
public int getVisitcount() {
	return visitcount;
}
public void setVisitcount(int visitcount) {
	this.visitcount = visitcount;
}
}
