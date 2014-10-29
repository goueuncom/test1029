package mybean;

import java.util.List;
import java.util.Vector;
import java.sql.*;

public class SawonDao {
	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DBConnectionMgr pool;
	
	public SawonDao(){
		try{
			pool = DBConnectionMgr.getInstance();
		}
		catch(Exception err){
			System.out.println("DB연결 실패 : " + err);
		}
	}
		
	// index.jsp에서 사용 할 메서드
	public List getList(String search, String searchText){
		Vector list = new Vector();
		String sql = null;
		try{
			con = pool.getConnection();
			
			if(searchText == null || searchText.isEmpty()){
				sql = "select * from tblsawon order by no";
			}
			else{
				sql = "select * from tblsawon where " + search
						+ " like '%" + searchText + "%' order by no";
			}
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				SawonDto dto = new SawonDto();
				dto.setNo(rs.getInt("no"));
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setPass(rs.getString("pass"));
				dto.setAge(rs.getInt("age"));
				dto.setAddr(rs.getString("addr"));
				dto.setDept(rs.getString("dept"));
				dto.setExt(rs.getString("ext"));
				
				list.add(dto);
			}
		}
		catch(Exception err){
			System.out.println("getList() : " + err);
		}
		finally{
			pool.freeConnection(con, pstmt, rs);
		}
		return list;
	}
	
	public void addSawon(SawonDto dto){
		pool = DBConnectionMgr.getInstance();
		String sql = "insert into tblsawon values(seq_no.nextVal,?,?,?,?,?,?,?)";
		try{
			con = pool.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getName());
			pstmt.setString(3, dto.getPass());
			pstmt.setInt(4, dto.getAge());
			pstmt.setString(5, dto.getAddr());
			pstmt.setString(6, dto.getExt());
			pstmt.setString(7, dto.getDept());
			pstmt.executeUpdate();			
		}
		catch(Exception err){
			System.out.println("addSawon() : " + err);
		}
		finally{
			pool.freeConnection(con, pstmt, rs);
		}
	}
	
	public SawonDto getSawon(int no){
		pool = DBConnectionMgr.getInstance();
		SawonDto dto = new SawonDto();
		try{
			con = pool.getConnection();
			String sql = "select * from tblsawon where no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setPass(rs.getString("pass"));
				dto.setAge(rs.getInt("age"));
				dto.setAddr(rs.getString("addr"));
				dto.setExt(rs.getString("ext"));
				dto.setDept(rs.getString("dept"));
			}
		}
		catch(Exception err){
			System.out.println("getSawon() : " + err);
		}
		finally{
			pool.freeConnection(con, pstmt, rs);
		}
		return dto;
	}
	public void editSawon(SawonDto dto){
		pool = DBConnectionMgr.getInstance();
		String sql = "update tblsawon set id=?, name=?, pass=?, age=?, addr=?, ext=?, dept=? where no=?";

		try{
			con = pool.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getName());
			pstmt.setString(3, dto.getPass());
			pstmt.setInt(4, dto.getAge());
			pstmt.setString(5, dto.getAddr());
			pstmt.setString(6, dto.getExt());
			pstmt.setString(7, dto.getDept());
			pstmt.setInt(8, dto.getNo());
			pstmt.executeUpdate();
		}
		catch(Exception err){
			System.out.println("editSawon() : " + err);
		}
		finally{
			pool.freeConnection(con, pstmt, rs);
		}
	}
	public void deleteSawon(int no){
		pool = DBConnectionMgr.getInstance();
		
		try{
			con = pool.getConnection();
			String sql = "delete from tblsawon where no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			pstmt.executeUpdate();
		}
		catch(Exception err){
			System.out.println("deleteSawon() : " + err);
		}
		finally{
			pool.freeConnection(con, pstmt, rs);
		}
	}
}