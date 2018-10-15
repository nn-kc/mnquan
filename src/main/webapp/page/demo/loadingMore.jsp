<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <title>iScroll 实例：下拉刷新，滚动翻页</title>
    <style type="text/css" media="all">
        body,ul,li {
            padding:0;
            margin:0;
            border:0;
        }

        body {
            font-size:12px;
            -webkit-user-select:none;
            -webkit-text-size-adjust:none;
            font-family:helvetica;
        }

        #header {
            position:absolute;
            top:0; left:0;
            width:100%;
            height:45px;
            line-height:45px;
            background-image:-webkit-gradient(linear, 0 0, 0 100%, color-stop(0, #fe96c9), color-stop(0.05, #d51875), color-stop(1, #7b0a2e));
            background-image:-moz-linear-gradient(top, #fe96c9, #d51875 5%, #7b0a2e);
            background-image:-o-linear-gradient(top, #fe96c9, #d51875 5%, #7b0a2e);
            padding:0;
            color:#eee;
            font-size:20px;
            text-align:center;
        }

        #header a {
            color:#f3f3f3;
            text-decoration:none;
            font-weight:bold;
            text-shadow:0 -1px 0 rgba(0,0,0,0.5);
        }

        #footer {
            position:absolute;
            bottom:0; left:0;
            width:100%;
            height:48px;
            background-image:-webkit-gradient(linear, 0 0, 0 100%, color-stop(0, #999), color-stop(0.02, #666), color-stop(1, #222));
            background-image:-moz-linear-gradient(top, #999, #666 2%, #222);
            background-image:-o-linear-gradient(top, #999, #666 2%, #222);
            padding:0;
            border-top:1px solid #444;
        }

        #wrapper {
            position:absolute; z-index:1;
            top:45px; bottom:48px; left:0;
            width:100%;
            background:#555;
            overflow:auto;
        }

        #scroller {
            position:relative;
            /* -webkit-touch-callout:none;*/
            -webkit-tap-highlight-color:rgba(0,0,0,0);

            float:left;
            width:100%;
            padding:0;
        }

        #scroller ul {
            position:relative;
            list-style:none;
            padding:0;
            margin:0;
            width:100%;
            text-align:left;
        }

        #scroller li {
            padding:0 10px;
            height:40px;
            line-height:40px;
            border-bottom:1px solid #ccc;
            border-top:1px solid #fff;
            background-color:#fafafa;
            font-size:14px;
        }

        #scroller li > a {
            display:block;
        }

        /**
         *
         * 下拉样式 Pull down styles
         *
         */
        #pullDown, #pullUp {
            background:#fff;
            height:40px;
            line-height:40px;
            padding:5px 10px;
            border-bottom:1px solid #ccc;
            font-weight:bold;
            font-size:14px;
            color:#888;
        }
        #pullDown .pullDownIcon, #pullUp .pullUpIcon {
            display:block; float:left;
            width:40px; height:40px;
            background:url(pull-icon@2x.png) 0 0 no-repeat;
            -webkit-background-size:40px 80px; background-size:40px 80px;
            -webkit-transition-property:-webkit-transform;
            -webkit-transition-duration:250ms;
        }
        #pullDown .pullDownIcon {
            -webkit-transform:rotate(0deg) translateZ(0);
        }
        #pullUp .pullUpIcon {
            -webkit-transform:rotate(-180deg) translateZ(0);
        }


        /**
         * 动画效果css3代码
         */
        #pullDown.flip .pullDownIcon {
            -webkit-transform:rotate(-180deg) translateZ(0);
        }

        #pullUp.flip .pullUpIcon {
            -webkit-transform:rotate(0deg) translateZ(0);
        }

        #pullDown.loading .pullDownIcon, #pullUp.loading .pullUpIcon {
            background-position:0 100%;
            -webkit-transform:rotate(0deg) translateZ(0);
            -webkit-transition-duration:0ms;

            -webkit-animation-name:loading;
            -webkit-animation-duration:2s;
            -webkit-animation-iteration-count:infinite;
            -webkit-animation-timing-function:linear;
        }

        @-webkit-keyframes loading {
            from { -webkit-transform:rotate(0deg) translateZ(0); }
            to { -webkit-transform:rotate(360deg) translateZ(0); }
        }

    </style>
</head>
<body>
<div id="header">
    <a href="../db.html#page2">iScroll实例：下拉刷新，滚动翻页</a>
</div>

<div id="wrapper">
    <div id="scroller">

        <div id="pullDown">
            <span class="pullDownIcon"></span><span class="pullDownLabel">下拉刷新...</span>
        </div>

        <ul id="thelist">
            <li>我是三冰 1</li>
            <li>我是三冰 2</li>
            <li>我是三冰 3</li>
            <li>我是三冰 4</li>
            <li>我是三冰 5</li>
            <li>我是三冰 6</li>
            <li>我是三冰 7</li>
            <li>我是三冰 8</li>
            <li>我是三冰 9</li>
            <li>我是三冰 10</li>
            <li>我是三冰 11</li>
            <li>我是三冰 12</li>
            <li>我是三冰 13</li>
        </ul>

        <div id="pullUp">
            <span class="pullUpIcon"></span><span class="pullUpLabel">上拉加载更多...</span>
        </div>

    </div>
