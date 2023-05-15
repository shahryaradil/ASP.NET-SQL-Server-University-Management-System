using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace Project_DB.Pages
{
    public partial class GradeReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PopulateCourses();
            }
        }

        protected void PopulateCourses()
        {
            string userId = Request.Cookies["UserInfo"]["ID"];

            string connectionString = "Data Source=DESKTOP-O9EM53U\\SQLEXPRESS;Initial Catalog=DBPROJECT;Integrated Security=True";
            string query = "SELECT DISTINCT CONCAT(COURSES.[COURSECODE], ' - ', COURSES.[COURSENAME]) AS CNAME, COURSES.[COURSECODE] FROM [COURSETEACHING] INNER JOIN COURSES ON COURSETEACHING.COURSECODE = COURSES.COURSECODE WHERE [TEACHERID] = 2";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@username", userId);
                connection.Open();

                SqlDataAdapter adapter = new SqlDataAdapter(command);
                DataTable dataTable = new DataTable();
                adapter.Fill(dataTable);

                if (dataTable.Rows.Count > 0)
                {
                    course.DataSource = dataTable;
                    course.DataTextField = "CNAME";
                    course.DataValueField = "CNAME";
                    course.DataBind();

                    course.Items.Insert(0, new ListItem("Select an item", ""));
                }
            }
        }

        protected void OnSearchButton(object sender, EventArgs e)
        {
            OnSearchButton();
        }

        protected void OnSearchButton()
        {

            string courseLabel = course.SelectedItem.Text;
            string courseStr = "";
            int index = courseLabel.IndexOf(' ');
            if (index > 0)
            {
                courseStr = courseLabel.Substring(0, index);
            }
            tLabel.Text = courseLabel;

            string connectionString = "Data Source=DESKTOP-O9EM53U\\SQLEXPRESS;Initial Catalog=DBPROJECT;Integrated Security=True";
            string userId = Request.Cookies["UserInfo"]["ID"];

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string query = "SELECT STUDENTID, U.NAME, S.SECTIONNAME, GRADES.COURSECODE, GRADE FROM GRADES INNER JOIN COURSETEACHING CT ON GRADES.COURSECODE = CT.COURSECODE  INNER JOIN SECTIONS S ON CT.SECTIONID = S.SECTIONID INNER JOIN USERS U ON GRADES.STUDENTID = U.USERID WHERE GRADES.COURSECODE = @course AND TEACHERID = @username";

                SqlCommand command = new SqlCommand(query, connection);

                command.Parameters.AddWithValue("@course", courseStr);
                command.Parameters.AddWithValue("@username", userId);

                SqlDataReader reader = command.ExecuteReader();

                TableHeaderRow headRow = new TableHeaderRow();
                TableHeaderCell headCell1 = new TableHeaderCell();
                TableHeaderCell headCell2 = new TableHeaderCell();
                TableHeaderCell headCell3 = new TableHeaderCell();
                TableHeaderCell headCell4 = new TableHeaderCell();

                headCell1.Text = "Roll Number";
                headCell2.Text = "Name";
                headCell3.Text = "Section";
                headCell4.Text = "Grade";
                headRow.Cells.Add(headCell1);
                headRow.Cells.Add(headCell2);
                headRow.Cells.Add(headCell3);
                headRow.Cells.Add(headCell4);
                table.Rows.Add(headRow);

                while (reader.Read())
                {
                    TableRow row = new TableRow();
                    TableCell cell1 = new TableCell();
                    TableCell cell2 = new TableCell();
                    TableCell cell3 = new TableCell();
                    TableCell cell4 = new TableCell();

                    cell1.Text = reader["STUDENTID"].ToString();
                    cell2.Text = reader["NAME"].ToString();
                    cell3.Text = reader["SECTIONNAME"].ToString();
                    cell4.Text = reader["GRADE"].ToString();

                    row.Cells.Add(cell1);
                    row.Cells.Add(cell2);
                    row.Cells.Add(cell3);
                    row.Cells.Add(cell4);

                    table.Rows.Add(row);
                }

                if (table.Rows.Count == 1)
                {
                    TableRow noDataMessageRow = new TableRow();
                    TableCell noDataMessageCell = new TableCell { Text = "No grade data available." };
                    noDataMessageCell.ColumnSpan = 4;
                    noDataMessageRow.Cells.Add(noDataMessageCell);
                    table.Rows.Add(noDataMessageRow);
                }

                reader.Close();
                connection.Close();
            }
        }
    }
}