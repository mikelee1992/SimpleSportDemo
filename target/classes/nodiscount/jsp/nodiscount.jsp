<%@page language="java" contentType="text/html; charset=UTF-8"  deferredSyntaxAllowedAsLiteral="true"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
<head>
    <meta content="width=device-width,height=device-height,inital-scale=1.0,maximum-scale=1.0,user-scalable=no;" name="viewport">
	<meta content="yes" name="apple-mobile-web-app-capable">
	<meta content="black" name="apple-mobile-web-app-status-bar-style">
	<meta content="telephone=no" name="format-detection">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>流量包充值</title>	
    <link rel="stylesheet" type="text/css" href="../css/main.css"/>
	<link rel="stylesheet" type="text/css" href="../css/reset.css"/>
	<link rel="stylesheet" type="text/css" href="../css/layer.css"/>
	<style type="text/css">
	.layer_bdBox_showSp2 {
	    position: relative;
	    z-index: 99;	    
	    margin-top: 15%;
	    background: #EEE;
	    opacity: 1; 
	    filter: alpha(opacity=70);
	    padding: 10% 0;
	    width: 100%;
	    border-radius: 4px;
	    text-align: center;
    }
    .show_sp_div_btn{
    	display:block;
	    margin-top: 1rem;
	    margin-left:30%
	    font-size: 1rem;
	    color: #fff;
	    line-height: 2.5rem;
	    text-align: center;
	    border: 1px solid #e4670c;
	    border-radius: 5px;
	    background: #fd8a36;
	    width: 40%;
	    margin: 1rem 30%;
    }
    
    .layer_bdBox_showSp2 ul li{
    	line-height: 1.6rem;
    }
    .layer_bdBox_showSp2 p{
    	line-height: 1.6rem;
    	text-align: left;
    }
	</style>
    <script type="text/javascript" src="../../../admin/js/jquery-1.7.1.min.js"></script>
    <script type="text/javascript" src="../../../admin/js/base.js"></script>
    <script type="text/javascript">
		/*按钮在ios点击时变色*/	
		$(function(){
				document.body.addEventListener('touchstart', function () { 
				}); 
			})
    </script>
    <script type="text/javascript">
    	$(function(){
			getUserInfo();	
		})
		
		//查找用户信息
		function getUserInfo(){
			$.ajax({
				url : "../../../cgi-bin/wxbind",
				data : "method=queryByOpenId",
				dataType : "json",
				type : "post",
				success : function(data) {
					$("#phoneNum").html(data.tel);
					$("#operator").html(data.area+data.operator);
					$("#operatorValue").val(data.operator);
					if("联通" != data.operator){
						$("#errMsg").text("本活动只适用于联通手机号码");
			    		$("#errDiv").show();
						$("#errDiv").fadeOut(2000);
					}
				},
				error : function(data) {
				
				}
			})
		}
    	
    	function toRecharge(){
    		var productId = $("#productId").val();
    		var activityId = "1";
    		
	 	var operator = $("#operatorValue").val();
    		if("联通" != operator){
				$("#errMsg").text("本活动只适用于联通手机号码");
	    		$("#errDiv").show();
				$("#errDiv").fadeOut(2000);
				return;
			}
    		if(null == productId || "" == productId){
    			$("#errMsg").text("请选择");
	    		$("#errDiv").show();
				$("#errDiv").fadeOut(2000);
				return;
    		}
    		var json = $.ajax({
				url : "../../../cgi-bin/wxpay",
				data : "method=createWxOrder&productId="+productId+"&activityId="+activityId,
				dataType : "json",
				type : "post",
				
				//成功后的回调函数
				success : function(data) {
						//alert(JSON.stringify(data));
						var obj = data;
						//alert(obj.packageValue);
						//调起微信支付
						WeixinJSBridge.invoke('getBrandWCPayRequest',{  
		                "appId" : obj.appId,                  //公众号名称，由商户传入  
		                "timeStamp":obj.timeStamp,          //时间戳，自 1970 年以来的秒数  
		                "nonceStr" : obj.nonceStr,         //随机串  
		                "package" : obj.packageValue,      //<span style="font-family:微软雅黑;">商品包信息</span>  
		                "signType" : 'MD5',        //微信签名方式: 
		                "paySign" : obj.paySign           //微信签名  
		                },function(res){      
			                if(res.err_msg == "get_brand_wcpay_request:ok" ) {  
			                	//拿商家订单号做一把查询看是否交费成功
			                	sendMsg("您有一笔订单支付成功！");
								$("#errMsg").html("支付成功！");
								$("#message").show();
								$("#message").fadeOut(4000);
			                	//orderQuery(obj.out_trade_no);  
			                   // window.location.href=obj.notify_url;  
			                }else{
			                	//alert(res.err_msg);
			                	//sendMsg("您有一笔订单支付失败！");
			                	//alert(JSON.stringify(res));
								$("#errMsg").html("支付失败！");
								$("#message").show();
								$("#message").fadeOut(4000);
			                    //window.location.href=obj.notify_url;     
			                  }                     //<span style="font-family:微软雅黑;">当失败后，继续跳转该支付页面让用户可以继续付款，贴别注意不能直接调转jsp，</span><span style="font-size:10.5pt">不然会报</span><span style="font-size:12.0pt"> system:access_denied。</span>  
		                }); 
				},
				error : function(data) {
					$("#passwordArea").hide();
					$("#errMsg").html("系统繁忙，请稍后再试！");
					$("#message").show();
					$("#message").fadeOut(4000);
				}
			})
    	}
    	
    	function goClose(){
			WeixinJSBridge.call('closeWindow');
		}

	function sendMsg(msg){
		$.ajax({
			url : "../../../cgi-bin/wxpay",
			data : "method=sendMsg&msg="+msg,
			contentType: "application/x-www-form-urlencoded; charset=utf-8", 
			dataType : "json",
			type : "post",
			
			//成功后的回调函数
			success : function(data) {
			
			},
			error : function(data) {
			
			}
		})
	}
	
	function closeShowSpDiv(){
		$("#showSpDiv").hide();
	}
	
	function openShowSpDiv(){
		$("#showSpDiv").show();
	}
	
    </script>
