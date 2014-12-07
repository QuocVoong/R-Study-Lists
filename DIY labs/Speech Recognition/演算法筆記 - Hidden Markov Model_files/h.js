h = {};

// create  menu, adjust banner's line breaking
h.Menu = function()
{
	var menu = document.createElement('DIV');
	menu.className = 'm';
	menu.innerHTML += '<div class="li"><a href="index.html">演算法筆記</a></div>';

	var childs = document.querySelectorAll("div.a>div.h>p.b");
	for(var i = 0; i < childs.length; i++)
	{
		var banner = childs[i];
		banner.innerHTML = banner.innerHTML.replace(/: /gi,':<br>').replace(/（/gi,'<br>（').replace(/【/gi,'<br>【');
		menu.innerHTML += '<div class="li"><a href="#' + (i+1) + '">' + banner.innerHTML + '</a></div>';
		banner.parentNode.id = (i+1);
	}
	document.body.appendChild(menu);
}

// reset the style of English words in <p>
h.English = function()
{
	var p = document.getElementsByTagName('p');
	for(var i = 0; i < p.length; i++)
	{
		for(var j = 0; j < p[i].childNodes.length; j++)
		{
			var node = p[i].childNodes[j];
			if (node.nodeType == 3)
				node.nodeValue = node.nodeValue.replace(/([ -ω∀-⋱⁰-₎]+)/gi, ' $1 ');
			else
				node.innerHTML = node.innerHTML.replace(/([ -ω∀-⋱⁰-₎]+)/gi, ' $1 ');
		}
		p[i].innerHTML = p[i].innerHTML.replace(/^ /, '').replace(/ $/, '');
	}
}

// generate the hyperlinks of the exercises
h.ProbLink = function()
{
	var oj = 'uva';
	var p = document.getElementsByClassName('e');
	for(var i = 0; i < p.length; i++)
	{
		var probs = p[i].textContent.split(' ');
		for(var j = 0; j < probs.length; j++)
		{
			var n = parseInt(probs[j], 10);
			if(isNaN(probs[j][0])) oj = probs[j].toLowerCase();
			else if(oj == 'uva')   p[i].innerHTML = p[i].innerHTML.replace(probs[j], '<a href="http://uva.onlinejudge.org/external/' + Math.floor(n/100) + '/' + n + '.html">' + n + '</a>');
			else if(oj == 'icpc')  p[i].innerHTML = p[i].innerHTML.replace(probs[j], '<a href="http://livearchive.onlinejudge.org/external/' + Math.floor(n/100) + '/' + n + '.pdf">' + n + '</a>');
			else if(oj == 'timus') p[i].innerHTML = p[i].innerHTML.replace(probs[j], '<a href="http://acm.timus.ru/problem.aspx?space=' + Math.floor(n/1000) + '&num=' + n + '">' + n + '</a>');
			else if(oj == 'pku')   p[i].innerHTML = p[i].innerHTML.replace(probs[j], '<a href="http://poj.org/problem?id=' + n + '">' + n + '</a>');
			else if(oj == 'cf')    p[i].innerHTML = p[i].innerHTML.replace(probs[j], '<a href="http://codeforces.com/problemset/problem/' + probs[j].substr(0, probs[j].length-1) + '/' + probs[j][probs[j].length-1] + '">' + probs[j] + '</a>');
		}
	}
}

// regular expressions
h.types =
	'char bool short int long float double unsigned '
	+'clock_t size_t va_list __int32 __int64';

h.keywords =
	'break case catch class const const_cast continue '
	+'default delete do dynamic_cast else enum explicit extern '
	+'if for friend goto inline mutable namespace new operator '
	+'private public protected register reinterpret_cast return '
	+'sizeof static static_cast struct switch template this '
	+'throw true false try typedef typeid typename union '
	+'using virtual void volatile while';

h.MakeRegExp = function(str) 
{
	return '\\b' + str.replace(/ /g, '\\b|\\b') + '\\b';
}

