/**
 * Ajax核心方法
 */
var H = {
		/**
		 * 默Http认错误处理方法
		 */
		errorFun:function(res){
			H.msg(!res.message ? "未知错误" : res.message);
		},
		/**
		 * 格式化参数
		 */
		formatParams:function(prams, collback, error){
			var coll;
			var par;
			var err;
			if(prams){
				if(typeof prams == 'function'){
					coll = prams;
					if(collback && typeof collback == 'function'){
						err = collback;
					}
				}else{
					par = prams;
					if(collback){
						coll = collback;
						if(error && typeof error == 'function'){
							err = error;
						}
					}else{
						coll = function(){};
					}
				}
			}
			
			if(!err){
				err = H.errorFun;
			}
			return {
				coll:coll,
				par:par,
				err:err
			};
		},
		openLoad: function (){
			if (document.getElementsByClassName("loading-block").length == 0){
				let div = document.createElement("div");
				div.setAttribute("class", "loading-block burl");
				let loaderDiv = document.createElement("div");
				loaderDiv.setAttribute("class", "loader");
				div.appendChild(loaderDiv);
				document.body.appendChild(div);
				document.getElementsByClassName("loading-block")[0].style.bottom = 0;
				document.getElementsByClassName("loading-block")[0].style.display = "block";
				setTimeout(() => {
					document.getElementsByClassName("loading-block")[0].style.backgroundColor = "rgba(0,0,0,.6)";
				}, 10)
			}else{
				document.getElementsByClassName("loading-block")[0].style.bottom = 0;
				document.getElementsByClassName("loading-block")[0].style.display = "block";
				document.getElementsByClassName("loading-block")[0].style.backgroundColor = "rgba(0,0,0,.6)";
			}
		},
		closeLoad: function (){
			document.getElementsByClassName("loading-block")[0].style.backgroundColor = "rgba(0,0,0,.0)";
			document.getElementsByClassName("loading-block")[0].style.bottom = 0;
			document.getElementsByClassName("loading-block")[0].style.display = "none";
		},
		uuid: function(){
			var s = [];
			var hexDigits = "0123456789abcdef";
			for (var i = 0; i < 36; i++) {
				s[i] = hexDigits.substr(Math.floor(Math.random() * 0x10), 1);
			}
			s[14] = "4"; // bits 12-15 of the time_hi_and_version field to 0010
			s[19] = hexDigits.substr((s[19] & 0x3) | 0x8, 1); // bits 6-7 of the clock_seq_hi_and_reserved to 01
			s[8] = s[13] = s[18] = s[23] = "-";

			var uuid = s.join("");
			return uuid;
		},
		msg: function(msg){
			let box = document.createElement("div");
			box.setAttribute("style", "position: fixed;z-index: 11;width: 100%; text-align: center; bottom: 30px; opacity: 0;" +
				" transition: 0.5s;" +
				" -moz-transition: 0.5s;" +
				" -webkit-transition: 0.5s;" +
				" -o-transition: 0.5s;");
			box.innerHTML = "<div style=\"background-color: rgba(0,0,0,.6); color: white; padding: 20px; border-radius: 10px; display: inline-block;\" class=\"burl\">" +
				msg +
				"</div>";
			document.body.appendChild(box);
			setTimeout(() => {
				box.style.bottom = "50px";
				box.style.opacity = "1";
			}, 10);
			setTimeout(() => {
				box.style.bottom = "200px";
				box.style.opacity = "0";
				setTimeout(() => {
					document.body.removeChild(box);
				}, 500)
			}, 3000);
		},
		/**
		 * 发送自定义Http请求
		 */
		sendHttp:function(url, param, collback, error, type){
			H.openLoad();
			var xmlhttp = new XMLHttpRequest();
			
			var data = null;
			
			xmlhttp.onreadystatechange = function(){
				if (xmlhttp.readyState==4){
					H.closeLoad();
					if (xmlhttp.status==200){
						var result = xmlhttp.responseText;
						try{
							result = JSON.parse(xmlhttp.responseText)
						}catch(e){
							console.log("Not Parse Json, result:" + result);
						}
						collback(result);
					}else{
						if (xmlhttp.status === 404){
							H.msg("status: 404");
							return;
						}
						var result = xmlhttp.responseText;
						try{
							result = JSON.parse(xmlhttp.responseText)
						}catch(e){
							console.log("Not Parse Json, result:" + result);
						}
						error(result);
					}
				}
			};
			
			xmlhttp.open(type,url,true);
			
			if(type == "PUT" || type == "DELETE" || type == "POST"){
				xmlhttp.setRequestHeader("Content-Type","application/json;charset=utf-8");
				if(param){
					data = JSON.stringify(param);
				}
			}else{
				if(param){
					data = new FormData();
					for(var i in param){
						data.append(i, param[i]);
					}
				}
			}
			
			try{
				xmlhttp.send(data);
			}catch(e){
				//50x,40x
			}
		},
		sendHttpTxt:function(url, param, collback, error, type){
			H.openLoad();
			var xmlhttp = new XMLHttpRequest();
			
			var data = null;
			
			xmlhttp.onreadystatechange = function(){
				if (xmlhttp.readyState==4){
					H.closeLoad();
					if (xmlhttp.status==200){
						collback(xmlhttp.responseText);
					}else{
						if (xmlhttp.status === 404){
							H.msg("status: 404");
							return;
						}
						error(xmlhttp.responseText);
					}
				}
			};
			
			xmlhttp.open(type,url,true);
			
			if(type == "PUT" || type == "DELETE" || type == "POST"){
				xmlhttp.setRequestHeader("Content-Type","application/json;charset=utf-8");
				if(param){
					data = JSON.stringify(param);
				}
			}else{
				if(param){
					data = new FormData();
					for(var i in param){
						data.append(i, param[i]);
					}
				}
			}
			
			try{
				xmlhttp.send(data);
			}catch(e){
				//50x,40x
			}
		},
		/**
		 * 发送get请求
		 */
		get:function(url, prams, collback, error){
			var param = H.formatParams(prams, collback, error);
			if(param.par){
				var p = "";
				for(var i in param.par){
					p += i + "=" + param.par[i] + "&";
				}
				p = encodeURI(p);
				url += "?" + p;
			}
			H.sendHttp(url, null, param.coll, param.err, 'GET');
		},
		getTxt:function(url, prams, collback, error){
			var param = H.formatParams(prams, collback, error);
			if(param.par){
				var p = "";
				for(var i in param.par){
					p += i + "=" + param.par[i] + "&";
				}
				p = encodeURI(p);
				url += "?" + p;
			}
			H.sendHttpTxt(url, null, param.coll, param.err, 'GET');
		},
		/**
		 * 发送post请求
		 */
		post:function(url, prams, collback, error){
			var param = H.formatParams(prams, collback, error);
			H.sendHttp(url, prams, param.coll, param.err, 'POST');
		},
		/**
		 * 发送put请求
		 */
		put:function(url, prams, collback, error){
			var param = H.formatParams(prams, collback, error);
			H.sendHttp(url, prams, param.coll, param.err, 'PUT');
		},
		/**
		 * 发送delete请求
		 */
		del:function(url, prams, collback, error){
			var param = H.formatParams(prams, collback, error);
			H.sendHttp(url, prams, param.coll, param.err, 'DELETE');
		}
		

};