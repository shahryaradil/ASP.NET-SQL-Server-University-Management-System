using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace DB_Project.Pages
{
    public partial class Marks : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PopulateSemesterDropdown();
                PopulateCourseDropdown("1");
                UpdateMarksTable(sender, e);
            }
        }

        protected void PopulateSemesterDropdown()
        {
            string connectionString = "Data Source=DESKTOP-O9EM53U\\SQLEXPRESS;Initial Catalog=DBPROJECT;Integrated Security=True";
            string userId = Request.Cookies["UserInfo"]["ID"];

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT DISTINCT semester FROM MARKS WHERE studentID = @username;";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@username", userId);

                    connection.Open();

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        semesterDropdown.Items.Clear();

                        while (reader.Read())
                        {
                            ListItem item = new ListItem
                            {
                                Text = reader["semester"].ToString(),
                                Value = reader["semester"].ToString()
                            };

                            semesterDropdown.Items.Add(item);
                        }
                    }
                }
            }
        }

        protected void PopulateCourseDropdown(string semester)
        {
            string connectionString = "Data Source=DESKTOP-O9EM53U\\SQLEXPRESS;Initial Catalog=DBPROJECT;Integrated Security=True";
            string userId = Request.Cookies["UserInfo"]["ID"];

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT DISTINCT M.courseCode FROM MARKS M WHERE M.studentID = @username AND M.semester = @semester;";  // Replace with your actual SQL query

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@username", userId);
                    command.Parameters.AddWithValue("@semester", semester);

                    connection.Open();

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        courseDropdown.Items.Clear();

                        while (reader.Read())
                        {
                            ListItem item = new ListItem
                            {
                                Text = reader["courseCode"].ToString(),
                                Value = reader["courseCode"].ToString()
                            };

                            courseDropdown.Items.Add(item);
                        }
                    }
                }
            }
        }

        protected void UpdateMarksTable(object sender, EventArgs e)
        {
            string selectedSemester = semesterDropdown.SelectedItem.Value;
            string selectedCourse = courseDropdown.SelectedItem.Value;

            string connectionString = "Data Source=DESKTOP-O9EM53U\\SQLEXPRESS;Initial Catalog=DBPROJECT;Integrated Security=True";
            string userId = Request.Cookies["UserInfo"]["ID"];
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string courseNameQuery = "SELECT courseName FROM COURSES WHERE courseCode = @courseCode;";
                SqlCommand courseNameCommand = new SqlCommand(courseNameQuery, connection);
                courseNameCommand.Parameters.AddWithValue("@courseCode", selectedCourse);
                string courseName = courseNameCommand.ExecuteScalar()?.ToString();

                lblCourse.Text = courseName;

                string query = "SELECT M.studentID, M.courseCode, M.semester, M.obtainedMarks, M.totalMarks, M.assesmentType, AVG(M2.obtainedMarks) AS average FROM MARKS M JOIN MARKS M2 ON M.courseCode = M2.courseCode AND M.semester = M2.semester AND M.assesmentType = M2.assesmentType WHERE M.studentID = @username AND M.courseCode = @course AND M.semester = @semester GROUP BY M.studentID, M.courseCode, M.semester, M.obtainedMarks, M.totalMarks, M.assesmentType;";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@semester", selectedSemester);
                command.Parameters.AddWithValue("@course", selectedCourse);
                command.Parameters.AddWithValue("@username", userId);
                SqlDataReader reader = command.ExecuteReader();

                marksTableBody.Controls.Clear();

                while (reader.Read())
                {
                    TableRow row = new TableRow();
                    TableCell assesmentItemCell = new TableCell();
                    TableCell obtainedMarksCell = new TableCell();
                    TableCell totalMarksCell = new TableCell();
                    TableCell averageCell = new TableCell();
                    assesmentItemCell.Text = reader["assesmentType"].ToString();
                    obtainedMarksCell.Text = reader["obtainedMarks"].ToString();
                    totalMarksCell.Text = reader["totalMarks"].ToString();
                    averageCell.Text = reader["average"].ToString();

                    row.Cells.Add(assesmentItemCell);
                    row.Cells.Add(obtainedMarksCell);
                    row.Cells.Add(totalMarksCell);
                    row.Cells.Add(averageCell);

                    marksTableBody.Controls.Add(row);
                }

                reader.Close();
                connection.Close();
            }
        }

        protected void semesterDropdown_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedSemester = semesterDropdown.SelectedItem.Value;

            if (!string.IsNullOrEmpty(selectedSemester))
            {
                PopulateCourseDropdown(selectedSemester);
            }
            else
            {
                courseDropdown.Items.Clear();
            }

            UpdateMarksTable(sender, e);
        }

        protected void courseDropdown_SelectedIndexChanged(object sender, EventArgs e)
        {
            UpdateMarksTable(sender, e);
        }
    }
}
