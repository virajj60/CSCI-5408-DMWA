package com.dalhousie;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBQuery {

	public void setAutocommitFalse(Connection conn) {
		try {
			conn.setAutoCommit(false);
		} catch (SQLException e) {
			e.printStackTrace();
		}
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

	public String getWriteLockQuery(String tableName) {
		return "LOCK TABLES " + tableName + " WRITE";
	}

	public String getReadLockQuery(String tableName) {
		return "LOCK TABLES " + tableName + " READ";
	}

	public void release(Connection conn) {
		try {
			Statement stmt = conn.createStatement();
			stmt.execute("UNLOCK TABLES");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public String getClassIdQuery(String className) {
		return "SELECT @class_Id:=class_Id FROM classroom WHERE classroom_name ='" + className + "';";
	}

	public String getUpdateCourseClassQuery(int courseId) {
		return "UPDATE course SET class_Id= @class_Id WHERE course_id=" + courseId + ";";
	}
	
	public String getDeleteClassroomQuery(String className) {
		return "DELETE FROM classroom WHERE classroom_name ='" + className + "';";
	}

	public String getUpdateBookPriceQuery(int bookId, int price) {
		return "UPDATE book SET book_price=" + price + " WHERE book_Id= " + bookId +";";
	}
	public String getInsertBorrowedBookQuery(int bookId, int studId, int libId) {
		return "INSERT INTO bookborrowed VALUES (" + bookId + "," + studId + "," + libId + ");";
	}

	public String getBookPriceQuery(int bookId) {
		return "SELECT @book_price:=book_price from book WHERE book_Id= " + bookId + ";";
	}

	public String getUpdateBalanceQuery(int studId) {
		return "UPDATE dalcard SET card_balance=card_balance - @book_price , " + "card_transaction =\"Book Purchase\", "
				+ "trans_amount=@book_price " + "WHERE Student_student_id=" + studId + ";";
	}

	public void setProfiling(Connection conn) throws SQLException {
		Statement stmt = conn.createStatement();
		stmt.execute("SET PROFILING =1");
	}

	public void showProfiles(Connection conn) throws SQLException {
		Statement stmt = conn.createStatement();
		ResultSet res = stmt.executeQuery("SHOW PROFILE");
		System.out.println();
		while (res.next()) {
			System.out.printf("     Statement: %s%nExecution time: %f seconds.%n", res.getString("Query"),
					res.getDouble("Duration"));
		}
	}

	public void execute(Connection conn, String query) throws SQLException {
		Statement stmt;
		stmt = conn.createStatement();
		stmt.execute(query);
	}

	public boolean executeUpdate(Connection conn, String insertQuery) throws SQLException {
		Statement stmt;
		stmt = conn.createStatement();
		if (stmt.executeUpdate(insertQuery) > 0) {
			return true;
		}
		return false;
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
	
	public int displayConnectionID(Connection conn) throws SQLException{
		int connId =0;
		Statement stmt = conn.createStatement();
		ResultSet res = stmt.executeQuery("SELECT connection_id()");
		while (res.next()) {
			connId = res.getInt(1);
		}
		return connId;
	}
}
