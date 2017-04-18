function ajax(url, fnSuccess, fnFail) {
    /* 1、创建ajax对象 */
    var oAjax = null;
    if (window.XMLHttpRequest) {
        oAjax = new XMLHttpRequest();
    } else {
        oAjax = new ActiveXObject('Microsoft.XMLHTTP');
    }
    /* 2、连接服务器 */
    oAjax.open('GET', url, true);
    /* 3、发送请求 */
    oAjax.send();
    /* 4、处理服务器响应 */
    oAjax.onreadystatechange = function () {
        if (oAjax.readyState == 4) {
            if (oAjax.status == 200) {
                fnSuccess(oAjax.responseText);
            } else {
                if (fnFail) {
                    fnFail();
                }
            }
        }
    };
}