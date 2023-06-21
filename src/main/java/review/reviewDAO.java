package review;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

import javax.servlet.ServletContext;

import common.JDBCConnect;

public class reviewDAO extends JDBCConnect{
	public reviewDAO(String drv, String url, String id, String pw) {
        super(drv, url, id, pw);
    }
    public reviewDAO(ServletContext application) {
        super(application);
    }
    
    public boolean addReview(String title, String titleR,  String content, String id, int rating, String img, InputStream data) {
    	boolean result = true;
    	String query = "insert into review (num,title,content,id,rdate,visitcount,titler,rating,like_num,img,data) values(rv_b_num.nextval,?,?,?,sysdate,0,?,?,0,?,?) ";
    	try {
			psmt = con.prepareStatement(query);
    		psmt.setString(1, title);
    		psmt.setString(2, content);
    		psmt.setString(3, id);
    		psmt.setString(4, titleR);
    		psmt.setInt(5, rating);
    		psmt.setString(6, img);
    		psmt.setBlob(7, data);
			
    		int rs = psmt.executeUpdate();
    		if(rs == 0) {
    			return false;
    		}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
    	
    	return result;
    }
    
    public List<reviewDTO> getAllReview(){
    	List<reviewDTO> list = new ArrayList<reviewDTO>();
    	
    	String query = "select * from review";
    	try {
    		stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()) {
				reviewDTO dto = new reviewDTO();
				
				dto.setNum(rs.getInt(1));
				dto.setTitle(rs.getString(2));
				dto.setContent(rs.getString(3));
				dto.setId(rs.getString(4));
				dto.setRdate(rs.getDate(5));
				dto.setVisitcount(rs.getInt(6));
				dto.setTitleR(rs.getString(7));
				dto.setRating(rs.getInt(8));
				dto.setLike_num(rs.getInt(9));
				dto.setImg(rs.getString(10));
				dto.setData(rs.getBinaryStream(11));;
				list.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	
    	return list;
    }
    public List<reviewDTO> getAllReviewByLikeNum(){
    	List<reviewDTO> list = new ArrayList<reviewDTO>();
    	
    	String query = "select * from review ORDER BY like_num DESC";
    	try {
    		stmt = con.createStatement();
    		rs = stmt.executeQuery(query);
    		while(rs.next()) {
    			reviewDTO dto = new reviewDTO();
    			
    			dto.setNum(rs.getInt(1));
    			dto.setTitle(rs.getString(2));
    			dto.setContent(rs.getString(3));
    			dto.setId(rs.getString(4));
    			dto.setRdate(rs.getDate(5));
    			dto.setVisitcount(rs.getInt(6));
    			dto.setTitleR(rs.getString(7));
    			dto.setRating(rs.getInt(8));
    			dto.setLike_num(rs.getInt(9));
    			dto.setImg(rs.getString(10));
    			dto.setData(rs.getBinaryStream(11));;
    			list.add(dto);
    		}
    	} catch (SQLException e) {
    		// TODO Auto-generated catch block
    		e.printStackTrace();
    	}
    	
    	return list;
    }
    
    public List<reviewDTO> getAllReviewByVisitCount(){
    	List<reviewDTO> list = new ArrayList<reviewDTO>();
    	
    	String query = "select * from review ORDER BY visitcount DESC";
    	try {
    		stmt = con.createStatement();
    		rs = stmt.executeQuery(query);
    		while(rs.next()) {
    			reviewDTO dto = new reviewDTO();
    			
    			dto.setNum(rs.getInt(1));
    			dto.setTitle(rs.getString(2));
    			dto.setContent(rs.getString(3));
    			dto.setId(rs.getString(4));
    			dto.setRdate(rs.getDate(5));
    			dto.setVisitcount(rs.getInt(6));
    			dto.setTitleR(rs.getString(7));
    			dto.setRating(rs.getInt(8));
    			dto.setLike_num(rs.getInt(9));
    			dto.setImg(rs.getString(10));
    			dto.setData(rs.getBinaryStream(11));;
    			list.add(dto);
    		}
    	} catch (SQLException e) {
    		// TODO Auto-generated catch block
    		e.printStackTrace();
    	}
    	
    	return list;
    }
    
    
    public List<reviewDTO> getAllReviewByNum(){
    	List<reviewDTO> list = new ArrayList<reviewDTO>();
    	
    	String query = "select * from review ORDER BY num DESC";
    	try {
    		stmt = con.createStatement();
    		rs = stmt.executeQuery(query);
    		while(rs.next()) {
    			reviewDTO dto = new reviewDTO();
    			
    			dto.setNum(rs.getInt(1));
    			dto.setTitle(rs.getString(2));
    			dto.setContent(rs.getString(3));
    			dto.setId(rs.getString(4));
    			dto.setRdate(rs.getDate(5));
    			dto.setVisitcount(rs.getInt(6));
    			dto.setTitleR(rs.getString(7));
    			dto.setRating(rs.getInt(8));
    			dto.setLike_num(rs.getInt(9));
    			dto.setImg(rs.getString(10));
    			dto.setData(rs.getBinaryStream(11));;
    			list.add(dto);
    		}
    	} catch (SQLException e) {
    		// TODO Auto-generated catch block
    		e.printStackTrace();
    	}
    	
    	return list;
    }
    
    public reviewDTO getReviewByTitle (String title) {
    	reviewDTO dto = new reviewDTO();
    	String query = "select * from review where title = ?";
    	query += " ORDER BY num DESC "; 
    	try {
    		psmt = con.prepareStatement(query);
    		psmt.setString(1, title);
			rs = psmt.executeQuery();
			while(rs.next()) {
				
				dto.setNum(rs.getInt(1));
				dto.setTitle(rs.getString(2));
				dto.setContent(rs.getString(3));
				dto.setId(rs.getString(4));
				dto.setRdate(rs.getDate(5));
				dto.setVisitcount(rs.getInt(6));
				dto.setTitleR(rs.getString(7));
				dto.setRating(rs.getInt(8));
				dto.setLike_num(rs.getInt(9));
				dto.setImg(rs.getString(10));
				dto.setData(rs.getBinaryStream(11));;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	
    	return dto;
    }
    
    public reviewDTO getReviewById (String id) {
    	reviewDTO dto = new reviewDTO();
    	String query = "select * from review where id = ?";
    	query += " ORDER BY Rdate DESC "; 
    	try {
    		psmt = con.prepareStatement(query);
			rs = psmt.executeQuery();
			while(rs.next()) {
				
				dto.setNum(rs.getInt(1));
				dto.setTitle(rs.getString(2));
				dto.setContent(rs.getString(3));
				dto.setId(rs.getString(4));
				dto.setRdate(rs.getDate(5));
				dto.setVisitcount(rs.getInt(6));
				dto.setTitleR(rs.getString(7));
				dto.setRating(rs.getInt(8));
				dto.setLike_num(rs.getInt(9));
				dto.setImg(rs.getString(10));
				dto.setData(rs.getBinaryStream(11));;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	
    	return dto;
    }
    
    public void updateVisitCount(int num) { 

        String query = "UPDATE review SET "
                     + " visitcount=visitcount+1 "
                     + " WHERE num=?";
        
        try {
            psmt = con.prepareStatement(query);
            psmt.setInt(1, num);   
            psmt.executeQuery();
        } 
        catch (Exception e) {
            System.out.println("게시물 조회수 증가 중 예외 발생");
            e.printStackTrace();
        }
    }
    
    public void updateLikeCount(int num, int check) { 
    	if(check == 1) {
    	String query = "UPDATE review SET "
    			+ " like_num=like_num+1, visitcount=visitcount-1 "
    			+ " WHERE num=?";
    	
    	try {
    		psmt = con.prepareStatement(query);
    		psmt.setInt(1, num);   
    		psmt.executeQuery();    
    	} 
    	catch (Exception e) {
    		System.out.println("예외 발생");
    		e.printStackTrace();
    	}
    	}
    	if(check == 0) {
    		String query = "UPDATE review SET "
        			+ " like_num=like_num-1, visitcount=visitcount-1 "
        			+ " WHERE num=?";
        	
        	try {
        		psmt = con.prepareStatement(query);
        		psmt.setInt(1, num);   
        		psmt.executeQuery();    
        	} 
        	catch (Exception e) {
        		System.out.println("예외 발생");
        		e.printStackTrace();
        	}
    	}
    }
    
    public int updateReview(reviewDTO dto) { 
        int result = 0;
        
        try {

            String query = "UPDATE review SET "
                         + " titleR=?, content=?, rating = ? , img=?, data = ?, title=?"
                         + " WHERE num = ?";
            
            
            psmt = con.prepareStatement(query);
            psmt.setString(1, dto.getTitleR());
            psmt.setString(2, dto.getContent());
            psmt.setInt(3, dto.getRating());
            psmt.setString(4, dto.getImg());
            psmt.setBlob(5, dto.getData());
            psmt.setString(6, dto.getTitle());
            psmt.setInt(7, dto.getNum());
            
            
            result = psmt.executeUpdate();
        } 
        catch (Exception e) {
            System.out.println("수정 중 예외 발생");
            e.printStackTrace();
        }
        
        return result;
    }
    
    public int deletePost(int num) { 
        int result = 0;

        try {
            
            String query = "DELETE FROM review WHERE num = ?"; 

            
            psmt = con.prepareStatement(query); 
            psmt.setInt(1, num); 

            
            result = psmt.executeUpdate(); 
        } 
        catch (Exception e) {
            System.out.println("삭제 중 예외 발생");
            e.printStackTrace();
        }
        
        return result;
    }
    
    public reviewDTO getReviewByNum (int num) {
    	reviewDTO dto = new reviewDTO();
    	String query = "select * from review where num = ?";
    	try {
    		psmt = con.prepareStatement(query);
    		psmt.setInt(1, num);
			rs = psmt.executeQuery();
			while(rs.next()) {
				
				dto.setNum(rs.getInt(1));
				dto.setTitle(rs.getString(2));
				dto.setContent(rs.getString(3));
				dto.setId(rs.getString(4));
				dto.setRdate(rs.getDate(5));
				dto.setVisitcount(rs.getInt(6));
				dto.setTitleR(rs.getString(7));
				dto.setRating(rs.getInt(8));
				dto.setLike_num(rs.getInt(9));
				dto.setImg(rs.getString(10));
				dto.setData(rs.getBinaryStream(11));;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	
    	return dto;
    }
    
    // Define a method to convert InputStream to Base64 string
    public String getBase64Image(InputStream inputStream) {
      ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
      byte[] buffer = new byte[4096];
      int bytesRead;
      try {
          while ((bytesRead = inputStream.read(buffer)) != -1) {
              outputStream.write(buffer, 0, bytesRead);
          }
      } catch (IOException e) {
          e.printStackTrace();
      } finally {
          try {
              inputStream.close();
              outputStream.close();
          } catch (IOException e) {
              e.printStackTrace();
          }
      }

      return Base64.getEncoder().encodeToString(outputStream.toByteArray());
    }
    
    
}
