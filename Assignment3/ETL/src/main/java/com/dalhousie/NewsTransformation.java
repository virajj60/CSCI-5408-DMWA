package com.dalhousie;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.IOException;

import org.bson.Document;
import org.json.JSONArray;
import org.json.JSONObject;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;

public class NewsTransformation {

	String DB_URL = "mongodb+srv://<USER>:<PASSWORD>@cluster0.<NAME>.mongodb.net/?retryWrites=true&w=majority";
	MongoClient mongoDB = MongoClients.create(DB_URL);

	public void filterNewsAndPersist(String[] keywords) throws FileNotFoundException {
		String filteredArticles = "";
		MongoDatabase assignment3 = mongoDB.getDatabase("assignment3");
		
		for (int i = 0; i < keywords.length; i++) {
			String str = "";
			StringBuilder sb = new StringBuilder();
			// Read each file into a string
			BufferedReader buffer = new BufferedReader(new java.io.FileReader(
					"C:\\Users\\viraj\\OneDrive\\Desktop\\Fall'22 Study Materials\\CSCI5408\\" + keywords[i] + ".txt"));
			try {
				while ((str = buffer.readLine()) != null) {
					sb.append(str);
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			// Data of each file is converted to a JSONObject to get the "articles" key
			JSONObject obj = new JSONObject(sb.toString());
			JSONArray articles = obj.getJSONArray("articles");
			
			for (int j = 0; j < articles.length(); j++) {
				filteredArticles = articles.get(j).toString();
				// Remove the Url and UrlToImage links
				filteredArticles = filteredArticles.replaceAll("(\"url\":(\"http.*?\"|null|\"null\"|\"\"),)", " ");
				filteredArticles = filteredArticles.replaceAll("(\"urlToImage\":(\"http.*?\"|null|\"null\"|\"\"),)",
						" ");

				// Replace the null values with an empty string
				filteredArticles = filteredArticles.replace("null", "\"\"");

				// Remove carriage return and new line special characters
				filteredArticles = filteredArticles.replaceAll("\\\\r\\\\n", " ");

				// Remove HTML tags from the content
				filteredArticles = filteredArticles.replaceAll("<.*?>", "");

				// Remove \\u unicode values
				filteredArticles = filteredArticles.replaceAll("\\W[u]\\d+", "");

				// Remove [+ characters data]
				filteredArticles = filteredArticles.replaceAll("\\[\\W\\d+\\s+\\w+\\]", "");
				
				Document filteredArticleDoc = Document.parse(filteredArticles);
				//Insert document into mongoDB
				MongoCollection<Document> collection = assignment3.getCollection(keywords[i]);
				collection.insertOne(filteredArticleDoc);
		 	}		
			sb.setLength(0);
  		}
	}
}