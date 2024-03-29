﻿using System;
using System.Data.OleDb;
//上面引入了两个命名空间，因为后面用到的对象隶属于这两个命名空间。比如下面的OleDbConnection，隶属于System.Data.OleDb命名空间。当然在这里也可以不引入命名空间，在下面写System.Data.OleDb.OleDbConnection，只是比较长而已。

public partial class loginhandler : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e) //Page_Load是页面加载事件，在本动态网页一加载时就执行其中的内容
    {
        string InputAccount = Request["account"];
        string InputPassword = Request["password"];
        //上面两句声明了两个字符串类型的变量（账号和密码），并用Request方法把前台login.html传过来的account和password两个表单元素的值取过来。注意引号里面的account和password来自前台login.html的两个input控件的名字，即name属性的值。

       

       // Console.WriteLine(InputAccount);
       // string sessionName = "";
      //  sessionName = InputAccount;
      //  Response.Write(Session[sessionName]);
        Session["name"] = InputAccount;

        OleDbConnection Conn = new OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" + Server.MapPath("AppDate/test.mdb"));
        Conn.Open();
        //上面两句建立Access数据库连接，属于固定用法，可修改*.mdb路径和文件名

        OleDbCommand Cmd = new OleDbCommand("Select * From [Users] Where [Account]='" + InputAccount + "' And [Password]='" + InputPassword + "'", Conn);
        //上面一句的意思是执行SQL语句，属于固定用法，可修改引号里面的SQL语句，注意这里的SQL是拼出来的，用固定字符串和InputAccount、InputPassword变量的值拼出来的。

        OleDbDataReader DataReader = Cmd.ExecuteReader();
        //上面一句的意思是把执行SQL语句所得到的结果赋值给一个叫做DataReader的对象，后面我们可以用DataReader["字段名"]来获取数据库里面的数据。

        if (DataReader.Read()) //.Read()方法的意思是从数据库里读取记录，如果读取到（即用户前台输入的账号密码是对的）则返回真，没有读取到（即用户前台输入的账号密码是错的）则返回假
        {
            Session["UserName"] = DataReader["Account"];
            Session["UserID"] = DataReader["UserID"];

            //Session相当于一个全局变量，赋值后在网站其他页面中都可以调用，此处是登录成功后把用户账号记下来。
            Conn.Close(); //关闭数据库连接，用以节约服务器资源。
            Response.Redirect("home.aspx"); //若登录成功，转向list.aspx页面
        }
        else
        {
            Conn.Close(); //关闭数据库连接，用以节约服务器资源。
            Response.Redirect("loginfailed.html"); //若登录失败，转向loginfailed.html页面
        }
    }
}