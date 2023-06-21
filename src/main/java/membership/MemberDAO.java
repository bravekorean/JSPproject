package membership;

import java.sql.SQLException;

import javax.servlet.ServletContext;

import common.JDBCConnect;

public class MemberDAO extends JDBCConnect {
    // 명시한 데이터베이스로의 연결이 완료된 MemberDAO 객체를 생성합니다.
    public MemberDAO(String drv, String url, String id, String pw) {
        super(drv, url, id, pw);
    }
    public MemberDAO(ServletContext application) {
        super(application);
    }
    
    //패스워드 첵크 하고 True/False 반환
    public boolean checkpass(String id, String pass) {
		boolean result = false;
		String sql = "select * from user1 where id = ?";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1,id);
			rs = psmt.executeQuery();
			while(rs.next()) {
			String check_pass = rs.getString(2);
			
			if(pass.equals(check_pass)) return result = true;
			} return result;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}

    // 명시한 아이디/패스워드와 일치하는 회원 정보를 반환합니다.
    public MemberDTO getMemberDTO(String uid, String upass) {
        MemberDTO dto = new MemberDTO();  // 회원 정보 DTO 객체 생성
        String query = "SELECT * FROM user1 WHERE id=? AND pass=?";  // 쿼리문 템플릿

        try {
            // 쿼리 실행
            psmt = con.prepareStatement(query); // 동적 쿼리문 준비
            psmt.setString(1, uid);    // 쿼리문의 첫 번째 인파라미터에 값 설정
            psmt.setString(2, upass);  // 쿼리문의 두 번째 인파라미터에 값 설정
            rs = psmt.executeQuery();  // 쿼리문 실행

            // 결과 처리
            if (rs.next()) {
                // 쿼리 결과로 얻은 회원 정보를 DTO 객체에 저장
                dto.setId(rs.getString("id"));
                dto.setPass(rs.getString("pass"));
                dto.setName(rs.getString("name"));
                dto.setEmail(rs.getString("email"));
                dto.setPhonenumber(rs.getString(5));
                dto.setRole(rs.getString("role"));
                
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }

        return dto;  // DTO 객체 반환
    }
    
    public MemberDTO getMemberDTO(String uid) {
		MemberDTO dto = new MemberDTO();
		
		String sql = "select * from user1 where id=? ";
		
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, uid);
			rs = psmt.executeQuery(); // resultSet 반환
			
			if(rs.next()) {
				dto.setId(rs.getString(1));
                dto.setPass(rs.getString(2));
                dto.setName(rs.getString(3));
                dto.setEmail(rs.getString(4));
                dto.setPhonenumber(rs.getString(5));
                dto.setGender(rs.getString(6));
                dto.setRegidate(rs.getDate(7));
                
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return dto;
	}
	
    
    public boolean insertMemberDTO(String uid, String upass, String uname, String uemail, String uphonenumber,
    		String gender, String role) {
    
    	boolean result = true;
    	String query = "insert into user1 VALUES(?,?,?,?,?,?,sysdate,default)";
    	try {
    			psmt = con.prepareStatement(query);
    			psmt.setString(1, uid);
    			psmt.setString(2, upass);
    			psmt.setString(3, uname);
    			psmt.setString(4, uemail);
    			psmt.setString(5, uphonenumber);
    			psmt.setString(6, gender);
    			
    			
    			
    			int rs = psmt.executeUpdate();
    			if(rs == 0) {
    				return false;
    			}
    
    				
    			
    		} catch (SQLException e) {
    			e.printStackTrace();
    			return false;

    		}
    	
    	return result;
}
    public MemberDTO updateMemberDTO(String uid, String upass, String pass, String uemail, String uphonenumber) {
    	MemberDTO dto = new MemberDTO();
    	
    	String query = "update user1 set pass = ?, email = ?, phonenumber = ? where id = ? and pass = ?";
    	//String query = "update member1 set id = ? where id = ? and pass = ?";
    	
    	try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, upass);
			psmt.setString(2, uemail);
			psmt.setString(3, uphonenumber);
			psmt.setString(4, uid);
			psmt.setString(5, pass);
			int rs = psmt.executeUpdate();
			
			
    	} catch (SQLException e) {
    		e.printStackTrace();
    	}
    	return dto;
    }
    
    //update 요청한 부분만 update
    public MemberDTO updateMemberDTO(String uid, String updatePart, String updateValue) {
    	MemberDTO dto = new MemberDTO();
    	
    	String query = "update user1 set "+ updatePart +"= ? where id = ?";
    	//String query = "update member1 set id = ? where id = ? and pass = ?";
    	
    	try {
    		psmt = con.prepareStatement(query);
    		psmt.setString(1, updateValue);
    		psmt.setString(2, uid);
    		psmt.executeUpdate();
    	} catch (SQLException e) {
    		e.printStackTrace();
    	}
    	return dto;
    }
    
    public MemberDTO deleteMemberDTO(String uid, String upass) {
    	MemberDTO dto = new MemberDTO();
    	
    	
    	String query = "delete from user1 where id = ? and pass = ?";
    	
    	try {
    		psmt = con.prepareStatement(query);
    		psmt.setString(1, uid);
    		psmt.setString(2, upass);  
    		psmt.executeUpdate();
    } catch (SQLException e) {
    	e.printStackTrace();
    }
    	return dto;
    }
    
    // 관리자 권한 변경 페이지 
    
    
}

