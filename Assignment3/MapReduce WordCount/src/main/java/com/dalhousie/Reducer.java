package com.dalhousie;

import java.util.ArrayList;
import java.util.HashMap;

public class Reducer {
	
   HashMap<String, Integer> reducer = new HashMap<String, Integer>();
   public void reduce(ArrayList<String> mapper,String[] keywords) {
	   
	   for(int i=0;i<keywords.length;i++) {
		   int counter=0;
		   for(int j=0;j<mapper.size();j++) {
			   if(mapper.get(j).equals(keywords[i])) {
				   counter++;
			   }
		   }
		   reducer.put(keywords[i],counter);
	   }
	   System.out.println(reducer);
   }
}
