using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace Project_DB.Pages
{
    public partial class EvaluationReport1 : System.Web.UI.Page
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
                    course.DataValueField = "COURSECODE"; 
                    course.DataBind();

                    course.Items.Insert(0, new ListItem("Select an item", ""));
                }

            }
        }

        protected void OnSearchButton(object sender, EventArgs e)
        {
            string courseCode = course.SelectedValue;
            OnSearchButton(courseCode);
        }

        protected void OnSearchButton(string courseCode)
        {
            string connectionString = "Data Source=DESKTOP-O9EM53U\\SQLEXPRESS;Initial Catalog=DBPROJECT;Integrated Security=True";
            string userId = Request.Cookies["UserInfo"]["ID"];
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string query = "SELECT CT.courseCode, C.courseName, S.sectionName FROM COURSETEACHING CT JOIN COURSES C ON CT.courseCode = C.courseCode JOIN SECTIONS S ON CT.sectionID = S.sectionID WHERE CT.courseCode = @courseCode;";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@courseCode", courseCode);
                SqlDataReader reader = command.ExecuteReader();

                table.Controls.Clear();

                while (reader.Read())
                {
                    TableRow row = new TableRow();
                    TableCell courseCodeCell = new TableCell();
                    TableCell courseNameCell = new TableCell();
                    TableCell sectionNameCell = new TableCell();

                    string courseCodeValue = reader["courseCode"].ToString(); 
                    string courseName = reader["courseName"].ToString();
                    string sectionName = reader["sectionName"].ToString();

                    HyperLink courseLink = new HyperLink();
                    courseLink.Text = courseCodeValue;
                    courseLink.NavigateUrl = $"EvaluationReport2.aspx?courseCode={courseCodeValue}&courseName={Uri.EscapeDataString(courseName)}&sectionName={Uri.EscapeDataString(sectionName)}";
                    courseLink.ToolTip = "Click to view details";
                    courseLink.Attributes["onclick"] = $"storeCourseCode('{courseCodeValue}');";
                    courseCodeCell.Controls.Add(courseLink);

                    courseNameCell.Text = courseName;
                    sectionNameCell.Text = sectionName;

                    row.Cells.Add(courseCodeCell);
                    row.Cells.Add(courseNameCell);
                    row.Cells.Add(sectionNameCell);

                    table.Controls.Add(row);
                }

                reader.Close();
                connection.Close();
            }
        }
    }
}