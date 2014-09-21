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
<script></script>
        var theNetwork = {};
        var theAPList = {};
        var theRemoteAP = {};
        var currentap = null;
		var wireless_name;
	var flag=null;
    /*    $(function () {
            
            langPrefix();
            
            document.title = message[currentlang].device;
            
            $.get(appendTS(api.apiurl), { data: api.network }, function (result) {
                var result = $.xml2json(result);
                bindMode(result);
                Loaded();
            });
            
            initEvents();
        });*/
		
		$(function(){
			//alert("进入function");
			$("#WiFi_table tr ").hover(function() {
				//alert("hover1");
				this.cells[0].style.backgroundColor = "#D3DEEE";
                
            },
			
				function () { 
				//alert("hover2");
				this.cells[0].style.backgroundColor = "#FFFFFF"; 
				}
			)
			.click(function(){
				var doudou=$(this).find("td").eq(2).html();
				wireless_name=$(this).find("td").eq(0).text();
				alert("doudou="+doudou);
				if(doudou=="")//没有密码直接连接
				{
					alert("NONE,wireless name!"+wireless_name);
					 $.ajax({ url: "/goform/wirelessApcli",
                type: "POST",
                data: wireless_name,
                contentType: "application/x-www-form-urlencoded;",
                success: function (result) {
                    alert("ajax method");//日后还要加上对钩图标
					$(this).find("td").eq(3).html("<img src=\"../graphics/iPad_WiFi_Now.png\">");

                }
            });
					
				}
				else//有密码
				{
					 $("#divPopup")
					.css("left",798)
					.css("top", 200)
					.show(); 
					$("div.boxlayer").show();
					$("#txtPassword").val("").focus();
				}
				// $("#divPopup").show();
			});
			});
		
		
		$(document).ready(function() {
			//alert("hi");
            $("#WiFi_table").find("tr").each(function() {
			//alert("进入函数");
            var sig_num=$(this).find("td").eq(1).html();
			//alert("sig_num="+sig_num);
			sig_num=$(this).find("td").eq(1).html();
			if(sig_num>90)
			{
				$(this).find("td").eq(1).html("<img src=\"../graphics/iPad_WiFi_Symbol.png\">");
			}
			else if(sig_num<=90&&sig_num>80)
			{
				$(this).find("td").eq(1).html("<img src=\"../graphics/iPad_WiFi_Symbol4.png\">");
			}
			else if(sig_num<=80&&sig_num>60)
			{
				$(this).find("td").eq(1).html("<img src=\"../graphics/iPad_WiFi_Symbol3.png\">");
			}
			else
			{
				$(this).find("td").eq(1).html("<img src=\"../graphics/iPad_WiFi_Symbol2.png\">");
			}
			
        	});
			
			$("#WiFi_table").find("tr").each(function(i) {
				//alert("加密方式");
                var mode=$(this).find("td").eq(2).html();
				//alert("mode="+mode);
				mode=$(this).find("td").eq(2).html();
				//alert("mode="+mode);
				if(mode=="NONE")
				{
					$(this).find("td").eq(2).html('');
				}
				else
				{
					$(this).find("td").eq(2).html("<img src=\"../graphics/iPad_WiFi_Lock.png\" />");
				}
            });
        });
		
		
		function Submit()
		{
			var arr=$("#wireless_apcli").serialize();
			alert("进入提交函数");
			$.ajax({ url: "/goform/wirelessApcli",
                type: "POST",
                data: arr+wireless_name,
                contentType: "application/x-www-form-urlencoded;",
                success: function (result) {
                    alert("ajax method");//日后还要加上对钩图标
					$(this).find("td").eq(3).html("<img src=\"../graphics/iPad_WiFi_Now.png\">");

                }
            });
		}
		
		
		function close()
		{
			$("#btnClose").click(function () {
                $("#divPopup").hide();
                $("div.boxlayer").hide();
                //isconnectting = false;
            });
		}
		
		
        function bindMode(data) {
            if (data == undefined) return;
            if (data.Return.status != "true") {
                alert(data.Return["#text"] || data.Return.toString());
                return;
            }
            //
            var network = theNetwork = data;
            flag = data.Client.enable;
            //	alert(flag);
            
            // (有线/无线)接入
            $(":radio[name='joinmode'][value='" + network.WorkMode.value + "']").attr("checked", "checked");
            if (network.WorkMode.value == "0") {
                //有线 
                //
                Loading(message[currentlang].loadingmsg);
                //
                $.get(appendTS(api.apiurl), { data: api.joinwired }, function (result) {
                    var result = $.xml2json(result);
                    //
    /*                if (result.JoinWired.DHCP != undefined) {
                        //动态IP，DHCP
                        $(":radio[name='wiredmode'][value=0]").attr("checked", "checked").click();
                    } else {
                        //静态IP
                        $(":radio[name='wiredmode'][value=1]").attr("checked", "checked").click();
                        var staticip = result.JoinWired.StaticIP;
                        $("#txtIP").val(staticip.ip);
                        $("#txtGateway").val(staticip.gateway);
                        $("#txtMask").val(staticip.mask);
                        $("#txtDns1").val(staticip.dns1);
                        $("#txtDns2").val(staticip.dns2);
                    }
      */              Loaded();
                });
            } else if (1) {
                //无线
                $(":radio[name='joinmode'][value=1]").attr("checked", "checked").click();
                //
                imageAutoScan = 1 - imageAutoScan;
                //关闭自动扫描
                onAutoScan();
                //
                if (flag == "ON") {
                    $("#ImageAutoScan").attr("src", "image/iPad_AutoScan_Btn_ON.png");
                    $("#trScanResult").show();
                } else {
                    $("#ImageAutoScan").attr("src", "image/iPad_AutoScan_Btn_OFF.png");
                    $("#trScanResult").hide();
                }
            }
        }
        function distinctAP(aplist) {
            var tb = new Hashtable();
            var apname = "", ap = null;
            for (var i = 0, n = 0; i<aplist.length; i++) {
                apname = aplist[i]["name"];
                if (tb.contains(apname)) {
                    //存在，比较大小
                    ap = tb.get(apname);
                    if (ap.rssi<aplist[i].rssi) {
                        ap = aplist[i];
                    }
                } else {
                    tb.add(aplist[i]["name"], aplist[i]);
                }
            }
            return tb;
        }
        function bindWLAN(data) {
            if (data == undefined) return;
            data = data.getSysInfo;
            //
            if (data.Return.status != "true") {
                alert(data.Return["#text"] || data.Return.toString());
                return;
            }
            //
            theAPList = data.APList;
            var remoteAP = theRemoteAP = data.RemoteAP;
            //
            var tb = $("#divWirelessBox&gt;table&gt;tbody");
            tb.empty();
            //
            if (theAPList != null) {
                var aplist = null;
                if (is.Array(theAPList.AP)&&theAPList.AP.length>0) {
                    aplist = distinctAP(theAPList.AP);
                    theAPList = theAPList.AP;
                }else{
                    aplist = new Hashtable();
                    aplist.add(theAPList.AP.name,theAPList.AP);
                    theAPList = [theAPList.AP];
                }
                var ap = null;
                for (var key in aplist._hash) {
                    ap = aplist.get(key);
                   // ap.name=ap.name.replace(/&lt;/g,"&amp;lt;");
                    $("&lt;tr apname=\"$1\"&gt;&lt;td&gt;$1&lt;/td&gt;&lt;td&gt;$2&lt;/td&gt;&lt;td&gt;$3&lt;/td&gt;&lt;td&gt;$4&lt;/td&gt;&lt;/tr&gt;".format(ap.name.replace(/&lt;/g,"&amp;lt;"),
                        transfer_rssi(ap.rssi),
                        (ap.name == remoteAP.name&&remoteAP.status == "0" ? "<img src=\"/graphics/iPad_WiFi_Now.png\" />" : ""),
                        (ap.encrypt != "NONE" ? "<img src=\"graphics/iPad_WiFi_Lock.png\" />" : "")
                    ))
                    .hover(function () { this.cells[0].style.backgroundColor = "#D3DEEE"; }, function () { this.cells[0].style.backgroundColor = "#FFFFFF"; })
                    .click(function () {
                        //
                        var ap = findAP($(this).attr("apname"));
                        if (ap != null) {
                            if (ap.encrypt == "WPA-1X" || ap.encrypt == "WPA2-1X" || ap.encrypt == "WPA/WPA2-1X") {
                                alert(message[currentlang].x8021alert);
                                return;
                            }
                            if (ap.encrypt != "NONE") {
                                $("#divPopup")
                                    .css("left", ((pageWidth() - $("#divPopup").width()-8) / 2) + "px")
                                    .css("top", (pageHeight() / 2 - (parseInt($("#divPopup").height()) / 2)) + "px")
                                    .show();
                                $("div.boxlayer").show();
                                $("#txtPassword").val("").focus();
                                currentap = ap;
                                isconnectting = true;
                                return;
                            }
                            //连接WLAN
                            connectWLAN(ap);
                        }
                    }).appendTo(tb);
                }//end for
            }
            else {
                $("<tr><td colspan=\"3\"><div>"+message[currentlang].scanningmsg+"</div></td></tr>").appendTo(tb);
            }//end null判断
        }
        function transfer_rssi(rssi) {
            if (rssi>-50)
                return "<img src=\"graphics/iPad_WiFi_Symbol.png\">;";
            else if (rssi>-65)
                return "<img src=\"graphics/iPad_WiFi_Symbol4.png\">";
            else if (rssi>-80)
                return "<img src=\"graphics/iPad_WiFi_Symbol3.png\">";
            else if(rssi>-90)
                return "<img src=\"graphics/iPad_WiFi_Symbol2.png\">";
			else
				return "<img src=\"graphics/iPad_WiFi_Symbol1.png\">";
        }
        function findAP(apname) {
            for (var i = 0, j = theAPList.length; i < j; i++) {
                if (theAPList[i].name == apname) return theAPList[i];
            }
            return null;
        }
        function connectWLAN(ap) {
            //
            ap.name=ap.name.replace(/&amp;/g,"&amp;amp;");
            ap.name=ap.name.replace(/</g,"&amp;lt;");
            ap.name=ap.name.replace(/>/g,"&amp;gt;");
			if(ap.encrypt != "NONE" )
            ap.password=ap.password.replace(/&amp;/g,"&amp;amp;");
            var xml = json2xml({ "setSysInfo": { "JoinWireless": { "AP": toAttribute(ap)}} });
            //
            Loading("");
            isconnectting = true;
            //
           // $.ajax({ url: appendTS(api.apiurl + "?data=" + escape(xml)),
           $.ajax({ url: appendTS(api.apiurl),
                type: "POST",
                data: { data: xml },
                contentType: "application/x-www-form-urlencoded;",
                success: function (result) {
                    //Loaded();
                    var result = $.xml2json(result);
                    if (result.Return.status != "true") alert(result.Return.toString());

                }
            });
            //bugcode
            Loading(message[currentlang].connecting + ap["@name"] + "...", 20, function () {                
                $.get(appendTS(api.apiurl), { data: api.currentap }, function (result) {
                    var result = $.xml2json(result);
                    Loaded();
                    var remoteAP = theRemoteAP = result.RemoteAP;
                    isconnectting = false;
                    if (theRemoteAP.status == "0") {
                        //连接成功
                        window.location.href = window.location.href;
                    } else {
                        alert(message[currentlang].connectfailed);
                    }
                });
                Loaded();
                //window.location.href = window.location.href;
            }
            );
        }
        function initEvents() {
            $("#btnClose").click(function () {
                $("#divPopup").hide();
                $("div.boxlayer").hide();
                isconnectting = false;
            });
            $("#btnConfirm").click(function () {
                var ap = currentap;
                if (ap == null) return;
                ap.password = $("#txtPassword").val();
                if (ap.password == null) return false;
                if (ap.encrypt == "WEP" && (ap.password.length != 5 && ap.password.length != 10&&ap.password.length != 13&&ap.password.length != 26)) {
                    alert(message[currentlang].pwdlengthalert);
                    return false;
                }
                //WPA、WPA2以及WPA/WPA2混合加密方式的密码需要8位及以上
                if (ap.password.length< 8) {
                    alert(message[currentlang].errorpasswd1);
                    return false;
                }
                $("#divPopup").hide();
                $("div.boxlayer").hide();
                //连接WLAN
                connectWLAN(ap);
            });
            $(":radio[name='joinmode']").click(function () {
                Loaded();
                //切换接入
                if ($(this).val() == "0") {
                    $("#divWired").show();
                    $("#divWireless").hide();
                    $("#btndone").show();
					$.get(appendTS(api.apiurl), { data: api.joinwired }, function (result) {
                    var result = $.xml2json(result);
                    //
                    if (result.JoinWired.DHCP != undefined) {
                        //动态IP，DHCP
                        $(":radio[name='wiredmode'][value=0]").attr("checked", "checked").click();
                    } else {
                        //静态IP
                        $(":radio[name='wiredmode'][value=1]").attr("checked", "checked").click();
                        var staticip = result.JoinWired.StaticIP;
                        $("#txtIP").val(staticip.ip);
                        $("#txtGateway").val(staticip.gateway);
                        $("#txtMask").val(staticip.mask);
                        $("#txtDns1").val(staticip.dns1);
                        $("#txtDns2").val(staticip.dns2);
                    }
				 });
                }
                else {
                    $("#divWired").hide();
                   $("#divWireless").show();
						//
						if(flag=="OFF")
						{	//alert("OFF")
							$("#ImageAutoScan").show();
							$("#ImageAutoScan").attr("src", "graphics/iPad_AutoScan_Btn_OFF.png");
							$("#trScanResult").hide();
						}
						else{
							
					$("#trScanResult").show();
							imageAutoScan = 1 - imageAutoScan;					
						//	onAutoScan();
							}
						$("#btndone").hide();
						//
						
						//
                   
                }
            });
            $(":radio[name='wiredmode']").click(function () {
                //
                if ($(this).val() == "0") {
                    $("#divWiredBox").hide(); //动态
                }
                else {
                    $("#divWiredBox").show(); //静态
                }
            })
            $(":radio[name='joinmode']:first").click();
            $(":radio[name='wiredmode']:first").click();
        }
        function onDone() {
            if ($(":radio[name='joinmode'][checked]").val() == "0") {
                var xml = "";
                //有线模式
                if ($(":radio[name='wiredmode'][checked]").val() == "0") {
                    //动态
                    xml = api.setdhcp;
                } else {
                    //静态
                    if ($("#txtIP").val().trim() == "") {
                        alert(message[currentlang].ipemptyalert);
                        return false;
                    }
                    if (!checkIP($("#txtIP").val().trim())){
                        alert(message[currentlang].iperroralert);
                        return false;
                    }

                    if ($("#txtMask").val().trim() == "") {
                        alert(message[currentlang].maskemptyalert);
                        return false;
                    }
                    if (!checkIP($("#txtMask").val().trim())){
                        alert(message[currentlang].maskerroralert);
                        return false;
                    }
                    if ($("#txtGateway").val().trim() == "") {
                        alert(message[currentlang].gatewayemptyalert);
                        return false;
                    }
                    if (!checkIP($("#txtGateway").val().trim())){
                        alert(message[currentlang].gatewayerroralert);
                        return false;
                    }
                    if ($("#txtDns1").val().trim() == "") {
                        alert(message[currentlang].dns1emptyalert);
                        return false;
                    }
                    if (!checkIP($("#txtDns1").val().trim())){
                        alert(message[currentlang].dns1erroralert);
                        return false;
                    }
                    if ($("#txtDns2").val().trim()&&!checkIP($("#txtDns2").val().trim())){
                        alert(message[currentlang].dns2erroralert);
                        return false;
                    }
                    var staticip = { "@ip": $("#txtIP").val().trim(),
                        "@gateway": $("#txtGateway").val().trim(),
                        "@mask": $("#txtMask").val().trim(),
                        "@dns1": $("#txtDns1").val().trim(),
                        "@dns2": $("#txtDns2").val().trim()
                    };
                    xml = json2xml({ "setSysInfo": { "JoinWired": { "StaticIP": staticip}} });
                }
                //
                Loading("");
                //
                $.ajax({ url: appendTS(api.apiurl + "?data=" + escape(xml)),
                    type: "POST",
                    data: { "data": xml },
                    contentType: "application/x-www-form-urlencoded;",
                    success: function (result) {
                        var result = $.xml2json(result);
                        if (result.Return.status != "true") alert(result.Return.toString());
                    //    Loading(message[currentlang].savingconfig, result.Return.delay, function () { Loaded(); alert(message[currentlang].refreshalert); });
                    }
                });
                //bugcode
                Loading(message[currentlang].savingconfig, 30, function () { Loaded(); alert(message[currentlang].refreshalert); });
            } else {
                //无线模式
                if (theRemoteAP == undefined) {
                    alert(message[currentlang].selectwifialert);
                }
            }
            return false;
        }
        var imageAutoScan = getCookie('AUTOSCAN') || 1;
        var isconnectting = false;
        function onAutoScan() {
            if (imageAutoScan == 0) {
                imageAutoScan = 1;
                setCookie('AUTOSCAN', 1);
                $("#ImageAutoScan").attr("src", "graphics/iPad_AutoScan_Btn_ON.png");
                $("#trScanResult").show();
                //
            //    Loading(message[currentlang].scanningmsg, 5);
                //
                $.get(appendTS(api.apiurl), { data: api.aplist }, function (result) {
                    //var result = $.xml2json(result);
                    result = eval("(" + xml2json(parseXml(result), " ") + ")");
                    bindWLAN(result);
                    Loaded();
                    //
                    setTimeout(reload, 20000);
                });
            }
            else {
                imageAutoScan = 0;
                setCookie('AUTOSCAN', 0);
                $("#ImageAutoScan").attr("src", "graphics/iPad_AutoScan_Btn_OFF.png");
            //    $("#trScanResult").hide();
			
            }
        }
        function reload() {
		
            if (flag=="ON"&&imageAutoScan == 1&&!isconnectting && $(":radio[name='joinmode'][checked]").val() == "1") {
                window.location.href = window.location.href;
                return;
            }
            //
            setTimeout(reload, 20000);
        }
		function Client(){
			
			if(flag=="ON")
			{
				client="&lt;setSysInfo&gt;&lt;Client enable=\"OFF\"/&gt;&lt;/setSysInfo&gt;";
				$.get(appendTS(api.apiurl), { data: client }, function (result) {
					//alert(result);
					result = eval("(" + xml2json(parseXml(result), " ") + ")");
				//	alert(result.Return.status);
				});
				$("#ImageAutoScan").attr("src", "graphics/iPad_AutoScan_Btn_OFF.png");
				$("#trScanResult").hide();
				flag="OFF";
			}else{
					client="&lt;setSysInfo&gt;&lt;Client enable=\"ON\"/&gt;&lt;/setSysInfo&gt;";
					//alert(client);
					$.get(appendTS(api.apiurl), { data: client }, function (result) {
				//	alert(result);
				});
				$("#ImageAutoScan").attr("src", "graphics/iPad_AutoScan_Btn_ON.png");
				$("#trScanResult").show();
				flag="ON";
			} 
			
}
function pwdmask(){
        //var e = document.getElementById('txtPassword');
        //e.type = (e.type=='password') ? 'text' : 'password'
        //var obj=$("#txtPassword");
       	var  obj = document.getElementById('txtPassword');
	if(obj.value !== ""){
		if(obj.type == "password"){
            		$("#pwdspan").html("&lt;input type=\"text\" id=\"txtPassword\" style=\"vertical-align:middle;width:240px;height:28px;line-height:28px;\" value="+obj.value+" /&gt;");
            	}
            	else if(obj.type == "text")
            	{
            		$("#pwdspan").html("&lt;input type=\"password\" id=\"txtPassword\" style=\"vertical-align:middle;width:240px;height:28px;line-height:28px;\" value="+obj.value+" /&gt;");
            	
        	 }
		}	
 }
