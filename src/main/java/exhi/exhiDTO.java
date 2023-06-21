package exhi;

public class exhiDTO {
	
    public exhiDTO(String seq, String title, String place, String startDate, String endDate, String realmName, String area, String thumbnail, String gpsX, String gpsY) {
        this.seq = seq;
        this.title = title;
        this.place = place;
        this.startDate = startDate;
        this.endDate = endDate;
        this.realmName = realmName;
        this.area = area;
        this.thumbnail = thumbnail;
        this.gpsX = gpsX;
        this.gpsY = gpsY;
    }
    public exhiDTO(String thumbnail) {
    	this.thumbnail = thumbnail;
    } 
    	
    
    public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getPlace() {
		return place;
	}
	public void setPlace(String place) {
		this.place = place;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getRealmName() {
		return realmName;
	}
	public void setRealmName(String realmName) {
		this.realmName = realmName;
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public String getThumbnail() {
		return thumbnail;
	}
	public void setThumbnail(String thumbnail) {
		this.thumbnail = thumbnail;
	}
	public String getGpsX() {
		return gpsX;
	}
	public void setGpsX(String gpsX) {
		this.gpsX = gpsX;
	}
	public String getGpsY() {
		return gpsY;
	}
	public void setGpsY(String gpsY) {
		this.gpsY = gpsY;
	}
	private String seq;
    private String title;
    private String place;
    private String startDate;
    private String endDate;
    private String realmName;
    private String area;
    private String thumbnail;
    private String gpsX;
    private String gpsY;
}
