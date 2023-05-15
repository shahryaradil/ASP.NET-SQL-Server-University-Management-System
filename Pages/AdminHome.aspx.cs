using System;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI.WebControls;

namespace DB_Project.Pages
{
    public partial class AdminHome : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlConnection conn = new SqlConnection("Data Source=DESKTOP-O9EM53U\\SQLEXPRESS;Initial Catalog=DBPROJECT;Integrated Security=True");
            conn.Open();
            if (Request.Cookies["UserInfo"] != null)
            {
                string userId = Request.Cookies["UserInfo"]["ID"];

                string query = "SELECT [name] FROM [USERS] WHERE [userID] = @username";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@username", userId);

                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    labelUserId.Text = userId.ToString();
                    labelName.Text = dr["name"].ToString();
                }
                dr.Close();

                query = "SELECT FORMAT([DOB], 'dd-MM-yy') as DOB FROM [USERS] WHERE [userID] = @username";
                cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@username", userId);

                dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    labelDOB.Text = dr["DOB"].ToString();
                }
                dr.Close();

                query = "SELECT [email] FROM [USERS] WHERE [userID] = @username";
                cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@username", userId);

                dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    labelEmail.Text = dr["email"].ToString();
                }
                dr.Close();

                query = "SELECT [phone] FROM [USERS] WHERE [userID] = @username";
                cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@username", userId);

                dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    labelPhone.Text = dr["phone"].ToString();
                }
                dr.Close();

                query = "SELECT [campus] FROM [USERS] WHERE [userID] = @username";
                cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@username", userId);

                dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    labelCampus.Text = dr["campus"].ToString();
                }
                dr.Close();

                query = "SELECT [address] FROM [USERS] WHERE [userID] = @username";
                cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@username", userId);

                dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    labelAddress.Text = dr["address"].ToString();
                }

                dr.Close();
            }
            conn.Close();
        }
    }
}