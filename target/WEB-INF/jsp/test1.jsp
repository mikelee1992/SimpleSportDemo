<%@ page language="java" contentType="text/html; UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
    <title>test1</title>
    <style type="text/css">
        * {
            margin: 0px;
            padding: 0px;
        }

        #div1 {
            width: 50px;
            height: 50px;
            background-color: red;
            border: 1px solid black;
            position: absolute;
        }
    </style>
    <script type="text/javascript" src="../../ajax/my-ajax.js"></script>
    <script type="text/javascript" charset="UTF-8">
        function clearTimer(timer) {
            if (timer) {
                clearInterval(timer);
                timer = null;
            }
        }

        window.onload = function () {
            var oDiv1 = document.getElementById('div1');
            var oBtn1 = document.getElementById('btn1');

            var div1Timer = null;
            oBtn1.onclick = function () {
                if (oDiv1.offsetLeft >= 300) {
                    clearInterval(div1Timer);
                    div1Timer = null;
                    return;
                } else {
                    clearInterval(div1Timer);
                    div1Timer = null;
                    div1Timer = setInterval(function () {
                        if (oDiv1.offsetLeft < 300) {
                            var iSpeed = 5;
                            oDiv1.style.left = oDiv1.offsetLeft + iSpeed + 'px';
                        }
                    }, 30);
                }
            };

            var oBtn2 = document.getElementById('btn2');
            var iDiv1Left = oDiv1.offsetLeft;
            var iDiv1Top = oDiv1.offsetTop;
            oBtn2.onclick = function () {
                clearTimer(div1Timer);
                oDiv1.style.left = iDiv1Left + 'px';
                oDiv1.style.top = iDiv1Top + 'px';
            };
        };
    </script>
</head>
<body>
<input id="btn1" type="button" value="移动"/>
<input id="btn2" type="button" value="复位"/><br/>

<div id="div1"></div>

</body>
</html>