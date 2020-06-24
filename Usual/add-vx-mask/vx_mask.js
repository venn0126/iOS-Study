<!--全局缩放设置 -->
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>远鉴云考勤下载</title>

<style type="text/css"> 
*{margin:0;padding:0;}
img{max-width:100%;hright:100%;}
</style>


<!--全局url -->
<script type="text/javascript">
        function is_weixin() {
            var ua = navigator.userAgent.toLowerCase();
            if (ua.match(/MicroMessenger/i) == "micromessenger") {
                return true;
            } else {
                return false;
            }
        }
        var isWeixin = is_weixin();
        var winHeight = typeof window.innerHeight != 'undefined' ? window.innerHeight : document.documentElement.clientHeight;
        function loadHtml(){
                var div = document.createElement('div');
                div.id = 'weixin-tip';
                //遮罩图片
                div.innerHTML = '<p><img src="https://developer.fosafer.com/static/app/vx_mask/mask_iOS.png"/></p>';
                document.body.appendChild(div);
        }

        function loadStyleText(cssText) {
            var style = document.createElement('style');
            style.rel = 'stylesheet';
            style.type = 'text/css';
            try {
                style.appendChild(document.createTextNode(cssText));
            } catch (e) {
                style.styleSheet.cssText = cssText; //ie9以下
            }
            var head=document.getElementsByTagName("head")[0]; //head标签之间加上style样式
            head.appendChild(style);
        }

        var cssText = "#weixin-tip{position: fixed; left:0; top:0; background: rgba(0,0,0,0.3); filter:alpha(opacity=30); width: 100%; height:100%; z-index: 100;} #weixin-tip p{text-align: center;}";
        if(isWeixin){
            loadHtml();
            loadStyleText(cssText);
        }
</script>