h.regexps = [
	{r:/\/\*[\s\S]*?\*\//gm, css:'comments'},
	{r:/\/\/.*$/gm, css:'comment'},
	{r:/^ *#.*/gm, css:'macro'},
	{r:/"([^"\\\n]|\\.)*"/g, css:'string'},
	{r:/'([^'\\\n]|\\.)*'/g, css:'char'},
	{r:new RegExp(h.MakeRegExp(h.keywords),'g'), css:'keyword'},
	{r:new RegExp(h.MakeRegExp(h.types),'g'), css:'type'},
	{r:/[^\W\d]\w*/g, css:'word'},
	{r:/0[xX][\da-fA-F]+/g, css:'hex'},
	{r:/(\d*\.)?\d+([eE]\d+)?/g, css:'value'}
];

// escape html entity
h.HTML2String = function(html)
{
	return html
	.replace(/&amp;/g, '&')
	.replace(/&lt;/g, '<')
	.replace(/&gt;/g, '>')
	.replace(/&quot;/g, '"')
	.replace(/&nbsp;/g, ' ');
}

h.String2HTML = function(str)
{
	return str
	.replace(/&/g, '&amp;')
	.replace(/</g, '&lt;')
	.replace(/>/g, '&gt;')
	.replace(/"/g, '&quot;')
	.replace(/ /g, '&nbsp;');
}

h.Tab = function(text)
{
	var spaces = '    ';
	var stext = '';
	var lines = h.HTML2String(text).replace(/\n$/g, '').split('\n');
	for(var i = 0; i < lines.length; i++)
	{
		for(var p = 0; (p = lines[i].indexOf('\t')) != -1;)
			lines[i] = lines[i].replace(/\t/, spaces.slice(0, 4-p%4));
		stext += lines[i] + '\n';
	}
	return stext;
}

h.Color = function(str, css)
{
	if(str == null || str.length == 0) return;

	var lines = h.String2HTML(str).split('\n');
	for(var i = 0; i < lines.length; i++)
	{
		if(lines[i] != '')
		{
			var span = document.createElement('SPAN');
			if(css != null) span.className = css;
			span.innerHTML = lines[i];
			h.li.appendChild(span);
		}

		if(i + 1 < lines.length)
		{
			// FF need insert '&nbsp;' to make empty <li> displayed
			if(h.li.innerHTML == '') h.li.innerHTML = '&nbsp;';
			h.ol.appendChild(h.li);
			h.li = document.createElement('LI');
		}
	}
}

h.Parse = function(element)
{
	var text = h.Tab(element.innerHTML);
	var m = [0,0,0,0,0,0,0,0,0,0];
	var q = 0;
	h.ol = document.createElement('OL');
	h.li = document.createElement('LI');

	while(1)
	{
		var ii = -1;
		var p = text.length;
		for(var i = 0; i < h.regexps.length; i++)
		{
			if(m[i] == null) continue;
			if(m[i] == 0 || m[i].index < q)
			{
				var r = h.regexps[i].r;
				r.lastIndex = q;
				m[i] = r.exec(text);
			}
			if(m[i] == null) continue;
			if(m[i].index < p) {p = m[i].index; ii = i;}
		}

		if(ii == -1) {h.Color(text.slice(q), null); break;}
		h.Color(text.slice(q, p), null);
		h.Color(m[ii][0], h.regexps[ii].css);
		q = h.regexps[ii].r.lastIndex;
	}

	var bar = document.createElement('DIV');
	bar.className = 'bar';
    bar.innerHTML = '&nbsp;';
	if(element.attributes['t'] != null)
		bar.innerHTML = element.attributes['t'].value;

	var div = document.createElement('DIV');
	div.className = 'sh';
	div.appendChild(bar);
	div.appendChild(h.ol);

//	element.parentNode.replaceChild(div, element);	// FF has bug
	element.style.display = 'none';
	element.parentNode.insertBefore(div, element);
}

h.HighLight = function()
{
	var texts = document.getElementsByTagName('textarea');
	for(var i = 0; i < texts.length; i++)
		h.Parse(texts[i]);
}

h.HighLight();
h.Menu();
h.English();
h.ProbLink();