using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace DB_Project.Pages
{
    public partial class EvaluationReport2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            UpdateSemesterTable(sender, e);
        }

        protected void UpdateSemesterTable(object sender, EventArgs e)
        {
            string courseCodeValue = Request.QueryString["courseCode"];

            string connectionString = "Data Source=DESKTOP-O9EM53U\\SQLEXPRESS;Initial Catalog=DBPROJECT;Integrated Security=True";
            string userId = Request.Cookies["UserInfo"]["ID"];
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string query = "SELECT MARKS.STUDENTID, USERS.NAME, ASSESMENTTYPE, TOTALMARKS, OBTAINEDMARKS FROM MARKS INNER JOIN USERS ON MARKS.STUDENTID = USERS.USERID INNER JOIN COURSETAKING ON COURSETAKING.COURSECODE = MARKS.COURSECODE INNER JOIN COURSETEACHING ON COURSETEACHING.COURSECODE = MARKS.COURSECODE WHERE MARKS.COURSECODE = @course AND COURSETEACHING.TEACHERID = @username";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@username", userId);
                command.Parameters.AddWithValue("@course", courseCodeValue);
                SqlDataReader reader = command.ExecuteReader();

                transcriptTableBody.Controls.Clear();

                while (reader.Read())
                {
                    TableRow row = new TableRow();
                    TableCell cell1 = new TableCell();
                    TableCell cell2 = new TableCell();
                    TableCell cell3 = new TableCell();
                    TableCell cell4 = new TableCell();
                    TableCell cell5 = new TableCell();
                    cell1.Text = reader["STUDENTID"].ToString();
                    cell2.Text = reader["NAME"].ToString();
                    cell3.Text = reader["ASSESMENTTYPE"].ToString();
                    cell4.Text = reader["TOTALMARKS"].ToString();
                    cell5.Text = reader["OBTAINEDMARKS"].ToString();

                    row.Cells.Add(cell1); ;
                    row.Cells.Add(cell2);
                    row.Cells.Add(cell3);
                    row.Cells.Add(cell4);
                    row.Cells.Add(cell5);

                    transcriptTableBody.Controls.Add(row);
                }

                reader.Close();
            }
        }
    }
}