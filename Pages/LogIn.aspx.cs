using System;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI.WebControls;

namespace DB_Project.Pages
{
    public partial class LoginPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            SqlConnection conn = new SqlConnection("Data Source=DESKTOP-O9EM53U\\SQLEXPRESS;Initial Catalog=DBPROJECT;Integrated Security=True");
            conn.Open();

            TextBox txtUsername = (TextBox)FindControl("username");
            TextBox txtPassword = (TextBox)FindControl("password");

            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            string query = "SELECT * FROM LOGINDETAILS WHERE userID = @username AND Password = @password";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@username", username);
            cmd.Parameters.AddWithValue("@password", password);

            HttpCookie cookie = new HttpCookie("UserInfo");

            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                cookie["ID"] = username;
                Response.Cookies.Add(cookie);
                dr.Close();

                DropDownList userTypeDropdown = (DropDownList)FindControl("userType");
                string userType = userTypeDropdown.SelectedValue;

                switch (userType)
                {
                    case "admin":
                        query = "SELECT * FROM LOGINDETAILS LD JOIN USERS U ON LD.userID = U.userID JOIN ACADEMICOFFICERS S ON LD.userID = S.userID WHERE U.userID = @username AND LD.password = @password";
                        break;
                    case "faculty":
                        query = "SELECT * FROM LOGINDETAILS LD JOIN USERS U ON LD.userID = U.userID JOIN FACULTY S ON LD.userID = S.userID WHERE U.userID = @username AND LD.password = @password";
                        break;
                    case "student":
                        query = "SELECT * FROM LOGINDETAILS LD JOIN USERS U ON LD.userID = U.userID JOIN STUDENTS S ON LD.userID = S.userID WHERE U.userID = @username AND LD.password = @password";
                        break;
                }

                SqlCommand cmdCheckLogin = new SqlCommand(query, conn);
                cmdCheckLogin.Parameters.AddWithValue("@username", username);
                cmdCheckLogin.Parameters.AddWithValue("@password", password);

                SqlDataReader drCheckLogin = cmdCheckLogin.ExecuteReader();
                if (drCheckLogin.Read())
                {
                    switch (userType)
                    {
                        case "admin":
                            Response.Redirect("AdminHome.aspx");
                            break;
                        case "faculty":
                            Response.Redirect("FacultyHome.aspx");
                            break;
                        case "student":
                            Response.Redirect("Home.aspx");
                            break;
                    }
                }
                else
                {
                    lblError.Text = "Invalid username or password. Please try again.";
                }
                drCheckLogin.Close();
            }
            else
            {
                lblError.Text = "Invalid username or password. Please try again.";
            }
            dr.Close();
            conn.Close();
        }
    }
}
