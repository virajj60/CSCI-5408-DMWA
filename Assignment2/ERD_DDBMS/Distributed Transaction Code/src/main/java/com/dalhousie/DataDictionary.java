package com.dalhousie;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.HashMap;


public class DataDictionary {
   
	HashMap<String, String> dataDictionary = new HashMap<String, String>();
	
	public String loadDataDictionary(String filePath) {
		StringBuilder sb = new StringBuilder();
		try {		 
			BufferedReader buffer = new BufferedReader(new java.io.FileReader(filePath));
            String str;
            while((str = buffer.readLine()) != null ) {
            	String[] splitString = str.split(",",2);
            	dataDictionary.put(splitString[0], splitString[1]);
            }
            System.out.println(dataDictionary);
       }catch(IOException e){
    	   e.printStackTrace();
       }
		return sb.toString();
	}
}