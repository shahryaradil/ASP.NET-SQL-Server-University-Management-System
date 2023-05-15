using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

namespace DB_Project.Pages
{
    public partial class CourseRegistration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Cookies["UserInfo"] != null)
            {
                PopulateCourseDropDown();

            }
        }

        protected void PopulateCourseDropDown()
        {
            courseDropDown.Items.Clear();

            string connectionString = "Data Source=DESKTOP-O9EM53U\\SQLEXPRESS;Initial Catalog=DBPROJECT;Integrated Security=True";
            string userId = Request.Cookies["UserInfo"]["ID"];
            string query = "SELECT C.courseCode + ' - ' + C.courseName as Course FROM COURSES C WHERE C.semester = (SELECT SR.currentSemester FROM STUDENTS S JOIN STUDENTRECORD SR ON S.userID = SR.studentID WHERE S.userID = '1') AND C.courseCode NOT IN (SELECT CT.courseCode FROM COURSETAKING CT WHERE CT.studentID = @username);";
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    cmd.Parameters.AddWithValue("@username", userId);
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            string course = reader["Course"].ToString();
                            string[] parts = course.Split(new[] { " - " }, StringSplitOptions.None);
                            string courseCode = parts[0];
                            string courseName = parts[1];

                            ListItem listItem = new ListItem(courseName, courseCode);
                            courseDropDown.Items.Add(listItem);
                        }

                    }

                    reader.Close();
                }
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (courseDropDown.Items.Count > 0)
            {
                string selectedCourseID = courseDropDown.SelectedValue;
                string selectedCourseName = courseDropDown.SelectedItem.Text;

                string connectionString = "Data Source=DESKTOP-O9EM53U\\SQLEXPRESS;Initial Catalog=DBPROJECT;Integrated Security=True";
                string userId = Request.Cookies["UserInfo"]["ID"];
                string query = "INSERT INTO COURSETAKING (studentID, courseCode, sectionID, active, semester) VALUES (@username, @course, 1, 'Y', (SELECT SR.currentSemester FROM STUDENTS S JOIN STUDENTRECORD SR ON S.userID = SR.studentID WHERE S.userID = @username))";
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        conn.Open();
                        cmd.Parameters.AddWithValue("@username", userId);
                        cmd.Parameters.AddWithValue("@course", selectedCourseID);
                        cmd.ExecuteNonQuery();
                    }
                }
                lblSuccessful.Text = "Course registered successfully!";
                PopulateCourseDropDown();
            }
            else
            {
                lblSuccessful.Text = "No courses available for registration.";
            }
        }

    }
}