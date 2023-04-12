package com.dalhousie;


public class Main extends Thread {
	
	public static void main(String[] args) {
 
		TransactionT1 t1 = new TransactionT1();
		TransactionT2 t2 = new TransactionT2(); 
		t1.start();
		t2.start();
		t1.setName("T1");
		t2.setName("T2"); 
	}
}
