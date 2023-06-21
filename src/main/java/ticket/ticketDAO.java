package ticket;

import java.sql.Date;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.ServletContext;
import javax.servlet.annotation.WebServlet;

import membership.MemberDTO;

import common.JDBCConnect;


public class ticketDAO extends JDBCConnect  {
	// 명시한 데이터베이스로의 연결이 완료된 MemberDAO 객체를 생성합니다.
    public ticketDAO(String drv, String url, String id, String pw) {
        super(drv, url, id, pw);
    }
    public ticketDAO(ServletContext application) {
        super(application);
    }
    
 // 명시한 아이디/휴대폰번호 와 일치하는 예약 정보를 반환합니다. 단건조회
    public ticketDTO getInfoDTO(String uid, String upnb) {
        ticketDTO dto = new ticketDTO();  // 회원 정보 DTO 객체 생성
        String query = "SELECT * FROM ticket1 WHERE userid=? AND phonenumber=?";  // 쿼리문 템플릿

        try {
            // 쿼리 실행
            psmt = con.prepareStatement(query); // 동적 쿼리문 준비
            psmt.setString(1, uid);    // 쿼리문의 첫 번째 인파라미터에 값 설정
            psmt.setString(2, upnb);  // 쿼리문의 두 번째 인파라미터에 값 설정
            rs = psmt.executeQuery();  // 쿼리문 실행

            // 결과 처리
            if (rs.next()) {
                // 쿼리 결과로 얻은 회원 정보를 DTO 객체에 저장
                dto.setUserid(rs.getString("userid"));
                dto.setPhonenumber(rs.getString(2));
                dto.setPrice(rs.getInt("price"));
                dto.setTime(rs.getInt("time"));
                dto.setAge(rs.getInt("age"));
                dto.setRegidate(rs.getDate("regidate"));
               
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }

        return dto;  // DTO 객체 반환
    }
    public ticketDTO getInfoDTO(String uid) {
		ticketDTO dto = new ticketDTO();
		
		String sql = "select * from ticket1 where userid=? ";
		
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, uid);
			rs = psmt.executeQuery(); // resultSet 반환
			
			if(rs.next()) {
				dto.setUserid(rs.getString(1));
				dto.setPhonenumber(rs.getString(2));
                dto.setPrice(rs.getInt(3));
                dto.setPayinfo(rs.getInt(4));
                dto.setTime(rs.getInt(5));
                dto.setAge(rs.getInt(6));
                dto.setProductinfo(rs.getString(7));
                dto.setRegidate(rs.getDate(8));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return dto;
	}
    public boolean insertInfoDTO(String uid, String upnb, int price, int payinfo, int time, int age, String prinfo,
    		java.sql.Date regidate) {
    
    	boolean result = true;
    	String query = "insert into ticket1 values(tick_b_num.nextval,?,?,?,?,?,?,?,?)";
    	try {
    		
    	
    			psmt = con.prepareStatement(query);
    			psmt.setString(1, uid);
    			psmt.setString(2, upnb);
    			psmt.setInt(3, price);
    			psmt.setInt(4, payinfo);
    			psmt.setString(5, prinfo);
    			psmt.setDate(6, regidate);
    			psmt.setInt(7, time);
    			psmt.setInt(8, age);
    			
    			
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
    //update 요청한 부분만 update
    public ticketDTO updateticketDTO(String uid, String updatePart, String updateValue) {
    	ticketDTO dto = new ticketDTO();
    	
    	String query = "update ticket1 set "+ updatePart +"= ? where userid = ?";
    	//String query = "update member1 set id = ? where id = ? and pass = ?";
    	
    	try {
    		psmt = con.prepareStatement(query);
    		psmt.setString(1, updateValue); // 바꿀 정보
    		psmt.setString(2, uid);
    		psmt.executeUpdate();
    	} catch (SQLException e) {
    		e.printStackTrace();
    	}
    	return dto;
    }
    
    public MemberDTO deleteMemberDTO(String uid, String pnb) {
    	MemberDTO dto = new MemberDTO();
    	
    	
    	String query = "delete from ticket1 where userid = ? and phonenumber = ?";
    	
    	try {
    		psmt = con.prepareStatement(query);
    		psmt.setString(1, uid); 
    		psmt.setString(2, pnb);
    		psmt.executeUpdate();
    } catch (SQLException e) {
    	e.printStackTrace();
    }
    	return dto;
    }
    
    public int insertCinfo(String imp_uid, String merchant_uid, int amount, String paymethod, String buyname, String buytel) {
    	 int result = 0;
    	String query = "insert into cinfo(imp_uid,merchant_uid,amount,pay_method,buyer_name,buyer_tel) values (?,?,?,?,?,?)";
    	
    	try {
    		psmt = con.prepareStatement(query);
    		psmt.setString(1, imp_uid);
    		psmt.setString(2, merchant_uid);
    		psmt.setInt(3, amount);
    		psmt.setString(4, paymethod);
    		psmt.setString(5, buyname);
    		psmt.setString(6, buytel);
    		
    		result = psmt.executeUpdate();
    		
    		System.out.println(result);
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return result;
    }
    // 총 몇개의 예매내역이 있는가 
    public int ticketNumcount(Map<String, Object> map) {
    	int totalcount = 0;
    	
    	String query = "select count(*) from ticket1";
    	
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
    
    // 총 몇개의 결제정보가 있는가 ( 사용자의 경우 ) 
    public int cinfoNumcount(Map<String, Object> map) {
    	int totalcount = 0;
    	
    	String query = "select count(*) from cinfo";
    	
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
    // 예매내역 조회하기
    public List<ticketDTO> selectTicketinfo(Map<String, Object> map, String userid) {
    	
    	List<ticketDTO> bbs = new Vector<ticketDTO>();
    	
    	String query = "select * from ticket1 where userid = '"+ userid + "' order by num asc";
    		  
    		  try {
    			  stmt = con.createStatement();
    			  rs = stmt.executeQuery(query);
    			  
    			  while (rs.next()) {
    				  ticketDTO dto = new ticketDTO();
    				  
    				 dto.setNum(rs.getInt("num"));
    				 dto.setUserid(rs.getString("userid"));
    				 dto.setPhonenumber(rs.getString("phonenumber"));
    				 dto.setPrice(rs.getInt("price"));
    				 dto.setPayinfo(rs.getInt("payinfo"));
    				 dto.setProductinfo(rs.getString("productinfo"));
    				 dto.setRegidate(rs.getDate("regidate"));
    				 dto.setTime(rs.getInt("time"));
    				 dto.setAge(rs.getInt("age"));
    				  
    				 bbs.add(dto);
    			  }
    		  } catch(Exception e) {
    			  e.printStackTrace();
    		  }
    		  return bbs;
    }
    
    // 결제정보 조회하기
    public List<cinfoDTO> selectCinfo(Map<String, Object> map, String userid) {
    	
    	List<cinfoDTO> bbs = new Vector<cinfoDTO>();
    	
    	String query = "select * from cinfo  where buyer_name = '" + userid + "'order by imp_uid asc";
    		  
    		  try {
    			  stmt = con.createStatement();
    			  rs = stmt.executeQuery(query);
    			  
    			  while (rs.next()) {
    				  cinfoDTO dto = new cinfoDTO();
    				  
    				 dto.setImp_uid(rs.getString("imp_uid"));
    				 dto.setAmount(rs.getInt("amount"));
    				 dto.setMerchant_uid(rs.getString("merchant_uid"));
    				 dto.setPay_method(rs.getString("pay_method"));
    				 dto.setBuyer_name(rs.getString("buyer_name"));
    				 dto.setBuyer_tel(rs.getString("buyer_tel"));
    				
    				  
    				 bbs.add(dto);
    			  }
    		  } catch(Exception e) {
    			  e.printStackTrace();
    		  }
    		  return bbs;
    }
    
    public int deleteticket(int code) {
    	
    	int result = 0;
    	
    	String query = "delete from ticket1 where num = ?";
    	
    	try {
    		psmt = con.prepareStatement(query);
    		psmt.setInt(1, code); 
    		result = psmt.executeUpdate();
    } catch (SQLException e) {
    	e.printStackTrace();
    }
    	return result;
    }
    
   public int deletecinfoDTO(String paycode) {
	   
	   int result = 0;
	   
	   String query = "delete from cinfo where imp_uid = ? ";
	   
	   try {
		   psmt = con.prepareStatement(query);
		   psmt.setString(1, paycode);
		   result = psmt.executeUpdate();
		   
	   } catch(Exception e) {
		   e.printStackTrace();
	   }
	   return result;
   }
   
   public int updateticketinfo(java.sql.Date date, int time, int code) {
	   int result = 0;
	   
	   String query = "UPDATE ticket1 SET regidate = ?, time = ? where num = ?";
	   
	   try {
		   psmt = con.prepareStatement(query);
		   psmt.setDate(1,date);
		   psmt.setInt(2, time);
		   psmt.setInt(3, code);
		   
		   result = psmt.executeUpdate();
		   
	   } catch (Exception e) {
		   e.printStackTrace();
	   }
	   return result;
   }
   
   //public ticketDTO 
   
  
}