</script>


<style type="text/css">
        &lt;!--div.container
        {
            margin: 5px auto;
            width: 320px;
            border: solid 1px gray;
            background-color: #CDDBEE;
            display: none;
        }--&gt;
        div.wiredbox
        {
            border: solid 1px gray;
            padding: 3px;
            width: 100%;
            height: 100%;
        }
        span.caption
        {
            width: 110px;
			margin-left:-20px;
			padding-left:20px;
            display: inline-block;
            height:45px;
            line-height:45px;
            text-align:left;
        }
        div.wiredbox table td
        {
            height: 22px;
            line-height: 22px;
            cursor: pointer;
		font-family:微软雅黑;
        }
        .btn_style_1{width:80px;height:28px;}
        #eye {
	 vertical-align:middle;
       	 margin-left:200px !important;/*ff*/
       	 margin-top:-28px !important;
       	 padding-bottom:10px;
       	 margin-top:-36px \9;/* ie*/
       	 padding-bottom:28px \9;
        }
    </style>
</head>



<body>
    <form action="" id="form_conn_network" name="form_conn_network">
    <div id="DivContent" class="div_content">
        <div class="div_header">
            <div class="div_container">
                <div class="title_back" style="float: left;">
                    <a lang="back" class="btn_back" href="index.asp">返回</a>
                </div>
                <div lang="networkconnect" class="title_text" style="float: left;">外 网 接 入</div>
                <div id="btndone" class="title_done" style="display:none;float: left;">
                    <a lang="done" class="btn_done" onclick="return onDone();" href="javascript:;">完成</a></div>
                <div style="clear: both;">
                </div>
            </div>
        </div>
        <div class="div_center">
            <div class="div_container">
        
        <!--div class="div_row">
            <div class="div_row_text div_sp_text smfont" style="width: 80px;" lang="joinmode">
            </div>
            <div class="div_row_control">
                <label>
                    <input name="joinmode" value="0" checked="checked" type="radio" /><span lang="wired" class="div_sp_text smfont"></span></label>&nbsp;&nbsp;
                <label>
                    <input name="joinmode" value="1" type="radio" /><span lang="wireless" class="div_sp_text smfont"></span></label>
            </div>
        </div>
        <!--有线接入-->
        <!--div id="divWired" class="container">
            <table style="width: 100%;">
                <tr>
                    <td>
                        <div style="padding: 0px 2px;">
                            <span style="background: url(/graphics/s_attention.png) no-repeat; width: 16px; height: 16px;
                                display: inline-block"></span>&nbsp;<span lang="wirednotice" class="div_sp_text smfont"></span></div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div style="padding-left:100px;text-align:left;">
                        <label>
                            <input name="wiredmode" value="0" checked="checked" type="radio" /><span lang="dynamicip" class="div_sp_text smfont"></span></label>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div style="padding-left:100px;text-align:left;">
                        <label>
                            <input name="wiredmode" value="1" type="radio" /><span lang="staticip" class="div_sp_text smfont"></span></label>
                        </div>
                        <div class="wiredbox" id="divWiredBox" style="margin: 5px 5px 5px 22px; width: 260px;border:0px;">
                            <div class="item_row">
                                <span lang="ip" class="caption div_sp_text smfont" ></span><span>
                                    <input id="txtIP" value="" type="text" style="width:110px;"/></span>
                            </div>
                            <div class="item_row">
                                <span lang="mask" class="caption div_sp_text smfont " ></span><span>
                                    <input id="txtMask" value="" type="text" style="width:110px;"/></span>
                            </div>
                            <div class="item_row">
								<span lang="gateway" class="caption div_sp_text smfont" ></span><span>
                                    <input id="txtGateway" value="" type="text" style="width:110px;"/></span>
                            </div>
                            <div class="item_row">
                                <span lang="dns1" class="caption div_sp_text smfont"></span><span>
                                    <input id="txtDns1" value="" type="text" style="width:110px;"/></span>
                            </div>
                            <div class="item_row">
                                <span lang="dns2" class="caption div_sp_text smfont" ></span><span>
                                    <input id="txtDns2" value="" type="text" style="width:110px;"/></span>
                            </div>
                        </div>
                    </td>
                </tr>
            </table>
        </div-->
        <!--无线接入-->
        <div style="display:block;" class="container" id="divWireless">
            <table>
                <tbody><tr>
                    <td style="padding: 2px 5px;display:block;">
                        <div>
                            <div lang="autoscan" style="float: left; height: 27px; line-height: 27px;" class="caption div_sp_text smfont">无线接入:</div>
                            <div style="float: left; height: 27px; cursor: pointer; margin-left: 5px;">
                                <img src="graphics/iPad_AutoScan_Btn_ON.png" onclick="Client();" id="ImageAutoScan"></div>
                        </div>
                    </td>
                </tr>
                <tr id="trScanResult" style="display: table-row;">
                    <td style="padding: 5px 5px;">
                        <div lang="availableconnection" class="div_sp_text smfont" style="text-align:left;">可用Wi-Fi热点:</div>
                        <div style="width: 298px; background-color: #FFF;" id="divWirelessBox" class="wiredbox">
                            <table style="table-layout: fixed; width: 100%;">
                                <colgroup>
                                    <col>
                                    <col width="28">
                                    <col width="28">
                                    <col width="28">
                                </colgroup>
                                <tbody><tr><td colspan="3"><div>正在扫描Wi-Fi热点...</div></td></tr></tbody>
                            </table>
                            
                                 <table  id="WiFi_table" border="0" cellpadding="2" cellspacing="0" style="table-layout: fixed; width: 100%;">
                           			 <colgroup>
                                    <col>
                                    <col width="52">
                                    <col width="16">
                                    <col width="16">
                                </colgroup>
									<tr>
  									  </tr>
  									<% ApcliScan(); %>
								</table>
                            
                            
                        </div>
                    </td>
                </tr>
            </tbody></table>
        </div>

            </div>
        </div>
        <div class="div_bottom">
        </div>
    </div>
    </form>
    
    <div class="div_content">
 
</div>


    <div style="position:absolute;width:280px; height:120px;display:none;z-index:99999;background:#E6EFFA;border:solid 4px #82B2EE;" id="divPopup">  
    <form method=post name=wireless_apcli  id="wireless_apcli" action="/goform/wirelessApcli" >      
        <div lang="connectpwdalert" style="background-color:#CDDBEE;height:30px;line-height:30px;text-align:left;padding-left:0px;">请输入Wi-Fi的密码!</div>
        <div style="width:240px; height:30px;margin:10px auto;">
            <span id="pwdspan">
            <input type="password"  name="apcli_key1" style="vertical-align:middle;width:240px;height:28px;line-height:28px;" id="txtPassword" value="<% getCfgToHTML(1, "ApCliKey1Str"); %>">
            </span>
       	    <!--img onclick="pwdmask()" id="eye" src="graphics/eye.png"-->
        </div>
        <div style="text-align:left;">
             <input lang="confirm" type="button" value="确定" style="margin-left:20px;" class="btn_style_1" id="btnConfirm" onclick="Submit();">
             <input lang="cancel" type="button" value="取消" style="position:absolute;left:185px;" class="btn_style_1" id="btnClose" onclick="close();">
        </div>
       </form>
    </div>


</body>
