
function submitAjax() 
{
   var xhr;
   try {  xhr = new ActiveXObject('Msxml2.XMLHTTP');   }
   catch (e)
   {
        try {   xhr = new ActiveXObject('Microsoft.XMLHTTP');    }
        catch (e2)
        {
          try {  xhr = new XMLHttpRequest();     }
          catch (e3) {  xhr = false;   }
        }
     }

    xhr.onreadystatechange  = function()
    {
         if(xhr.readyState  == 4)
         {
              if(xhr.status  == 200)
              {
                  var o = document.getElementById( "output" );
                  o.innerHTML = xhr.responseText;
              }
              else
              {
                  var o = document.getElementById( "output" );
                  o.innerHTML = "Failed HTTP code " + xhr.status + " " +  xhr.responseText;
              }
         }
    };

    data = 'ajax=1';
    data = data + '&id=' + escape(document.forms[0].id.value );
    data = data + '&captcha=' + escape( document.forms[0].captcha.value );
    data = data + '&id=' + escape(document.forms[0].id.value );
    data = data + '&captcha=' + escape( document.forms[0].captcha.value );
    data = data + '&name=' + escape( document.forms[0].name.value );
    data = data + '&mail=' + escape( document.forms[0].mail.value );
    data = data + '&body=' + escape( document.forms[0].body.value );
    xhr.open("POST", "/cgi-bin/comments.cgi", true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhr.send(data);
}
