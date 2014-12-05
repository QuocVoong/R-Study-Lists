function checkBrowserWithAlert(){
	if (navigator.appName!="Microsoft Internet Explorer") 
		alert("本網頁根據 IE 測試，如果你不是使用 IE，可能無法正確呈現唷！");
}

function checkBrowserWithText(){
//	alert(navigator.appName);
//	if (navigator.appName!="Microsoft Internet Explorer") 
//		document.write("<h4 align=center><font color=red>本網頁根據 IE 測試，如果你不是使用 IE，可能無法正確呈現唷！</font></h4>");
	if (navigator.appName!="Netscape") 
		document.write("<h4 align=center><font color=red>本網頁根據 Chrome 測試，如果你不是使用 Chrome，可能無法正確呈現唷！</font></h4>");
}

function hotKeyFunction(){
	var re, newUrl, targetDir;
	var url=document.location+"";
	if ((event.ctrlKey) && (event.keyCode==49)){	// ctrl+1: to localhost
		re=/neural\.cs\.nthu\.edu\.tw/;
		if (re.test(url)){
			newUrl=url.replace(re, "localhost");
		//	alert("Connecting to \""+newUrl+"\"");
			document.location=newUrl;
		}
		re=/mirlab\.org/;
		if (re.test(url)){
			newUrl=url.replace(re, "localhost");
		//	alert("Connecting to \""+newUrl+"\"");
			document.location=newUrl;
		}
	}
	if ((event.ctrlKey) && (event.keyCode==50)){	// ctrl+2: to mirlab.org
		re=/localhost/;
		if (re.test(url)){
		//	newUrl=url.replace(re, "neural.cs.nthu.edu.tw");
			newUrl=url.replace(re, "mirlab.org");
		//	alert("Connecting to \""+newUrl+"\"");
			document.location=newUrl;
		}
	}
	if ((event.ctrlKey) && (event.keyCode==71))	// ctrl+g ===> google
		document.location="http://www.google.com";
	if ((event.ctrlKey) && (event.keyCode==66))	// ctrl+b ===> mega bank
		document.location="https://ebank.megabank.com.tw/signon-a.htm";
	if ((event.ctrlKey) && (event.keyCode==77))	// ctrl+m ===> mirlab.org
		document.location="http://mirlab.org";
	if ((event.ctrlKey) && (event.keyCode==51)){	// ctrl+3: open corresponding directory
		// Works for both http://neural.cs.nthu.edu.tw/ and http://localhost/
	//	alert(url);
		re=/http:\/\/neural\.cs\.nthu\.edu\.tw\/|http:\/\/mirlab\.org\/|http:\/\/localhost\//
		url=url.replace(re, "");
	//	alert(url);
		re=/(.*)\//;
		url=url.replace(re, "");
	//	alert(RegExp.$1);
		targetDir="file:///d:/users/"+RegExp.$1;
		alert(targetDir);
		document.location=targetDir;
	}
	if ((event.ctrlKey) && (event.keyCode==37))	// ctrl + <- ===>
		document.location="";
	if ((event.ctrlKey) && (event.keyCode==38))	// ctrl + ^ ===>
		document.location="";
	if ((event.ctrlKey) && (event.keyCode==39))	// ctrl + -> ===>
		document.location="";
	if ((event.ctrlKey) && (event.keyCode==39))	// ctrl + v ===>
		document.location="";
}
document.onkeydown=hotKeyFunction;

function emailDisplay(user, site, subject){
	if (emailDisplay.arguments.length==2)
		document.write('<a href=\"mailto:' + user + '@' + site + '\">');
	else
		document.write('<a href=\"mailto:' + user + '@' + site + '?subject=' + subject + '\">');
	document.write(user + '@' + site + '</a>');
}

function vecMax(){
	var i, max = this[0];
	for (i=1; i<this.length; i++)
		if (max<this[i])
			max=this[i];
	return(max);
}
Array.prototype.max = vecMax;		// 定義 arrayMax 為陣列方法 max 所呼叫的函數

function vecSum(){
	var i, sum = this[0];
	for (i=1; i<this.length; i++)
		sum+=this[i];
	return(sum);
}
Array.prototype.sum = vecSum;		// 定義 arrayMax 為陣列方法 max 所呼叫的函數

function showImage(src, title, width){
	var out="";
	if (showImage.arguments.length<2) title="";
	if (showImage.arguments.length<3) width=500;
	if (title.length==0){
	//	out=out+"<p align=center><img src=\""+src+"\"></p>";
		out=out+"<p align=center><a target=_blank href=\""+src+"\"><img width="+width+" border=1 src=\""+src+"\"></a></p>";
	} else {
		out=out+"<p align=center>";
		out=out+"<table><tr><td>";
		out=out+"<a target=_blank href=\""+src+"\"><img width="+width+" border=1 src=\""+src+"\"></a>";
		out=out+"<br><center>"+title+"</center>";
		out=out+"</table></p>";
	}
	document.write(out);
}

function showImageArray(imageArray){
	var out="";
	out=out+"<p align=center>";
	out=out+"<table border=1><tr align=center>";
	for (var i=0; i<imageArray.length; i++){
	//	document.write("<p>i="+i+", src="+imageArray[i].src+", title="+imageArray[i].title);
		out=out+"<td align=center width="+imageArray[i].width+">";
		out=out+"<a target=_blank href=\""+imageArray[i].src+"\"><img width="+imageArray[i].width+" border=1 src=\""+imageArray[i].src+"\"></a>";
		
	}
	out=out+"<tr align=center>";
	for (var i=0; i<imageArray.length; i++){
		out=out+"<td align=center valign=top>"+imageArray[i].title;
	}
	out=out+"</table></p>";
	document.write(out);
}