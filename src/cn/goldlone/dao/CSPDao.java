package cn.goldlone.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import cn.goldlone.entity.Certification;
import cn.goldlone.entity.Score;
import cn.goldlone.model.ScoreInfo;

/**
 * CSP操作
 * @author CN
 * 创建时间: 2017-10-12
 */
public class CSPDao {
	
	/**
	 * 创建模板
	 */
	public void model() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		try {
			conn = DBDao.getConnection();
			sql = ";";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBDao.closeConnection(conn);
			DBDao.closePreparedStatement(pstmt);
			DBDao.closeResultSet(rs);
		}
	}
	
	/**
	 * 添加成绩
	 * @param score
	 * @return
	 */
	public boolean addScore(Score score) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			conn = DBDao.getConnection();
			sql = "insert into Score values(?, ?, ?, ?, ?, ?, ?, ?);";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, score.getCertNo());
			pstmt.setString(2, score.getMemberNo());
			pstmt.setInt(3, score.getAll());
			pstmt.setInt(4, score.getFirst());
			pstmt.setInt(5, score.getSencond());
			pstmt.setInt(6, score.getThird());
			pstmt.setInt(7, score.getForth());
			pstmt.setInt(8, score.getFifth());
			pstmt.execute();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			DBDao.closeConnection(conn);
			DBDao.closePreparedStatement(pstmt);
		}
	}
	
	/**
	 * 按认证编号查询查询所有人的成绩
	 * @return
	 */
	public List<ScoreInfo> selectScoreByNo(int no) {
		List<ScoreInfo> list = new ArrayList<ScoreInfo>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		ScoreInfo info = null;
		try {
			conn = DBDao.getConnection();
			sql = "select M_name, S_memberNo, S_all, S_first, S_second, S_third, S_forth, S_fifth, C_name "
					+ "from Score as a left join Member as b on a.S_memberNo=b.M_memberNo left join Certification as c on a.S_certNo=c.C_no "
					+ "where S_certNo=?;";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				info = new ScoreInfo();
				info.setMemberName(rs.getString(1));
				info.setMemberNo(rs.getString(2));
				info.setAll(rs.getInt(3));
				info.setFirst(rs.getInt(4));
				info.setSencond(rs.getInt(5));
				info.setThird(rs.getInt(6));
				info.setForth(rs.getInt(7));
				info.setFifth(rs.getInt(8));
				list.add(info);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBDao.closeConnection(conn);
			DBDao.closePreparedStatement(pstmt);
			DBDao.closeResultSet(rs);
		}
		
		return list;
	}
	
	/**
	 * 按会员号查询查询所有认证的成绩
	 * @return
	 */
	public List<ScoreInfo> selectScoreByMemberNo(String memberNo) {
		List<ScoreInfo> list = new ArrayList<ScoreInfo>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		ScoreInfo info = null;
		try {
			conn = DBDao.getConnection();
			sql = "select M_name, S_memberNo, S_all, S_first, S_second, S_third, S_forth, S_fifth, C_name "
					+ "from Score, Member, Certification "
					+ "where S_memberNo=M_memberNo and S_certNo=C_no and S_memberNo=?;";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberNo);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				info = new ScoreInfo();
				info.setMemberName(rs.getString(1));
				info.setMemberNo(rs.getString(2));
				info.setAll(rs.getInt(3));
				info.setFirst(rs.getInt(4));
				info.setSencond(rs.getInt(5));
				info.setThird(rs.getInt(6));
				info.setForth(rs.getInt(7));
				info.setFifth(rs.getInt(8));
				info.setCertName(rs.getString(9));
				list.add(info);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBDao.closeConnection(conn);
			DBDao.closePreparedStatement(pstmt);
			DBDao.closeResultSet(rs);
		}
		
		return list;
	}

	/**
	 * 查询成绩
	 * @param certNo
	 * @param low
	 * @param high
	 * @return
	 */
	public List<ScoreInfo> queryScore(int certNo, int low, int high) {
		List<ScoreInfo> list = new ArrayList<ScoreInfo>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		ScoreInfo info = null;
		try {
			conn = DBDao.getConnection();
			if(certNo != 0) {
				sql = "SELECT M_name, S_memberNo, S_all, S_first, S_second, S_third, S_forth, S_fifth, C_name " +
						"from Score, Member, Certification " +
						"where S_memberNo=M_memberNo " +
						"      AND S_certNo=C_no " +
						"      AND S_certNo=? " +
						"      AND S_all BETWEEN ? AND ?;";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, certNo);
				pstmt.setInt(2, low);
				pstmt.setInt(3, high);
			} else {
				sql = "SELECT M_name, S_memberNo, S_all, S_first, S_second, S_third, S_forth, S_fifth, C_name " +
						"FROM Score, Member, Certification " +
						"WHERE S_memberNo=M_memberNo " +
						"      AND S_certNo=C_no " +
						"      AND S_all BETWEEN ? AND ?;";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, low);
				pstmt.setInt(2, high);
			}
			System.out.println(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				info = new ScoreInfo();
				info.setMemberName(rs.getString(1));
				info.setMemberNo(rs.getString(2));
				info.setAll(rs.getInt(3));
				info.setFirst(rs.getInt(4));
				info.setSencond(rs.getInt(5));
				info.setThird(rs.getInt(6));
				info.setForth(rs.getInt(7));
				info.setFifth(rs.getInt(8));
				info.setCertName(rs.getString(9));
				list.add(info);
			}
			System.out.println(list.size());
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBDao.closeConnection(conn);
			DBDao.closePreparedStatement(pstmt);
			DBDao.closeResultSet(rs);
		}

		return list;
	}
	
	// 查询加分了的人
	public void selectAddSocre() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		try {
			conn = DBDao.getConnection();
			sql = "select M_memberNo, M_name, M_stuNo, M_addScore "
					+ "from Member "
					+ "where M_addScore>0;";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBDao.closeConnection(conn);
			DBDao.closePreparedStatement(pstmt);
			DBDao.closeResultSet(rs);
		}
	}

	/**
	 * 获取认证名集合
	 * @return
	 */
	public ArrayList<Certification> getCertSet() {
		ArrayList<Certification> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		try {
			conn = DBDao.getConnection();
			sql = "SELECT  C_no, C_name from Certification;";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Certification cert = new Certification();
				cert.setNo(rs.getInt(1));
				cert.setName(rs.getString(2));
				list.add(cert);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBDao.closeConnection(conn);
			DBDao.closePreparedStatement(pstmt);
			DBDao.closeResultSet(rs);
		}

		return list;
	}
	
	
	public static void main(String[] args) {
//		List<ScoreInfo> list = (new CSPDao()).selectScoreByMemberNo("65535G");
		List<ScoreInfo> list = (new CSPDao()).selectScoreByNo(11);
		System.out.println(list.size());
		for(int i=0; i<list.size(); i++) {
			System.out.println(list.get(i));
		}
		
	}
	
}
