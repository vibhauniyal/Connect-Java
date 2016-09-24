# Connect-Java
CSC  Digital Seva Connect Integration Kit  for Java

Instructions:
* Reset your password by using the link you have recieved via email.

* Supported JRE platforms are JRE 1.7+. Please also make sure that Java installation has unlimited strength jurisdiction policy of Java Cryptography Extension (JCE) installed.

* Login to Merchant Center Portal: "portal.csccloud.in" and follow the below steps:

      Generate Connect Config. File
      
        1.Click on “CSC Connect”.
        
        2.Provide the Application Name, Call Back Url and upload the application logo and click on save button to add the application.
        
        3.Generate your Client ID by clicking on "Generate Client Id" button.
        
        4.Generate your Client Secret and Client Token.
        
        5.Click on save button to generate your Connect Config. File.
        
        6.Download the Connect Config. File.
        

Use these configuration file into your code.

The illustrated code sample below provides the understanding of using the java integration kit.

Step 1	Create a URL as in the Sample login.jsp


    String state = "" + (int)(Math.random() * 1000000);
      session.setAttribute("state", state);
      String connect_url =
          authorizationAddress +
          "?state=" +
           state +
          "&response_type=code&client_id=" +
           clientId +
          "&redirect_uri=" +
           redirectUri;
    %>
    <a href="<%= connect_url %>">Login with Digital Seva Connect</a>          

Step 2	Handle response to get user data as in the sample login_success.jsp 

    <%
                String resp  = request.getQueryString();
                String state_saved = (String)session.getAttribute("state");
                String state_req = request.getParameter("state");
                if(state_saved == null || state_req == null || !state_saved.equals(state_req) ){
                    resp = "State mismatched! Please try to login again.";
                } else {
                    String code = request.getParameter("code");
                    if(code == null || code.length() <= 0){
                        resp = "Error!! Code not received from server!";
                    } else {
                        //jsp post a request ..
                        String url = tokenAddress;
                        String parameters = 
    "code=" + code + "&" +
    "redirect_uri=" + redirectUri + "&" +
    "grant_type=authorization_code&" +
    "client_id=" + clientId + "&" +
    "client_secret=ee0f2b2fd3b57e1ddc0e71c24eafdd57";
                        try{
                            String ret = sendPost(url, parameters);
                            JSONObject tResp = new JSONObject(ret);
                            String token = tResp.getString("access_token");
    
                            parameters = "access_token=" + token;
                            resp = sendPost(resourceAddress, parameters);
    
                            JSONObject obj = new JSONObject(resp);
                            JSONObject user = obj.getJSONObject("User");
    
                            Map<String, Object> mVals = user.toMap();
                            resp = "\n<br>----User Details ----";
                            for (Map.Entry<String, Object> entry : mVals.entrySet()) {
                                System.out.println("Key = " + entry.getKey() + ", Value = " + entry.getValue());
                                resp += "\n" + entry.getKey() + " : " + entry.getValue();
                            }
                            session.setAttribute("username", mVals.get("username"));
                        }catch(Exception ec){out.write(ec.toString());}
                    }
                }
    
            %>

Step 3	Create a user session with data as mentioned in Step 2 login_success.jsp

    session.setAttribute("username", mVals.get("username")); 


