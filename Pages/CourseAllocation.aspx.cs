using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace DB_Project.Pages
{
    public partial class CourseAllocation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            UpdateTable(sender, e);
        }

        protected void UpdateTable(object sender, EventArgs e)
        {
            string connectionString = "Data Source=DESKTOP-O9EM53U\\SQLEXPRESS;Initial Catalog=DBPROJECT;Integrated Security=True";
            string userId = Request.Cookies["UserInfo"]["ID"];
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string query = "SELECT COURSETEACHING.COURSECODE, COURSENAME, SECTIONNAME, CREDITHRS, NAME FROM COURSETEACHING INNER JOIN COURSES ON COURSETEACHING.COURSECODE = COURSES.COURSECODE INNER JOIN SECTIONS ON COURSETEACHING.SECTIONID = SECTIONS.SECTIONID INNER JOIN USERS ON COURSETEACHING.TEACHERID = USERS.USERID";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@username", userId);
                SqlDataReader reader = command.ExecuteReader();

                table.Controls.Clear();

                TableHeaderRow headerRow = new TableHeaderRow();
                TableHeaderCell headerCell1 = new TableHeaderCell();
                TableHeaderCell headerCell2 = new TableHeaderCell();
                TableHeaderCell headerCell3 = new TableHeaderCell();
                TableHeaderCell headerCell4 = new TableHeaderCell();
                TableHeaderCell headerCell5 = new TableHeaderCell();
                headerCell1.Text = "Course Code";
                headerCell2.Text = "Course Name";
                headerCell3.Text = "Credit Hours";
                headerCell4.Text = "Section";
                headerCell5.Text = "Instructor";

                headerRow.Cells.Add(headerCell1);
                headerRow.Cells.Add(headerCell2);
                headerRow.Cells.Add(headerCell3);
                headerRow.Cells.Add(headerCell4);
                headerRow.Cells.Add(headerCell5);

                table.Controls.Add(headerRow);

                while (reader.Read())
                {
                    TableRow row = new TableRow();
                    TableCell cell1 = new TableCell();
                    TableCell cell2 = new TableCell();
                    TableCell cell3 = new TableCell();
                    TableCell cell4 = new TableCell();
                    TableCell cell5 = new TableCell();
                    cell1.Text = reader["COURSECODE"].ToString();
                    cell2.Text = reader["COURSENAME"].ToString();
                    cell3.Text = reader["CREDITHRS"].ToString();
                    cell4.Text = reader["SECTIONNAME"].ToString();
                    cell5.Text = reader["NAME"].ToString();

                    row.Cells.Add(cell1);
                    row.Cells.Add(cell2);
                    row.Cells.Add(cell3);
                    row.Cells.Add(cell4);
                    row.Cells.Add(cell5);

                    table.Controls.Add(row);
                }

                reader.Close();
            }
        }
    }
}