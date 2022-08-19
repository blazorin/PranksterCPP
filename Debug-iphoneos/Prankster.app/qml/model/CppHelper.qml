import QtQuick 2.0
import Felgo 3.0

Item {

    // Auth: v1/account/auth

   function httpRequest(relativeUri, methodInt, jsonPayload) {
       let response = bearerToken === "" ? httpClient.webRequest(serverUrl + relativeUri, methodInt, jsonPayload) : httpClient.webRequest(serverUrl + relativeUri, methodInt, jsonPayload, bearerToken)
       let responseObj = ""


      try {
          responseObj = JSON.parse(response)
      } catch (e) {
          NativeDialog.confirm("Login error", "An error ocurred while fetching our server: \n\n\nServer on maintenance.", function(){}, false)
          return {
            'responseObj' : '',
            'result': false
          }
      }

       if (responseObj === "" || responseObj.hasOwnProperty("statusDescription") || !responseObj.hasOwnProperty("userId") || !responseObj.hasOwnProperty("token")) {
           // End-server error, alert user.
           NativeDialog.confirm("Login error", "An error ocurred while fetching our server: \n\n\n" + (responseObj.hasOwnProperty("statusDescription") ? responseObj["statusDescription"] : "ErrorNotIncluded"), function(){}, false)
           return {
             'responseObj' : '',
             'result': false
           }
      }

       return {
         'responseObj' : responseObj,
         'result': true
       }
   }
}
