package com.dalhousie;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.ArrayList;

public class Mapper {
	ArrayList<String> mapper = new ArrayList<String>();

	public void Map(String[] keywords) throws IOException {
		for (int i = 0; i < keywords.length; i++) {
			String str = "";
			StringBuilder sb = new StringBuilder();
			// Read each file into a string
			BufferedReader buffer = new BufferedReader(new java.io.FileReader(keywords[i] + ".txt"));
			while ((str = buffer.readLine()) != null) {
				sb.append(str);
			}
			String[] arr = sb.toString().split(" ");
			for (int j = 0; j < arr.length; j++) {
				for (int k = 0; k < keywords.length; k++) {
					if (arr[j].contains(keywords[k])) {
						mapper.add(keywords[k]);
					}
				}
			}
			sb.setLength(0);
		}
		System.out.println(mapper);
		new Reducer().reduce(mapper, keywords);
	}
}