<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>airmusic</title>
<meta content="text/html; charset=utf-8" http-equiv="content-type">
<meta content="width=device-width, maximum-scale=1.0" name="viewport">
<link href="dtree/a.css" type="text/css" rel="stylesheet">
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
            var serverName = theSSID = data.airplay;
            //
            $("#DeviceName").val(serverName.name);

        }


        $(function () {
            //
            langPrefix();
            //
            Loading(message[currentlang].loadingmsg);
            $.get(appendTS(api.apiurl), { data: api.airplay }, function (data) {
                var data = $.xml2json(data);
                bindData(data);
                Loaded();
            });
            //
            document.title = message[currentlang].device;
        });

    
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
            
            postdata["@name"] = DeviceName;

           //
         var xml = json2xml({ "setSysInfo": { "airplay": postdata} });
            //
            Loading(message[currentlang].savingrestart, 10, function () { Loaded(); alert(message[currentlang].refreshalert); });
            //alert(xml);
            $.ajax({ url: appendTS(api.apiurl + "?data=" + escape(xml)),
                type: "POST",
                data: { "data": xml },
                contentType: "application/x-www-form-urlencoded;",
                success: function (result) {
                    //&lt;?xml version="1.0"?&gt;&lt;setSysInfo&gt;&lt;Return status="true"&gt;&lt;/Return&gt;&lt;/setSysInfo&gt;&lt;Return status="false"&gt;wpa encrypt set error!&lt;/Return&gt;&lt;/setSysInfo&gt;
                    var result = $.xml2json(result);
                    if (result.Return.status != "true") alert(result.Return.toString());
                    //Loading(message[currentlang].savingrestart, result.Return.delay, function () { Loaded(); alert(message[currentlang].refreshalert); });
                }
            });
            //bugcode
            //Loading(message[currentlang].savingrestart, 40, function () { Loaded(); alert(message[currentlang].refreshalert); });
            return false;
        }

	</script>
<style type="text/css">
 table.fixtb tbody td.control > input, table.fixtb tbody td.control > select
{
width: 180px;
} 
</style>




<body>
    <form action="SetName" id="form_wi_drive_settings" name="form_wi_drive_settings">
    <div id="DivContent" class="div_content">
        <div class="div_header">
            <div class="div_container">
                <div class="title_back" style="float: left;">
                    <a lang="back" class="btn_back" href="index.asp">返回</a>
                </div>
                <div lang="advancedsetting" class="title_text" style="float: left;">音 频 服 务</div>
                <div class="title_done" style="float: left;">
                    <a lang="done" class="btn_done" onclick="return onDone();" href="javascript:;">完成</a></div>
                <div style="clear: both;">
                </div>
            </div>
        </div>
        <div class="div_center">
            <div class="div_container">
                <div class="div_row">
                    <div lang="server" class="div_row_text">服务器名称:</div>
                    <div class="div_row_control">
                        <input type="text" validate="required,length[_50]" value="<% getCfgGeneral(1, "musicname"); %>" name="DeviceName" id="DeviceName">
                    </div>
                </div>
                <p>
            </p></div>
        </div>
        <div class="div_bottom">
        </div>
    </div>
    </form>


<div style="position: absolute; left: 0px; top: 0px; width: 1920px; height: 176px; opacity: 0.3; background-color: rgb(51, 57, 60); z-index: 9999; display: none;" class="boxlayer"></div><div style="position: absolute; height: 80px; background: none repeat scroll 0% 0% rgb(230, 239, 250); border: 4px solid rgb(130, 178, 238); padding: 8px; z-index: 100000; left: 870.5px; top: 48px; display: none;" id="divLoading"><div style="float: left; background: url(&quot;/css/images/loading.gif&quot;) repeat scroll 0% 0% transparent; width: 0px; height: 0px;"></div><div class="txt div_sp_text smfont" style="float: left; padding: 8px;">正在读取数据，请稍候...</div><div style="color: red; padding: 8px 0px; font-family: 微软雅黑;">   </div></div></body>
</html>