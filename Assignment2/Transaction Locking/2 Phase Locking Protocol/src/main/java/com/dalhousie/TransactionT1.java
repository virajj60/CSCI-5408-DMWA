package com.dalhousie;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;

public class TransactionT1 extends Thread implements MyTransaction {

	public HashMap<String, String> transLockTables = new HashMap<String, String>();

	public TransactionT1() {
		transLockTables.put("classroom", "WRITE");
		transLockTables.put("course", "WRITE");
		transLockTables.put("bookborrowed", "WRITE");
		transLockTables.put("book", "WRITE");
		transLockTables.put("dalcard", "WRITE");
	}

	public HashMap<String, String> getTransLockTables() {
		return transLockTables;
	}

	@Override
	public void run() {
		System.out.println("In Run: " + this.getName());
		LockManager lockManager = new LockManager();
		lockManager.acquireLocks(this);
	}

	@Override
	public boolean operation(Connection conn) {
		System.out.println("In Operations: " + this.getName());
		DBQuery db = new DBQuery();

		db.setAutocommitFalse(conn);
		try {
			db.startTransaction(conn);
			db.execute(conn, db.getClassIdQuery("Tupper Theater"));
			db.executeUpdate(conn, db.getUpdateCourseClassQuery(5408));
			db.executeUpdate(conn, db.getInsertBorrowedBookQuery(101, 924759, 1));
			db.execute(conn, db.getBookPriceQuery(101));
			db.executeUpdate(conn, db.getUpdateBalanceQuery(924759));
			db.commit(conn);
			return true;
		} catch (SQLException e) {
			db.rollback(conn);
			e.printStackTrace();
			return false;
		}
	}

	public String getTransactionName() {
		return this.getName();
	}
}
