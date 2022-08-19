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
          NativeDialog.confirm("Error", "Ha ocurrido un error en la solicitud al servidor: \n\n\nServidor en mantenimiento.\n\n\nPruebe de nuevo más tarde.", function(){}, false)
          return {
            'responseObj' : '',
            'result': false
          }
      }

       if (responseObj === "" || responseObj.hasOwnProperty("statusDescription") || !responseObj.hasOwnProperty("userId") || !responseObj.hasOwnProperty("token")) {
           // End-server error, alert user.
           NativeDialog.confirm("Error", "Ha ocurrido un error en la solicitud al servidor: \n\n\n" + (responseObj.hasOwnProperty("statusDescription") ? responseObj["statusDescription"] : "ErrorNotIncluded") + "\n\n\nSi tras unas horas le sigue ocurriendo, envíe un mail a\nsoporte@pranksterapp.com", function(){}, false)
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
