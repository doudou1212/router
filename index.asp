<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head></head>
<body>

    <title>airmusic</title>
    <meta content="text/html; charset=utf-8" http-equiv="content-type">
    <link href="dtree/a.css" type="text/css" rel="stylesheet">
    <meta content="width=device-width, maximum-scale=1.0" name="viewport">
    <meta content="”no-cache”" http-equiv="”pragma”">
    <meta content="”-1”" http-equiv="”expires”">
    <script src="dtree/jquery-1.11.0.min.js" type="text/javascript"></script>
    <script src="dtree/jquery.xml2json.js" type="text/javascript"></script>
    <script src="dtree/langPrefix.js" language="javascript"></script>
    <script src="dtree/tool.js" language="javascript"></script>
    <script type="text/javascript" language="JavaScript">

        function LoadScript(url) {
            window.location.assign(url);
        }
        function bindData(data) {
            if (data == undefined) return;
            if (data.Return.status != "true") {
                alert(data.Return["#text"] || data.Return.toString());
                return;
            }
            //
            var version = data.Version;
            //
            $("#divVersion").html(version.fw2);
            //            
        }
        $(function () {
            $.get(appendTS(api.apiurl), { data: api.version }, function (data) {
                var data = $.xml2json(data);
                bindData(data);
                Loaded();
            });
            //
            document.title = message[currentlang].device;
            langPrefix();
            if ($("body").width()<=480) {
                $("div.div_content").width("100%");
            }
        });
</script>
<style type="text/css">
#topmenucontainer ul 
{
    width:332px;
    font-weight: bold;
    list-style-type: none;
    margin: 0 auto;
    padding: 0;
}
#topmenucontainer li 
{
    background: url(graphics/iPad_Grey_ColorBar.png) repeat-x;
    margin: 5px 0px 0px 0px;
    vertical-align: middle;
    height:45px;
    cursor:pointer;
    font-family:微软雅黑 bold;
}
#topmenucontainer li a
{
    text-decoration:none;
    display:block;
    height:45px;
    line-height:45px;
    white-space:nowrap;
    color:RGB(77,77,77);
}
#topmenucontainer li:hover {
    background:url(graphics/iPad_Grey_ColorBar-2.png) repeat-x 50% 0%!important;
}
#topmenucontainer li:hover a {
    color:White;
}

</style>


    <div style="float:right;width:140px;background:#D3DEEE;text-align:center;">
        <table>
            <tbody><tr>
                <td lang="zh" style="text-align: right">
                    <a onclick="setLanguage('zh');" style="cursor: pointer; text-align: right;">
                    <font class="langs div_sp_text" id="lang">中文</font></a>
                </td>
                <td>
                    <a onclick="setLanguage('en')" style="cursor: pointer">
                    <font class="langs div_sp_text" id="lang">|&nbsp;English</font></a>
                </td>
            </tr>
        </tbody></table>
    </div>
    <div style="clear:both;"></div>
        <div class="div_content" id="topmenucontainer">
            <ul id="topmenu">
                <!--li><a class="tab" href="/" lang="file"></a></li-->
                <li><a lang="advancedsetting" href="a_advanced.asp" class="tab">音 频 服 务</a></li>
                <li><a lang="setting" href="a_settings.asp" class="tab">基 本 设 置</a></li>
                <li><a lang="networkconnect" href="a_network_connections.asp" class="tab">外 网 接 入</a></li>
                <li><a lang="upgrade" href="a_fu.asp" class="tab">固 件 升 级</a></li>
            </ul>
        </div>
    <p></p>
    <center>
        <div style="width:250px;text-align:center;">
        <div lang="fw" class="div_sp_text" style="float:left;padding-left:35px;">版本号:</div>
        <div class="div_sp_text" style="float:left;" id="divVersion">1.0.6-A21(A.01)</div>
        </div>
    </center>


</body>
</html>