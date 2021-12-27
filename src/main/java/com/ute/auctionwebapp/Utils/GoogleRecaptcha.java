package com.ute.auctionwebapp.Utils;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import javax.net.ssl.HttpsURLConnection;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;

/**
 * Recaptcha V3 - Java Example
 */
public class GoogleRecaptcha {

    private static final String RECAPTCHA_SERVICE_URL = "https://www.google.com/recaptcha/api/siteverify";
    private static final String SECRET_KEY = "6LfbJdAdAAAAAP9rKpJcM8BB9SEBEL2yJ5CeTNKM";

    /**
     * checks if a user is valid
     * @param clientRecaptchaResponse
     * @return true if human, false if bot
     * @throws IOException
     * @throws ParseException
     */
    public static boolean isValid(String clientRecaptchaResponse) throws IOException, ParseException {
        if (clientRecaptchaResponse == null || "".equals(clientRecaptchaResponse)) {
            return false;
        }

        URL obj = new URL(RECAPTCHA_SERVICE_URL);
        HttpsURLConnection con = (HttpsURLConnection) obj.openConnection();

        con.setRequestMethod("POST");
        con.setRequestProperty("Accept-Language", "en-US,en;q=0.5");

        //add client result as post parameter
        String postParams =
                "secret=" + SECRET_KEY +
                        "&response=" + clientRecaptchaResponse;

        // send post request to google recaptcha server
        con.setDoOutput(true);
        DataOutputStream wr = new DataOutputStream(con.getOutputStream());
        wr.writeBytes(postParams);
        wr.flush();
        wr.close();

        int responseCode = con.getResponseCode();

        System.out.println("Post parameters: " + postParams);
        System.out.println("Response Code: " + responseCode);

        BufferedReader in = new BufferedReader(new InputStreamReader(
                con.getInputStream()));
        String inputLine;
        StringBuffer response = new StringBuffer();

        while ((inputLine = in.readLine()) != null) {
            response.append(inputLine);
        }
        in.close();

        System.out.println(response.toString());

        //Parse JSON-response
        JSONParser parser = new JSONParser();
        JSONObject json = (JSONObject) parser.parse(response.toString());


        Boolean success = (Boolean) json.get("success");
        Double score = (Double) json.get("score");

        System.out.println("success : " + success);
        System.out.println("score : " + score);

        //result should be sucessfull and spam score above 0.5
        return (success && score >= 0.5);
    }

    public synchronized boolean isCaptchaValid(String secretKey, String response) {
        try {
            String url = "https://www.google.com/recaptcha/api/siteverify",
                    params = "secret=" + secretKey + "&response=" + response;

            HttpURLConnection http = (HttpURLConnection) new URL(url).openConnection();
            http.setDoOutput(true);
            http.setRequestMethod("POST");
            http.setRequestProperty("Content-Type",
                    "application/x-www-form-urlencoded; charset=UTF-8");
            OutputStream out = http.getOutputStream();
            out.write(params.getBytes("UTF-8"));
            out.flush();
            out.close();

            InputStream res = http.getInputStream();
            BufferedReader rd = new BufferedReader(new InputStreamReader(res, "UTF-8"));

            StringBuilder sb = new StringBuilder();
            int cp;
            while ((cp = rd.read()) != -1) {
                sb.append((char) cp);
            }
            JSONObject json = new JSONObject(sb.toString());
            res.close();

            return json.getBoolean("success");
        } catch (Exception e) {
            //e.printStackTrace();
        }
        return false;
    }
}