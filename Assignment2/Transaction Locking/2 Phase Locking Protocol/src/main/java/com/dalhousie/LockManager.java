package com.dalhousie;

import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

public class LockManager {

	static final String DB_URL_LOCAL = "jdbc:mysql://localhost:3306/uni";
	static final String USER_lOCAL = "root";
	static final String PASS_lOCAL = ""; //removed code during commit
	static DBQuery db = new DBQuery();

	public void acquireLocks(MyTransaction t) {
		if (t.getTransactionName() == "T2") {
			try {
				Thread.sleep(100);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		Connection conn = db.getDBConnection(DB_URL_LOCAL, USER_lOCAL, PASS_lOCAL);
		HashMap<String, String> tablesToLock = new HashMap<String, String>();
		tablesToLock = t.getTransLockTables();
		System.out.println("Requesting table locks " + t.getTransactionName());
		try {
			System.out.println(t.getTransactionName() + " acquired connection id = " + db.displayConnectionID(conn));
			for (Map.Entry<String, String> map : tablesToLock.entrySet()) {
				String tableName = map.getKey();
				String lockType = map.getValue();
				if ("READ".equalsIgnoreCase(lockType)) {
					String lockQuery = db.getReadLockQuery(tableName);
					db.execute(conn, lockQuery);
					System.out.println("READ Lock granted to " + t.getTransactionName() + " on table " + tableName);
				} else {
					String lockQuery = db.getWriteLockQuery(tableName);
					db.execute(conn, lockQuery);
					System.out.println("WRITE Lock granted to " + t.getTransactionName() + " on table " + tableName);
				}
			}
			if (t.operation(conn)) {
				System.out.println("Successful execution of :" + t.getTransactionName());
			}
		} catch (Exception e) {
			if (conn != null) {
				db.rollback(conn);
			}
		} finally {
			db.release(conn);
			db.closeConnection(conn);
		}
	}
}