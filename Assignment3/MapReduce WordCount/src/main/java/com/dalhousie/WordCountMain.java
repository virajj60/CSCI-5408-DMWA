package com.dalhousie;

import java.io.FileNotFoundException;
import java.io.IOException;

/**
 * Hello world!
 *
 */
public class WordCountMain 
{
	static String keywords[] = { "Canada", "Halifax", "hockey", "hurricane", "electricity", "house", "inflation" };
    public static void main( String[] args ) throws IOException, FileNotFoundException
    {
        new Mapper().Map(keywords);
    }
}
