package com.dalhousie;

import java.sql.*;


public class Main {

	static final String DB_URL_LOCAL = "jdbc:mysql://localhost:3306/a2_distvrxxxxxx";
	static final String USER_lOCAL = "<USER>";
	static final String PASS_lOCAL = "<PASSWORD>";

	static final String DB_URL_REMOTE = "jdbc:mysql://xx.xxx.xxx.xxx/a2_distvrxxxxxx";
	static final String USER_REMOTE = "<USER>";
	static final String PASS_REMOTE = "<PASSWORD>";

	public static void main(String[] args) {
		DataDictionary dataDict = new DataDictionary();
		DBQuery db = new DBQuery();
		dataDict.loadDataDictionary("DataDictionary.txt");
		Connection conn = db.getDBConnection(DB_URL_LOCAL, USER_lOCAL, PASS_lOCAL);
		Connection conGCP = db.getDBConnection(DB_URL_REMOTE, USER_REMOTE, PASS_REMOTE);
		try {
			db.setProfiling(conn);
			db.setProfiling(conGCP);
			db.setAutocommitFalse(conn);
			db.setAutocommitFalse(conGCP);
			db.startTransaction(conn);
			db.startTransaction(conGCP);
			String equipIdQuery = db.getEquipmentIdSQL("camp");
			if (dataDict.dataDictionary.get("equipments").equalsIgnoreCase("local")) {
				db.execute(conn, equipIdQuery);
			} else {
				db.execute(conGCP, equipIdQuery);
			}
			String parkIdQuery = db.getParkIdSQL("Crystal Crescent Beach");
			if (dataDict.dataDictionary.get("parks").equalsIgnoreCase("local")) {
				db.execute(conn, parkIdQuery);
			} else {
				db.execute(conGCP, parkIdQuery);
			}
			String createReservQuery = db.createReservationInsert("Mike", "20220901", "20220907", 7, "online", 3.5, 1);
			if (dataDict.dataDictionary.get("reservation").equalsIgnoreCase("local")) {
				db.executeUpdate(conn, createReservQuery);
			} else {
				db.executeUpdate(conGCP, createReservQuery);
			}
			String updQtyQuery = db.getUpdateAvlbQtySQL(1);
			if (dataDict.dataDictionary.get("equipments").equalsIgnoreCase("local")) {
				db.executeUpdate(conn, updQtyQuery);
			} else {
				db.executeUpdate(conGCP, updQtyQuery);
			}
			String egiftInsertQuery = db.purchaseGiftCardInsert(6158, "tony", "tony@bbc.com", 25, "viraj", "Congrats",
					1);
			if (dataDict.dataDictionary.get("egiftcard").equalsIgnoreCase("local")) {
				db.executeUpdate(conn, egiftInsertQuery);
			} else {
				db.executeUpdate(conGCP, egiftInsertQuery);
			}
			db.commit(conn);
			db.commit(conGCP);
			db.showProfiles(conn);
			db.showProfiles(conGCP);
		} catch (SQLException e) {
			System.out.println("Rollback");
			db.rollback(conn);
			db.rollback(conGCP);
			e.printStackTrace();
		} finally {
			System.out.println("Close Connections");
			db.closeConnection(conn);
			db.closeConnection(conGCP);
		}
	}
}