</div>


<div id="footer"></div>

<script type="application/javascript" src="iscroll.js"></script>

<script type="text/javascript">

    var myScroll,
        pullDownEl, pullDownOffset,
        pullUpEl, pullUpOffset,
        generatedCount = 0;

    /**
     * 下拉刷新 （自定义实现此方法）
     * myScroll.refresh();  // 数据加载完成后，调用界面更新方法
     */
    function pullDownAction () {
        setTimeout(function () { // <-- Simulate network congestion, remove setTimeout from production!
            var el, li, i;
            el = document.getElementById('thelist');

            for (i=0; i<3; i++) {
                li = document.createElement('li');
                li.innerText = '添加三冰 ' + (++generatedCount);
                el.insertBefore(li, el.childNodes[0]);
            }

            myScroll.refresh();  //数据加载完成后，调用界面更新方法 Remember to refresh when contents are loaded (ie: on ajax completion)
        }, 1000); // <-- Simulate network congestion, remove setTimeout from production!
    }

    /**
     * 滚动翻页 （自定义实现此方法）
     * myScroll.refresh();  // 数据加载完成后，调用界面更新方法
     */
    function pullUpAction () {
        setTimeout(function () { // <-- Simulate network congestion, remove setTimeout from production!
            var el, li, i;
            el = document.getElementById('thelist');

            for (i=0; i<3; i++) {
                li = document.createElement('li');
                li.innerText = '添加三冰 ' + (++generatedCount);
                el.appendChild(li, el.childNodes[0]);
            }

            myScroll.refresh();  // 数据加载完成后，调用界面更新方法 Remember to refresh when contents are loaded (ie: on ajax completion)
        }, 1000); // <-- Simulate network congestion, remove setTimeout from production!
    }

    /**
     * 初始化iScroll控件
     */
    function loaded() {
        pullDownEl = document.getElementById('pullDown');
        pullDownOffset = pullDownEl.offsetHeight;
        pullUpEl = document.getElementById('pullUp');
        pullUpOffset = pullUpEl.offsetHeight;

        myScroll = new iScroll('wrapper', {
            scrollbarClass: 'myScrollbar', /* 重要样式 */
            useTransition: false, /* 此属性不知用意，本人从true改为false */
            topOffset: pullDownOffset,
            onRefresh: function () {
                if (pullDownEl.className.match('loading')) {
                    pullDownEl.className = '';
                    pullDownEl.querySelector('.pullDownLabel').innerHTML = '下拉刷新...';
                } else if (pullUpEl.className.match('loading')) {
                    pullUpEl.className = '';
                    pullUpEl.querySelector('.pullUpLabel').innerHTML = '上拉加载更多...';
                }
            },
            onScrollMove: function () {
                if (this.y > 5 && !pullDownEl.className.match('flip')) {
                    pullDownEl.className = 'flip';
                    pullDownEl.querySelector('.pullDownLabel').innerHTML = '松手开始更新...';
                    this.minScrollY = 0;
                } else if (this.y < 5 && pullDownEl.className.match('flip')) {
                    pullDownEl.className = '';
                    pullDownEl.querySelector('.pullDownLabel').innerHTML = '下拉刷新...';
                    this.minScrollY = -pullDownOffset;
                } else if (this.y < (this.maxScrollY - 5) && !pullUpEl.className.match('flip')) {
                    pullUpEl.className = 'flip';
                    pullUpEl.querySelector('.pullUpLabel').innerHTML = '松手开始更新...';
                    this.maxScrollY = this.maxScrollY;
                } else if (this.y > (this.maxScrollY + 5) && pullUpEl.className.match('flip')) {
                    pullUpEl.className = '';
                    pullUpEl.querySelector('.pullUpLabel').innerHTML = '上拉加载更多...';
                    this.maxScrollY = pullUpOffset;
                }
            },
            onScrollEnd: function () {
                if (pullDownEl.className.match('flip')) {
                    pullDownEl.className = 'loading';
                    pullDownEl.querySelector('.pullDownLabel').innerHTML = '加载中...';
                    pullDownAction(); // Execute custom function (ajax call?)
                } else if (pullUpEl.className.match('flip')) {
                    pullUpEl.className = 'loading';
                    pullUpEl.querySelector('.pullUpLabel').innerHTML = '加载中...';
                    pullUpAction(); // Execute custom function (ajax call?)
                }
            }
        });

        setTimeout(function () { document.getElementById('wrapper').style.left = '0'; }, 800);
    }

    //初始化绑定iScroll控件
    document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);
    document.addEventListener('DOMContentLoaded', loaded, false);

</script>
</body>
</html>