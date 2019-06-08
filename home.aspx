<%@ Page Language="C#" AutoEventWireup="true" CodeFile="home.aspx.cs" Inherits="home" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

   <meta charset="utf-8"/>
      <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
      <!--上面这句在WebApp网页开发中很重要，意思是让手机浏览器按屏幕分辨率自适应缩放字体，避免页面元素过小，同时禁止用户用手指缩放浏览器窗口-->
      <title></title>
      <link href="https://cdn.bootcss.com/mui/3.4.0/css/mui.min.css" rel="stylesheet"/>
      <script type="text/javascript" src="https://cdn.bootcss.com/mui/3.4.0/js/mui.min.js"></script>
      <!--上面两行引入mui的css库和js库，直接调用网络上的资源，就不用自己下载到本地了，十分方便，但必须联网才能正常运行-->
      <style type="text/css">
        body{
        width: 100%;
        height: 736px;
        font-family:"微软雅黑";
        background-image: url("image/homeImage.jpg");
        background-size: 100%;
        background-repeat: no-repeat;
       
        }
        
        #imageChat
        {
            background-image:url("image/test.jpg");
            width:70px;
            height:74px;
         }
        #myImage
        {
           background-image:url("image/test.jpg"); 
           height:40vw; 
         }
      </style>



      <!--这个接下来写关于Ajax的代码，为了接受来自后台的数据-->
    <!--  <script type="text/javascript">
          function showName() {
              var xmlhttp;
              if (window.XMLHttpRequest) {
                  //  IE7+, Firefox, Chrome, Opera, Safari 浏览器执行代码
                  xmlhttp = new XMLHttpRequest();
              }
              else {
                  // IE6, IE5 浏览器执行代码
                  xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
              }
              xmlhttp.onreadystatechange = function () {
                  if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                      document.getElementById("myDiv").innerHTML = xmlhttp.responseText;
                      //这个是将后台的数据传过来的关键
                  }
              }
              xmlhttp.open("GET", "loginhandler.aspx", true);
              xmlhttp.send();
          }
      </script> -->

   <!--   <script type="text/javascript">

          function GetSession(value) {
              var temp;
              jQuery.ajax({
                  type: "POST",
                  url: "loginhandler.aspx",
                  async: false, //是否ajax同步
                  data: "s=" + value,
                  success: function (msg) {
                      temp = msg;
                  }
              });
              return document.getElementById("myDiv").innerHTML=temp;
          }
          //这个是从服务器，讲用户名调到客服端

      </script>
      -->



    <!--这个是论坛的页面-->

      <script type="text/javascript">
          function addElement() {
              //创建TextNode节点
             
              var person = document.createTextNode(form1.person.value);
              var content = document.createTextNode(form1.content.value);
              //创建td类型的Element节点
              var td_person = document.createElement("td");
              var td_content = document.createElement("td");
              var tr = document.createElement("tr"); //创建一个tr类型的Element节点
              var tbody = document.createElement("tbody"); //创建一个tbody类型的Element节点
              //将TextNode节点加入到td类型的节点中
              td_person.appendChild(person);
              td_content.appendChild(content);
              //将td类型的节点添加到tr节点中
              tr.appendChild(td_person);
              tr.appendChild(td_content);
              tbody.appendChild(tr); //将tr节点加入tbody中
              var tComment = document.getElementById("comment"); //获取table对象
              tComment.appendChild(tbody); //将节点tbody加入节点尾部
              form1.person.value = "";  //清空评论人文本框
              form1.content.value = "";     //清空评论内容文本框
          }
          //删除第一条评论
          function deleteFirstE() {
              var tComment = document.getElementById("comment"); //获取table对象
              if (tComment.rows.length > 1) {
                  tComment.deleteRow(1);      //删除表格的第二行，即第一条评论，
              }
          }
          //删除最后一条评论
          function deleteLastE() {
              var tComment = document.getElementById("comment"); //获取table对象
              if (tComment.rows.length > 1) {
                  tComment.deleteRow(tComment.rows.length - 1); //删除表格的最后一行，即最后一条评论
              }
          }
  </script>
    </head>

  <body>
    <nav class="mui-bar mui-bar-tab">
      <!--class为mui-bar mui-bar-tab的元素，会呈现固定在底部的选项卡，是App常用的底部导航栏-->
      <a class="mui-tab-item mui-active" href="#tab1">
        <!--class为mui-tab-item的元素是选项卡的一个选项，带有mui-active意味着它是默认被选中的，颜色高亮。href属性的值会和后面的元素对应，比如：该选项卡的href为#tab1（注意要有井号，这是css规定的），意味着点击它后，会显示后面一个id为tab1的元素的内容。当然，我们也可以把它连接到另一个页面，比如href="pagexxx.html" -->
        <span class="mui-icon mui-icon-chat"></span>
        <!--上面是这个选项卡的图标-->
        <span class="mui-tab-label">论坛</span>
        <!--上面是这个选项卡的文字-->
      </a>
      <a class="mui-tab-item" href="#tab2">
        <span class="mui-icon mui-icon-contact"></span>
        <span class="mui-tab-label">我的</span>
      </a>
    </nav>


    <!--聊天室-->

    <div class="mui-control-content mui-active"style =" background-color:transparent;border:none;">
      <div id="tab1" class="mui-control-content">
          <table width="600" height="70" border="0" align="center" cellpadding="0" cellspacing="1" bordercolorlight="#FF9933" bordercolordark="#FFFFFF" bgcolor="#666666">
  <thead>
    <tr>
      <td width="14%" align="center" bgcolor="#FFFFFF"id="imageChat"></td>
      <td width="86%" align="left" bgcolor="#FFFFFF">&nbsp;理想型告白你会和你的现任分手吗？</td>
    </tr>
  </thead>
