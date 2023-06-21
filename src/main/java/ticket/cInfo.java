package ticket;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


public class cInfo extends HttpServlet {
	private ticketDAO dao;
	
	@Override
    public void init() throws ServletException {
		super.init();
        ServletContext application = this.getServletContext();
        
        String driver = application.getInitParameter("OracleDriver");
        String url = application.getInitParameter("OracleURL");
        String id = application.getInitParameter("OracleId");
        String pw = application.getInitParameter("OraclePwd");
        
        dao = new ticketDAO(driver,url,id,pw);
        
    }
	@Override
	protected void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
	 
		//cinfoDTO dto = new cinfoDTO();
		//dto.setImp_uid(request.getParameter("imp_uid"));
		//dto.setMerchant_uid(request.getParameter("merchant_uid"));
		///dto.setAmount(Integer.parseInt(request.getParameter("amount")));
		//dto.setPay_method(request.getParameter("pay_method"));
		//dto.setBuyer_name(request.getParameter("buyer_name"));
		//dto.setBuyer_tel(request.getParameter("buyer_tel"));
	 String imp_uid = request.getParameter("imp_uid");
     String merchant_uid = request.getParameter("merchant_uid");
     int amount = Integer.parseInt(request.getParameter("paid_amount"));
     String paymethod = request.getParameter("pay_method");
     String buyname = request.getParameter("buyer_name");
     String buytel = request.getParameter("buyer_tel");
     
  // insertCinfo 메서드를 호출하여 데이터베이스에 정보 삽입
      dao.insertCinfo(imp_uid, merchant_uid, amount, paymethod, buyname, buytel);

     // 요청과 함께 처리 결과를 ticketProcess.jsp로 전달
     request.setAttribute("result", "결제 정보가 성공적으로 저장되었습니다.");
     request.getRequestDispatcher("/mypage/mypage.jsp").forward(request, response); // 이걸 결제완료페이지로 전달
     // 06.10 예매내역 및 결제완료 페이지, 관리자페이지 생성해야함.
 }
	@Override
	public void destroy() {
		dao.close();
	}
}
