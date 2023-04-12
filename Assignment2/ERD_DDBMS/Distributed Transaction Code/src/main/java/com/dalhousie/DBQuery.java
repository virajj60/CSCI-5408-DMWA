package com.dalhousie;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBQuery {

	public void setAutocommitFalse(Connection conn) throws SQLException {
		conn.setAutoCommit(false);

	}

	public void startTransaction(Connection conn) {
		Statement stmt;
		try {
			stmt = conn.createStatement();
			stmt.execute("START TRANSACTION;");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void commit(Connection conn) throws SQLException {
		conn.commit();
	}

	public void rollback(Connection conn) {
		try {
			conn.rollback();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void setProfiling(Connection conn) throws SQLException {
		Statement stmt = conn.createStatement();
		stmt.execute("SET PROFILING =0;");
		stmt.execute("SET profiling_history_size=0;");
		stmt.execute("SET profiling_history_size=100;");
		stmt.execute("SET PROFILING =1;");
	}

	public void showProfiles(Connection conn) throws SQLException {
		Statement stmt = conn.createStatement();
		ResultSet res = stmt.executeQuery("SHOW PROFILES;");
		System.out.println();
		while (res.next()) {
			System.out.printf("     Statement: %s%nExecution time: %f seconds.%n", res.getString("Query"),
					res.getDouble("Duration"));
		}
	}

	public String getEquipmentIdSQL(String equipName) {
		return "SELECT @equipId:=equipID FROM equipments WHERE equipName='" + equipName + "';";
	}

	public String getParkIdSQL(String parkName) {
		return "SELECT @parkID:=parkID FROM parks WHERE parkName ='" + parkName + "';";
	}

	public String createReservationInsert(String reservName, String arrDate, String depDate, int paxCount,
			String reservType, double totAmt, int userId) {
		return "INSERT INTO reservation (reservationName,arr_date,dep_date,countOfPax,reservType,equipID,totalAmt,parkID,userID) "
				+ "VALUES ('" + reservName + "','" + arrDate + "','" + depDate + "'," + paxCount
				+ ",'" + reservType + "',@equipId," + totAmt + "," + "@parkID," + userId + ");";
	}

	public String getUpdateAvlbQtySQL(int qty) {
		return "UPDATE equipments SET availableQty = availableQty -" + qty + " WHERE equipID = @equipId;";
	}

	public String purchaseGiftCardInsert(int giftCardId, String recpName, String recpEmail, double amt,
			String sendersName, String msg, int userId) {
		return "INSERT INTO egiftcard VALUES (" + giftCardId + ",'" + recpName + "','" + recpEmail + "'," + amt + ",'"
				+ sendersName + "','" + msg + "'," + userId + ");";
	}

	public boolean executeUpdate(Connection conn, String insertQuery) throws SQLException {
		Statement stmt = conn.createStatement();
		if (stmt.executeUpdate(insertQuery) > 0) {
			return true;
		} else {
			return false;
		}
	}

	public void execute(Connection conn, String query) throws SQLException {
		Statement stmt;
		stmt = conn.createStatement();
		stmt.execute(query);
	}

	public Connection getDBConnection(String dbURL, String user, String password) {
		Connection conn = null;
		try {
			conn = DriverManager.getConnection(dbURL, user, password);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return conn;
	}

	public void closeConnection(Connection conn) {
		try {
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}