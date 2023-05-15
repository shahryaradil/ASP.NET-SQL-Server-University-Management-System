using System;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI.WebControls;

namespace DB_Project.Pages
{
    public partial class Home : System.Web.UI.Page
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
                    labelRollNo.Text = userId;
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

                query = "SELECT [degreeProgram] FROM [STUDENTS] WHERE [userID] = @username";
                cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@username", userId);

                dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    labelProgram.Text = dr["degreeProgram"].ToString();
                }
                dr.Close();

                query = "SELECT CAST(ROUND((SELECT SUM(CASE WHEN G.grade IN ('A+', 'A') THEN 4.0 WHEN G.grade = 'A-' THEN 3.67 WHEN G.grade = 'B+' THEN 3.33 WHEN G.grade = 'B' THEN 3.0 WHEN G.grade = 'B-' THEN 2.67 WHEN G.grade = 'C+' THEN 2.33 WHEN G.grade = 'C' THEN 2.0 WHEN G.grade = 'C-' THEN 1.67 WHEN G.grade = 'D+' THEN 1.33 WHEN G.grade = 'D' THEN 1.0 WHEN G.grade = 'F' THEN 0.0 ELSE 0.0 END * C.creditHrs) FROM GRADES G JOIN COURSES C ON G.courseCode = C.courseCode WHERE G.studentID = S.userID) / (SELECT SUM(C.creditHrs) FROM COURSES C JOIN COURSETAKING CT ON CT.courseCode = C.courseCode WHERE CT.studentID = S.userID), 2) AS DECIMAL(10,2)) AS GPA FROM STUDENTS S JOIN USERS U ON S.userID = U.userID JOIN STUDENTRECORD SR ON S.userID = SR.studentID WHERE S.userID = @username GROUP BY S.userID, U.name, S.degreeProgram, SR.currentSemester, SR.creditHrs";
                cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@username", userId);

                dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    labelGPA.Text = dr["GPA"].ToString();
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
