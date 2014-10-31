package mybean;

import java.sql.*;

public class semiDao {
	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DBConnectionMgr pool;
	
	public semiDao(){
		try{
			pool = DBConnectionMgr.getInstance();
			
		}
		catch(Exception err){
			System.out.println("semiDao() : " + err);
		}
		finally{
			pool.freeConnection(con, pstmt, rs);
		}
	}
	
	public void insertInput(int code, int count, String date){
		semiDto dto = new semiDto();
		String sql1 = "";
		String sql2 = "";
		
		try{
			sql1 = "select iname, cname, price, sprice , des from tlist where code = ?";
			pstmt = con.prepareStatement(sql1);
			pstmt.setInt(1, code);	
			rs = pstmt.executeQuery();
			rs.next();
			dto.setList_iname(rs.getString("iname"));
			dto.setList_cname(rs.getString("cname"));
			dto.setList_price(rs.getInt("price"));
			dto.setList_sell_price(rs.getInt("sprice"));
			dto.setList_des(rs.getInt("des"));
			
			sql1 = "update tstock set count = count+ ? where code=?";
			pstmt = con.prepareStatement(sql1);
			pstmt.setInt(1, count);
			pstmt.setInt(2, code);
			int result = pstmt.executeUpdate();
			System.out.println("update tstock 완료");
			
			if(result == 0){
				sql2 = "insert into tstock values(?, ?, ?, ?, ?, ?,?)";
				pstmt = con.prepareStatement(sql2);
				pstmt.setInt(1, code);
				pstmt.setString(2, dto.getList_iname());
				pstmt.setString(3, dto.getList_cname());
				pstmt.setInt(4, count);
				pstmt.setInt(5, dto.getList_price());
				pstmt.setInt(6, dto.getList_sell_price());
				pstmt.setInt(7, dto.getList_des());
				pstmt.executeUpdate();
				System.out.println("insert tstock 완료");
			}
			else{
				sql2 = "insert into tinput values(?, ?, ?, ?,?)";
				pstmt = con.prepareStatement(sql2);
				pstmt.setInt(1, code);
				pstmt.setString(2, dto.getList_iname());
				pstmt.setInt(3, count);
				pstmt.setString(4, date);
				pstmt.executeUpdate();
				System.out.println("insert tinput 완료");
			}
		}
		catch(Exception err){
			System.out.println("insertInput() : " + err);
		}
		finally{
			pool.freeConnection(con, pstmt);
		}
	}
}