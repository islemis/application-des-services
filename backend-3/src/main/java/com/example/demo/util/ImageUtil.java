package com.example.demo.util;
import java.io.ByteArrayOutputStream;
import java.util.Base64;
import java.util.zip.Deflater;
import java.util.zip.Inflater;

public class ImageUtil {

	public class Base64Encoder {
	    public static void main(String[] args) {
	        String secret = "islem1234560OLKnvbvufjeeeeeeeee";
	        String base64Secret = Base64.getEncoder().encodeToString(secret.getBytes());

	        System.out.println("Base64-encoded secret: " + base64Secret);
	    }}
	
	    public static byte[] compressImage(byte[] data) {

	        Deflater deflater = new Deflater();
	        deflater.setLevel(Deflater.BEST_COMPRESSION);
	        deflater.setInput(data);
	        deflater.finish();

	        ByteArrayOutputStream outputStream = new ByteArrayOutputStream(data.length);
	        byte[] tmp = new byte[4*1024];
	        while (!deflater.finished()) {
	            int size = deflater.deflate(tmp);
	            outputStream.write(tmp, 0, size);
	        }
	        try {
	            outputStream.close();
	        } catch (Exception e) {
	        }
	        return outputStream.toByteArray();
	    }

	    public static byte[] decompressImage(byte[] data) {
	        Inflater inflater = new Inflater();
	        inflater.setInput(data);
	        ByteArrayOutputStream outputStream = new ByteArrayOutputStream(data.length);
	        byte[] tmp = new byte[4*1024];
	        try {
	            while (!inflater.finished()) {
	                int count = inflater.inflate(tmp);
	                outputStream.write(tmp, 0, count);
	            }
	            outputStream.close();
	        } catch (Exception exception) {
	        }
	        return outputStream.toByteArray();
	    
	}
}
