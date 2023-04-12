package com.dalhousie;

import java.io.FileWriter;
import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

public class NewsExtraction {
	public static void main(String[] args) throws IOException, InterruptedException {
		String keywords[] = { "Canada", "Halifax", "hockey", "hurricane", "electricity", "house", "inflation" };

		// for each keyword search 'pageSize' number of articles and write it
		// keyword.txt file
		for (int i = 0; i < keywords.length; i++) {
			HttpClient httpClient = HttpClient.newHttpClient();
			HttpRequest httpReq = HttpRequest.newBuilder().uri(URI.create("https://newsapi.org/v2/everything?q="
					+ keywords[i] + "&pageSize=100&apiKey=401c196e52774d698cdbcec11cd91c1e")).build();
			HttpResponse<String> resp = httpClient.send(httpReq, HttpResponse.BodyHandlers.ofString());
			if (resp.statusCode() == 200) {
				FileWriter fw = new FileWriter(
						"C:\\Users\\viraj\\OneDrive\\Desktop\\Fall'22 Study Materials\\CSCI5408\\" + keywords[i]
								+ ".txt");
				fw.write(resp.body());
				fw.close();
			}
		}
		//new NewsTransformation().filterNewsAndPersist(keywords);
	}
}