</head>

<body>
		<section class="body">
			<!-- 号码 -->
			<div class="tel-box">
				<dl>
					<dd id="phoneNum">获取中...</dd>
					<dt id="operator">获取中...</dt>
				</dl>
			</div>
			<!-- 套餐 -->
			<div class="meal-box">
				<div class="meal-list">
					<div class="list">
						<div class="box">
							<h3>20M</h3>
							<p>售价：<span>3.00元<span></p>
							<input type="hidden" value="99_002000">
						</div>
					</div>
					<div class="list">
						<div class="box">
							<h3>30M</h3>
							<p>售价：<span>4.00元</span></p>
							<input type="hidden" value="99_003000">
						</div>
					</div>
					<div class="list">
						<div class="box">
							<h3>50M</h3>
							<p>售价：<span>6.00元</span></p>
							<input type="hidden" value="99_000501">
						</div>
					</div>
					<div class="list">
						<div class="box">
							<h3>100M</h3>
							<p>售价：<span>10.00元</span></p>
							<input type="hidden" value="99_001000">
						</div>
					</div>
					<div class="list">
						<div class="box">
							<h3>200M</h3>
							<p>售价：<span>15.00元</span></p>
							<input type="hidden" value="99_002001">
						</div>
					</div>
					<div class="list">
						<div class="box">
							<h3>300M</h3>
							<p>售价：<span>20.00元</span></p>
							<input type="hidden" value="99_003001">
						</div>
					</div>
					<div class="list">
						<div class="box">
							<h3>500M</h3>
							<p>售价：<span>30.00元</span></p>
							<input type="hidden" value="99_005000">
						</div>
					</div>
					<div class="list">
						<div class="box">
							<h3>1G</h3>
							<p>售价：<span>50.00元</span></p>
							<input type="hidden" value="99_0001G2">
						</div>
					</div>
					<div class="list" onclick="openShowSpDiv()">
						<div class="box">
							<h3>1G日包</h3>
							<p>售价：<span>5.00元</span></p>
							<input type="hidden" value="99_2100300123">
							<i class="rebate">热</i>
						</div>
					</div>
				</div>
				<a class="button" href="#" onclick="toRecharge()">立即充值<span></span></a>
				<input id="productId" name="productId" type="hidden">
				<input id="operatorValue" name="operatorValue" type="hidden">
			</div>
			<!-- 活动规则 -->
			<div class="rule-box">
				<h2>活动规则</h2>
				<ul>
					<li>用户类型：中国联通2G（黑龙江、青海除外）/3G/4G在网用户</li>
					<li>参与限制：欠费、黑名单、退网（销户），以及正在办理套餐变更、改号、转换品牌（携号转网）、离网、 虚拟运营商号码、用户信息不全、非实名制、无线上网卡的情况，无法成功获取流量</li>
					<li>订购次数：每个月同一规格流量包最多可购买5次，超过5次将无法订购成功</li>
					<li>流量属性：通用流量（立即生效，当月有效。支持全国漫游）</li>
					<li>客服QQ：3030824088</li>
				</ul>
				<p><span>*</span>本次活动最终解释权归联通宽带在线有限公司所有。</p>
			</div>
		</section>
		
		<div id="errDiv" class="layer" style="display:none" >
	        <!--<div class="mask"></div>-->
	        <div class="layer_box">
	        	<div class="layer_bdBox_count2">
	                <p class="marginT_6" id="errMsg"></p>
	            </div>
	        </div>
	    </div>
	        
	    <div id="showSpDiv" class="layer" style="display:none">
	        <div class="layer_box" style="width: 96%;margin-left: 2%;">
	        	<div class="layer_bdBox_showSp2">
	                <div class="rule-box" >
						<h1 style="text-align: center;margin-bottom: 15px;">5元1GB订购规则</h1>
						<ul style="text-align: left;">
							<li>活动时间：2016.11.01-2016.12.31</li>
							<li>1GB流量包为省内流量日包，流量日包订购成功后立即生效，当天23:59:59失效，支持联通2/3/4G用户；</li>
							<li>参与限制：欠费、黑名单、退网（销户），以及正在办理套餐变更、改号、转换品牌（携号转网）、离网、虚拟运营商号码、用户信息不全、非实名制、无线上网卡的情况，无法成功获取流量；</li>
							<li>活动期间，1GB日包流量包当日最多可购买5次，超过5次将无法订购成功；</li>
							<li>订购成功会以短信形式通知到账，敬请留意；</li>
							<li>客服 QQ：3030824088</li>
						</ul>
						<p><span>*</span>本次活动最终解释权归联通宽带在线有限公司所有。</p>
					</div>
					<a class="show_sp_div_btn" style="" href="javascript:closeShowSpDiv()">返回<span></span></a>
	            </div>
	        </div>
	    </div>
	       
		
		<script type="text/javascript">
			$(document).ready(function(){
				$(".meal-box .meal-list .list").click(function(){
					var val = $(this).children(".box").children("p").children("span").text();
					$(this).addClass("active").siblings(".list").removeClass("active");
					$(".meal-box .button span").text(val);
					var productId = $(this).children(".box").children("input").val();
					$("#productId").val(productId);
				})
			})
		</script>
	</body>
</html>