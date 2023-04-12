package com.dalhousie;

import java.sql.Connection;
import java.util.HashMap;

public interface MyTransaction {
     public boolean operation(Connection conn);
     public String getTransactionName();
     public HashMap<String, String> getTransLockTables();
}
