package membership;

import java.sql.Date;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.ServletContext;

import common.JDBCConnect;
import membership.MemberDTO;


public class adminDAO extends JDBCConnect {
	// 명시한 데이터베이스로의 연결이 완료된 MemberDAO 객체를 생성합니다.
    public adminDAO(String drv, String url, String id, String pw) {
        super(drv, url, id, pw);
    }
    public adminDAO(ServletContext application) {
        super(application);
    }
	
	// 총 몇명의 유저정보가 있는가 ( 사용자의 경우 ) 
    public int userCount(Map<String, Object> map) {
    	int totalcount = 0;
    	
    	String query = "select count(*) from user1";
    	
    	try {
    		stmt = con.createStatement();
    		rs = stmt.executeQuery(query);
    		rs.next();
    		totalcount = rs.getInt(1);
    		
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return totalcount;
    	
    }
	// 전부다 출력해서 리스트로 조회 
public List<MemberDTO> selectUserinfo(Map<String, Object> map) {
    	
    	List<MemberDTO> bbs = new Vector<MemberDTO>();
    	
    	String query = "SELECT * FROM USER1";
    	if (map.get("searchWord") != null) {
    	    query += " WHERE " + map.get("searchField") + " LIKE '%" + map.get("searchWord") + "%'";
    	}
    	query += " ORDER BY ID ASC";
        //private String id;
        //private String pass;
       // private String name;
       // private String email;
       // private String phonenumber;
       // private String gender;
       // private Date regidate;
       // private String role;
    		  try {
    			  stmt = con.createStatement();
    			  rs = stmt.executeQuery(query);
    			  
    			  while (rs.next()) {
    				  MemberDTO dto = new MemberDTO();
    				  
    				 dto.setId(rs.getString("id"));
    				 dto.setPass(rs.getString("pass"));
    				 dto.setName(rs.getString("name"));
    				 dto.setEmail(rs.getString("email"));
    				 dto.setPhonenumber(rs.getString("phonenumber"));
    				 dto.setGender(rs.getString("gender"));
    				 dto.setRegidate(rs.getDate("regidate"));
    				 dto.setRole(rs.getString("role"));
    				  
    				 bbs.add(dto);
    			  }
    		  } catch(Exception e) {
    			  e.printStackTrace();
    		  }
    		  return bbs;
    }
public int updateadminuserinfo(String pw, String name, String email, String phonenumber, String gender, String role, String id) {
	   int result = 0;
	   
	   String query = "UPDATE user1 SET pass = ?, name = ?, email = ?, phonenumber = ?, gender = ?, role = ? where id = ?";
	   
	   try {
		   psmt = con.prepareStatement(query);
		   psmt.setString(1,pw);
		   psmt.setString(2,name);
		   psmt.setString(3,email);
		   psmt.setString(4,phonenumber);
		   psmt.setString(5,gender);
		   psmt.setString(6,role);
		   psmt.setString(7, id);
		   
		   result = psmt.executeUpdate();
		   
	   } catch (Exception e) {
		   e.printStackTrace();
	   }
	   return result;
}

public int deleteuserinfo(String id) {
	   
	   int result = 0;
	   
	   String query = "delete from user1 where id = ? ";
	   
	   try {
		   psmt = con.prepareStatement(query);
		   psmt.setString(1, id);
		   result = psmt.executeUpdate();
		   
	   } catch(Exception e) {
		   e.printStackTrace();
	   }
	   return result;
}

}
