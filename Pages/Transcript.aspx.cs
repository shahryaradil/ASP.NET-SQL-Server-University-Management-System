using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace DB_Project.Pages
{
    public partial class Transcript : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            UpdateSemesterTable(sender, e);
        }

        protected void UpdateSemesterTable(object sender, EventArgs e)
        {
            string connectionString = "Data Source=DESKTOP-O9EM53U\\SQLEXPRESS;Initial Catalog=DBPROJECT;Integrated Security=True";
            string userId = Request.Cookies["UserInfo"]["ID"];
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string query = "SELECT G.courseCode, G.grade, C.courseName, CT.semester, CASE WHEN G.grade IN ('A+', 'A') THEN 4.0 WHEN G.grade = 'A-' THEN 3.67 WHEN G.grade = 'B+' THEN 3.33 WHEN G.grade = 'B' THEN 3.0 WHEN G.grade = 'B-' THEN 2.67 WHEN G.grade = 'C+' THEN 2.33 WHEN G.grade = 'C' THEN 2.0 WHEN G.grade = 'C-' THEN 1.67 WHEN G.grade = 'D+' THEN 1.33 WHEN G.grade = 'D' THEN 1.0 WHEN G.grade = 'F' THEN 0.0 ELSE NULL END AS points FROM GRADES G JOIN COURSES C ON G.courseCode = C.courseCode JOIN COURSETAKING CT ON G.courseCode = CT.courseCode AND G.studentID = CT.studentID WHERE G.studentID = @username ORDER BY semester";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@username", userId);
                SqlDataReader reader = command.ExecuteReader();

                transcriptTableBody.Controls.Clear();

                while (reader.Read())
                {
                    TableRow row = new TableRow();
                    TableCell courseCodeCell = new TableCell();
                    TableCell courseTitleCell = new TableCell();
                    TableCell UnitsCell = new TableCell();
                    TableCell GradeCell = new TableCell();
                    TableCell SemesterCell = new TableCell();
                    courseCodeCell.Text = reader["courseCode"].ToString();
                    courseTitleCell.Text = reader["courseName"].ToString();
                    UnitsCell.Text = reader["points"].ToString();
                    GradeCell.Text = reader["grade"].ToString();
                    SemesterCell.Text = reader["semester"].ToString();

                    row.Cells.Add(courseCodeCell);
                    row.Cells.Add(courseTitleCell);
                    row.Cells.Add(UnitsCell);
                    row.Cells.Add(GradeCell);
                    row.Cells.Add(SemesterCell);

                    transcriptTableBody.Controls.Add(row);
                }

                reader.Close();

                query = "SELECT CAST(ROUND((SELECT SUM(CASE WHEN G.grade IN ('A+', 'A') THEN 4.0 WHEN G.grade = 'A-' THEN 3.67 WHEN G.grade = 'B+' THEN 3.33 WHEN G.grade = 'B' THEN 3.0 WHEN G.grade = 'B-' THEN 2.67 WHEN G.grade = 'C+' THEN 2.33 WHEN G.grade = 'C' THEN 2.0 WHEN G.grade = 'C-' THEN 1.67 WHEN G.grade = 'D+' THEN 1.33 WHEN G.grade = 'D' THEN 1.0 WHEN G.grade = 'F' THEN 0.0 ELSE 0.0 END * C.creditHrs) FROM GRADES G JOIN COURSES C ON G.courseCode = C.courseCode WHERE G.studentID = S.userID) / (SELECT SUM(C.creditHrs) FROM COURSES C JOIN COURSETAKING CT ON CT.courseCode = C.courseCode WHERE CT.studentID = S.userID), 2) AS DECIMAL(10, 2)) AS GPA FROM STUDENTS S JOIN USERS U ON S.userID = U.userID JOIN STUDENTRECORD SR ON S.userID = SR.studentID WHERE S.userID = @username GROUP BY S.userID, U.name, S.degreeProgram, SR.currentSemester, SR.creditHrs";

                SqlCommand cmd = new SqlCommand(query, connection);
                cmd.Parameters.AddWithValue("@username", userId);
                SqlDataReader dr = cmd.ExecuteReader();

                cmd = new SqlCommand(query, connection);
                cmd.Parameters.AddWithValue("@username", userId);

                if (dr.Read())
                {
                    labelGPA.Text = dr["GPA"].ToString();
                }

                dr.Close();
                connection.Close();
            }
        }
    }
}