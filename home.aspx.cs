using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.OleDb;
using System.IO;

public partial class home : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //这个是记录登录时的用户名，可以在前端显示
        Literal1.Text =  Session["UserName"].ToString();
        string UserID = Session["UserID"].ToString();
        string strSel = "Select [store] From [myImage] Where [UserID]= '" + UserID + "'";
        //查询用户登录时的Id，为了看这个之是否为空，如果为空值，则需要上传照片
        OleDbConnection Conn = new OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" + Server.MapPath("AppDate/test.mdb"));
        Conn.Open();
        //上面两句建立Access数据库连接，属于固定用法，可修改*.mdb路径和文件名
        OleDbCommand Sel = new OleDbCommand(strSel, Conn);
        OleDbDataReader DataReader = Sel.ExecuteReader();
        //上面一句的意思是把执行SQL语句所得到的结果赋值给一个叫做DataReader的对象，后面我们可以用DataReader["字段名"]来获取数据库里面的数据。

        if (DataReader.Read()) //.Read()方法的意思是从数据库里读取记录，如果读取到用户的信息则返回真，没有读取到则返回假
        {

            Session["ImagePath"] = DataReader["store"];
            string ImagePath = Session["ImagePath"].ToString();
            //Session相当于一个全局变量，赋值后在网站其他页面中都可以调用，此处是将图片的路径记录下来了
            string uerImage = ImagePath;//获取图片物理地址

            Image1.Visible = true;
            Image1.ImageUrl = ImagePath;//界面显示图片
            Conn.Close(); //关闭数据库连接，用以节约服务器资源。

        }
        else
        {
            try
            {

                {
                    string FullName = FileUpload1.PostedFile.FileName;//获取图片物理地址

                    FileInfo fi = new FileInfo(FullName);

                    string name = fi.Name;//获取图片名称

                    string type = fi.Extension;//获取图片类型

                    if (type == ".jpg" || type == ".gif" || type == ".bmp" || type == ".png")

                    {

                        string SavePath = Server.MapPath("image");//图片保存到文件夹下
                        this.FileUpload1.PostedFile.SaveAs(SavePath +"/"+ name);//保存路径
                        
                        this.Image1.Visible = true;
                        this.Image1.ImageUrl ="image" + "/" + name;//界面显示图片
                        string strSQL = "INSERT INTO [myImage]([name] , [course],[store],[UserID] ) VALUES('" + name + "','" + type + "','" + "image"+"/"+ name + "','" + UserID + "')";
                        //这个时数据库的插入操作

                        OleDbCommand Cmd = new OleDbCommand(strSQL, Conn);
                        //上面一句的意思是执行SQL语句，属于固定用法，可修改引号里面的SQL语句，注意这里的SQL是拼出来的，用固定字符串和InputAccount、InputPassword变量的值拼出来的。

                        int count = Cmd.ExecuteNonQuery();
                        //执行操作，并记录被影响的行数；
                        if (count > 0) //.Read()方法的意思是从数据库里读取记录，如果读取到（即用户前台输入的账号密码是对的）则返回真，没有读取到（即用户前台输入的账号密码是错的）则返回假
                        {
                            this.label1.Text = "上传成功";
                            Conn.Close(); //关闭数据库连接，用以节约服务器资源。
                        }
                        else
                        {
                            this.label1.Text = "照片上传失败。请重新上传！";
                            Console.WriteLine("添加失败！");
                            Conn.Close(); //关闭数据库连接，用以节约服务器资源。
                        }

                    }
                    else
                    {
                        this.label1.Text = "请选择正确的格式图片";
                        Console.WriteLine("添加失败！");
                        Conn.Close(); //关闭数据库连接，用以节约服务器资源。
                    }

                }

            }
            catch (Exception ex)

            {

                Response.Write(ex.Message);

            }
        }
    }
}