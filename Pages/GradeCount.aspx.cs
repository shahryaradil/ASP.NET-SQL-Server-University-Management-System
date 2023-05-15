using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace Project_DB.Pages
{
    public partial class GradeCount : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PopulateCourses();
                PopulateSections("-");
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

        protected void PopulateSections(string courseSelected)
        {
            int index = courseSelected.IndexOf(' ');
            if (index > 0)
            {
                courseSelected = courseSelected.Substring(0, index);
            }

            string connectionString = "Data Source=DESKTOP-O9EM53U\\SQLEXPRESS;Initial Catalog=DBPROJECT;Integrated Security=True";
            string userId = Request.Cookies["UserInfo"]["ID"];

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT SECTIONNAME FROM COURSETEACHING INNER JOIN SECTIONS ON COURSETEACHING.SECTIONID = SECTIONS.SECTIONID WHERE TEACHERID = @username AND COURSECODE = @course";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@username", userId);
                    command.Parameters.AddWithValue("@course", courseSelected);

                    connection.Open();

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        section.Items.Clear();

                        while (reader.Read())
                        {
                            ListItem item = new ListItem
                            {
                                Text = reader["SECTIONNAME"].ToString(),
                                Value = reader["SECTIONNAME"].ToString()
                            };

                            section.Items.Add(item);
                        }
                    }
                }
            }
        }

        protected void OnChangeCourse(object sender, EventArgs e)
        {
            string selectedSemester = course.SelectedItem.Text;

            if (!string.IsNullOrEmpty(selectedSemester))
            {
                PopulateSections(selectedSemester);
            }
            else
            {
                section.Items.Clear();
            }

        }

        protected void OnSearchButton(object sender, EventArgs e)
        {
            OnSearchButton();
        }

        protected void OnSearchButton()
        {
            string courseSelected = course.SelectedItem.Text;
            tLabel.Text = courseSelected;

            int index = courseSelected.IndexOf(' ');
            if (index > 0)
            {
                courseSelected = courseSelected.Substring(0, index);
            }

            string connectionString = "Data Source=DESKTOP-O9EM53U\\SQLEXPRESS;Initial Catalog=DBPROJECT;Integrated Security=True";
            string userId = Request.Cookies["UserInfo"]["ID"];

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string query = "SELECT GRADE, COUNT(*) AS GRADECOUNT FROM GRADES INNER JOIN COURSETEACHING ON GRADES.COURSECODE = COURSETEACHING.COURSECODE WHERE GRADES.COURSECODE = @course AND TEACHERID = @username GROUP BY GRADE";

                SqlCommand command = new SqlCommand(query, connection);

                command.Parameters.AddWithValue("@username", userId);
                command.Parameters.AddWithValue("@course", courseSelected);

                SqlDataReader reader = command.ExecuteReader();

                TableHeaderRow headRow = new TableHeaderRow();
                TableHeaderCell headCell1 = new TableHeaderCell();
                TableHeaderCell headCell2 = new TableHeaderCell();
                TableHeaderCell headCell3 = new TableHeaderCell();
                TableHeaderCell headCell4 = new TableHeaderCell();

                headCell1.Text = "Grade";
                headCell2.Text = "Grade Count";
                headRow.Cells.Add(headCell1);
                headRow.Cells.Add(headCell2);
                table.Rows.Add(headRow);

                while (reader.Read())
                {
                    TableRow row = new TableRow();
                    TableCell cell1 = new TableCell();
                    TableCell cell2 = new TableCell();

                    cell1.Text = reader["GRADE"].ToString();
                    cell2.Text = reader["GRADECOUNT"].ToString();

                    row.Cells.Add(cell1);
                    row.Cells.Add(cell2);

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