</table>
<br>
<table width="600" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#FFFFFF" bordercolorlight="#666666" bordercolordark="#FFFFFF" id="comment">
  <tr>
    <td width="18%" height="27" align="center" bgcolor="#E5BB93">评论人</td>
    <td width="82%" align="center" bgcolor="#E5BB93">评论内容</td>
  </tr>
</table>
<form name="form1" method="post" action="">    
  <table  height="122" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td width="119" height="14">&nbsp;</td>
      <td width="481">&nbsp;</td>
    </tr>
    <tr>
      <td height="27" align="center">评 论 人：</td>
      <td>
        
       <input name="person" type="text" id="person" size="40"/>

      </td>
    </tr>
    <tr>
      <td align="center">评论内容：</td>
      <td><textarea name="content" cols="60" rows="6" id="content"></textarea></td>
    </tr>
    <tr>
      <td height="40" width="100">&nbsp;</td>
      <td><input name="Button" type="button" class="btn_grey" value="发表" onClick="addElement()"/>
      &nbsp;
      <input name="Reset" type="reset" class="btn_grey" value="重置"/>
      &nbsp;
      <input name="Button" type="button" class="btn_grey" value="删除第一条评论" onClick="deleteFirstE()"/>
      &nbsp;
      <input name="Button" type="button" class="btn_grey" value="删除最后一条评论" onClick="deleteLastE()"/></td>
    </tr>
  </table>
  </form>


        
      </div>



      <!--这是个人主页的内容-->
      <div id="tab2" class="mui-control-content"style =" background-color:transparent;border:none;">
        <div class="mui-content" style =" background-color:transparent;border:none;" >
          <!--当页面存在顶端固定的标题栏（header）时，下面的内容会被标题栏遮住一部分，若不想被遮住，需要在下面的内容外面套一个class为mui-content的div-->
          
          
          
          
          
          
          
          
          
          <!--这个用来显示登录头像的-->
          <form id="form2" runat="server" method="post" >
            <div>
                    <table>
                        <tr>
                            <td colspan="2" style="height: 21px">
                     
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 400px">
                                <asp:FileUpload ID="FileUpload1" runat="server" />
                                 <asp:Label ID="label1" runat="server" ForeColor="Red"></asp:Label>
                            </td>
                            <td style="width: 80px">
                                <asp:Button ID="UploadButton" runat="server" Text="上传图片"  type="submit"/>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center">
                                <br />
                                <br />
                                <asp:Image ID="Image1" runat="server" Height="250px" Width="400px" />
                            </td>
                        </tr>
                    </table>
                </div>
               </form>
         











          <!--这个用来显示用户名-->
          <div class="mui-card">
           <div class="mui-card-header" id="myDiv"><asp:Literal ID="Literal1" runat="server"></asp:Literal></div>
           
          </div>
        </div>
      </div>

    </div>
  </body>
</html>










