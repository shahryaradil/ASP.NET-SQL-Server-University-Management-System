using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace DB_Project.Pages
{
    public partial class StudentsSections : System.Web.UI.Page
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

                string query = "SELECT USERID, NAME, SECTIONNAME FROM USERS INNER JOIN COURSETAKING CT ON CT.STUDENTID = USERS.USERID INNER JOIN SECTIONS ON CT.SECTIONID = SECTIONS.SECTIONID ORDER BY SECTIONNAME";
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
                headerCell1.Text = "Roll Number";
                headerCell2.Text = "Student Name";
                headerCell3.Text = "Section";

                headerRow.Cells.Add(headerCell1);
                headerRow.Cells.Add(headerCell2);
                headerRow.Cells.Add(headerCell3);

                table.Controls.Add(headerRow);

                while (reader.Read())
                {
                    TableRow row = new TableRow();
                    TableCell cell1 = new TableCell();
                    TableCell cell2 = new TableCell();
                    TableCell cell3 = new TableCell();
                    cell1.Text = reader["USERID"].ToString();
                    cell2.Text = reader["NAME"].ToString();
                    cell3.Text = reader["SECTIONNAME"].ToString();

                    row.Cells.Add(cell1);
                    row.Cells.Add(cell2);
                    row.Cells.Add(cell3);

                    table.Controls.Add(row);
                }

                reader.Close();
            }
        }
    }
}