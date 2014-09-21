<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>airmusic</title>
<meta content="text/html; charset=utf-8" http-equiv="content-type">
<meta content="width=device-width, maximum-scale=1.0" name="viewport">
<link href="a.css" type="text/css" rel="stylesheet">
<meta content="”no-cache”" http-equiv="”pragma”">
<meta content="”-1″" http-equiv="”expires”">
<script src="dtree/jquery-1.11.0.min.js" type="text/javascript"></script>
<script src="dtree/jquery.xml2json.js" type="text/javascript"></script>
<script src="dtree/langPrefix.js" language="javascript"></script>
<script src="dtree/tool.js" language="javascript"></script>
<script type="text/javascript" language="JavaScript">
        var theSSID = {};
        //
        function bindData(data) {
            if (data == undefined) return;
            if (data.Return.status != "true") {
                alert(data.Return["#text"] || data.Return.toString());
                return;
            }
            //
            var ssid = theSSID = data.SSID;
            //
            $("#DeviceName").val(ssid.name);
            //
            $("#method0 option").each(function () {
                if ($(this).text() == ssid.encrypt) {
                    $(this).attr("selected", "true");
                }
            });
            //
            onSecurityChanged();
            //
            $("#Password,#Password1").val(ssid.password.replace(/&amp;/g,"&amp;amp;"));
        }


        $(function () {
            //
            langPrefix();
            //
            Loading(message[currentlang].loadingmsg);
            $.get(appendTS(api.apiurl), { data: api.ssid }, function (data) {
                var data = $.xml2json(data);
                bindData(data);
                Loaded();
            });
            //
            document.title = message[currentlang].device;
        });

        function onSecurityChanged() {
            //
            objSecurityMode = $id("method0");
            var MethodText = objSecurityMode.options[objSecurityMode.selectedIndex].text;
            //
            if (MethodText == "WEP" || MethodText == "NONE") {
                $("#divPassword").hide();
                $("#divPassword1").hide();
            } else {
                $("#divPassword").show();
                $("#divPassword1").show();
            }
            //
            if (MethodText == "WEP") {
                //wep 加密
                $('#DivWep').show();
                $('#trLength').show();
                $('#trFormat').show();
            }
            else {
                $('#DivWep').hide();
                $('#trLength').hide();
                $('#trFormat').hide();
            }
            $("#Password").val("");
            $("#Password1").val("");
        }

        function onDone() {
            var postdata = theSSID || {};
            for (var k in postdata) {
                if (k.charAt(0) != "@") {
                    postdata["@" + k] = postdata[k];
                    delete postdata[k];
                }
            }
            var DeviceName = $("#DeviceName").val().trim();
            if (DeviceName == "") {
                alert(message[currentlang].emptyname); 
                return false;
            }
            if (DeviceName.Length()>32) {
                alert(message[currentlang].ssidlengthalert);
                return false;
            }
            //
            objSecurityMode = $id("method0");
            //
            var Password = $("#Password").val().trim();
            var Password1 = $("#Password1").val().trim();
            var MethodText = objSecurityMode.options[objSecurityMode.selectedIndex].text;
            //
            if (MethodText == "WEP") {
                var len = $(":radio[name=encrypt_len]:checked").val();
                var format = $(":radio[name=format]:checked").val();
                //WEP加密方式
                if (Password.length == 5) {
                    document.getElementById("wepKeyLen0").value = "wep64";
                    document.getElementById("length0").value = "1"; //password length=5
                    document.getElementById("format0").value = "1"; //ascii
                }
                else if (Password.length == 10) {
                    document.getElementById("wepKeyLen0").value = "wep64";
                    document.getElementById("length0").value = "1"; //password length=10
                    document.getElementById("format0").value = "2"; //hex
                }
                else if (Password.length == 13) {
                    document.getElementById("wepKeyLen0").value = "wep128";
                    document.getElementById("length0").value = "2"; //password length=13
                    document.getElementById("format0").value = "1"; //ascii
                }
                else if (Password.length == 26) {
                    document.getElementById("wepKeyLen0").value = "wep128";
                    document.getElementById("length0").value = "2"; //password length=26
                    document.getElementById("format0").value = "2"; //hex
                } else {
                    alert("Please enter correct length of password for WEP!");
                    return false;
                }

                if (Password != Password1) {
                    alert(message[currentlang].errorpasswd2);
                    return false;
                }
                //
                postdata["@encrypt_len"] = len;
                postdata["@format"] = format;

            } else if (objSecurityMode.selectedIndex != 0) {
                //WPA、WPA2以及WPA/WPA2混合加密方式的密码需要8位及以上
                if (Password.length<8) {
                    alert(message[currentlang].errorpasswd1);
                    return false;
                }
                if (Password != Password1) {
                    alert(message[currentlang].errorpasswd2);
                    return false;
                }
            }
            if (Password.Length()>32) {
                alert(message[currentlang].passwordlengthalert);
                return false;
            }
            postdata["@name"] = DeviceName;
            postdata["@encrypt"] = MethodText;
            postdata["@password"] = Password.replace(/&amp;/g,"&amp;amp;");
            //if (MethodText == "WPA") 
            postdata["@tkip_aes"] = "aes"; //默认项
            //
            var xml = json2xml({ "setSysInfo": { SSID: postdata} });
            //
            Loading(message[currentlang].savingconfig, 20, function () { Loaded(); alert(message[currentlang].refreshalert); });
            //alert(xml);
            $.ajax({ url: appendTS(api.apiurl + "?data=" + escape(xml)),
                type: "POST",
                data: { "data": xml },
                contentType: "application/x-www-form-urlencoded;",
                success: function (result) {
                    //&lt;?xml version="1.0"?&gt;&lt;setSysInfo&gt;&lt;Return status="true"&gt;&lt;/Return&gt;&lt;/setSysInfo&gt;&lt;Return status="false"&gt;wpa encrypt set error!&lt;/Return&gt;&lt;/setSysInfo&gt;
                    var result = $.xml2json(result);
                    if (result.Return.status != "true") alert(result.Return.toString());
                    //Loading(message[currentlang].savingconfig, result.Return.delay, function () { Loaded(); alert(message[currentlang].refreshalert); });
                }
            });
            //bugcode
            //Loading(message[currentlang].savingconfig, 40, function () { Loaded(); alert(message[currentlang].refreshalert); });
            return false;
        }
		
		
		function submit_Form() {
			var form=$(document).getElementById("form_wi_drive_settings");
			form.submit();
		}
		
		
    </script>
    <style type="text/css">
        table.fixtb tbody td.control &gt; input, table.fixtb tbody td.control &gt; select
        {
            width: 180px;
        }
    </style>
  </head>
  
  
  <body>
    <form action="/goform/SetDeviceName" id="form_wi_drive_settings" name="form_wi_drive_settings">
    <div id="DivContent" class="div_content">
        <div class="div_header">
            <div class="div_container">
                <div class="title_back" style="float: left;">
                    <a lang="back" class="btn_back" href="#">返回</a>
                </div>
                <div lang="setting" class="title_text" style="float: left;">基 本 设 置</div>
                <div class="title_done" style="float: left;">
                    <a lang="done" class="btn_done" onclick="return submit_Form();" href="javascript:;">完成</a></div>
                <div style="clear: both;">
                </div>
            </div>
        </div>
        <div class="div_center">
            <div class="div_container">
                <div class="div_row">
                    <div lang="devicename" class="div_row_text">设备名称:</div>
                    <div class="div_row_control">
                        <input type="text" validate="required,length[_50]" value="<% getCfgGeneral(1, "devicename"); %>" name="DeviceName" id="DeviceName">
                    </div>
                </div>
                <p>
                </p><div class="div_row">
                    <div lang="security" class="div_row_text">加密</div>
                    <div class="div_row_control">
                        <select onchange="onSecurityChanged();" name="method0" id="method0" size="1">
                            <option value="0" selected="selected">NONE</option>
                            <!--<option value="1">WEP</option>-->
                            <option value="2">WPA</option>
                            <option value="4">WPA2</option>
                            <option value="6">WPA/WPA2</option>
                        </select>
                    </div>
                </div>
                <p>
                </p><div style="display:none" id="divPassword" class="div_row">
                    <div lang="passwd" class="div_row_text">密码:</div>
                    <div class="div_row_control">
                        <input type="password" validate="required,length[_50]" value="<% getCfgGeneral(1, "PassWord"); %>" name="Password" id="Password">
                    </div>
                </div>
                <p>
                </p><div style="display:none" id="divPassword1" class="div_row">
                    <div lang="confpasswd" style="line-height:18px;padding-top:4px;" class="div_row_text">确认<br>密码:</div>
                    <div class="div_row_control">
                        <input type="password" validate="required,length[_50]" value="<% getCfgGeneral(1, "PassWord1"); %>" name="Password1" id="Password1">
                    </div>
                </div>
                <p>

            </p></div>
        </div>
        <div class="div_bottom">
        </div>
    </div>
    </form>


<div style="position: absolute; left: 0px; top: 0px; width: 1069px; height: 353px; opacity: 0.3; background-color: rgb(51, 57, 60); z-index: 9999; display: none;" class="boxlayer"></div><div style="position: absolute; height: 80px; background: none repeat scroll 0% 0% rgb(230, 239, 250); border: 4px solid rgb(130, 178, 238); padding: 8px; z-index: 100000; left: 445px; top: 136.5px; display: none;" id="divLoading"><div style="float: left; background: url(&quot;/css/images/loading.gif&quot;) repeat scroll 0% 0% transparent; width: 0px; height: 0px;"></div><div class="txt div_sp_text smfont" style="float: left; padding: 8px;">正在读取数据，请稍候...</div><div style="color: red; padding: 8px 0px; font-family: 微软雅黑;">   </div></div></body>
</html>