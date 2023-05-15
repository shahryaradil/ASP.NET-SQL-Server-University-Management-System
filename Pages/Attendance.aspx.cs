using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace DB_Project.Pages
{
    public partial class Attendance : System.Web.UI.Page
    {
        protected HtmlGenericControl percentageBar;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.Cookies["UserInfo"] != null)
                {
                    PopulateCourseDropdown();

                    UpdateAttendanceTable();

                    percentageBar = (HtmlGenericControl)FindControl("percentageBar");

                }
            }
        }

        private void PopulateCourseDropdown()
        {


            string connectionString = "Data Source=DESKTOP-O9EM53U\\SQLEXPRESS;Initial Catalog=DBPROJECT;Integrated Security=True";
            string userId = Request.Cookies["UserInfo"]["ID"];

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT C.courseCode, C.courseCode + ' - ' + C.courseName As courseName FROM COURSES C JOIN COURSETAKING CT ON C.courseCode = CT.courseCode WHERE CT.studentID = @username AND CT.active = 'Y';";  // Replace with your actual SQL query

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@username", userId);

                    connection.Open();

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        courseDropdown.Items.Clear();

                        while (reader.Read())
                        {
                            ListItem item = new ListItem
                            {
                                Text = reader["courseName"].ToString(),
                                Value = reader["courseCode"].ToString()
                            };

                            courseDropdown.Items.Add(item);
                        }
                    }
                }
            }
        }


        protected void UpdateAttendanceTable(object sender, EventArgs e)
        {
            UpdateAttendanceTable();
        }

        private void UpdateAttendanceTable()
        {
            string connectionString = "Data Source=DESKTOP-O9EM53U\\SQLEXPRESS;Initial Catalog=DBPROJECT;Integrated Security=True";
            string userId = Request.Cookies["UserInfo"]["ID"];

            string course = courseDropdown.SelectedItem?.Value;
            if (string.IsNullOrEmpty(course))
            {
                TableRow noCourseSelectedRow = new TableRow();
                TableCell noCourseSelectedCell = new TableCell { Text = "No course selected." };
                noCourseSelectedCell.ColumnSpan = 4;
                noCourseSelectedRow.Cells.Add(noCourseSelectedCell);
                attendanceTable.Rows.Add(noCourseSelectedRow);
                return;
            }
            List<AttendanceData> attendanceData = new List<AttendanceData>();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT A.lectureNum, A.duration, A.statusAttendance, FORMAT(A.dateAndTime, 'dd-MM-yyyy') AS Date FROM ATTENDANCE AS A JOIN COURSETAKING AS CT ON A.subjectCode = CT.courseCode JOIN COURSES AS CO ON CT.courseCode = CO.courseCode WHERE CT.studentID = @username AND CT.courseCode = @course AND CT.active = 'Y'";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@username", userId);
                    command.Parameters.AddWithValue("@course", course);

                    connection.Open();

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            AttendanceData data = new AttendanceData
                            {
                                LectureNumber = reader["lectureNum"].ToString(),
                                Date = reader["Date"].ToString(),
                                Duration = reader["duration"].ToString(),
                                Presence = reader["statusAttendance"].ToString()
                            };

                            attendanceData.Add(data);
                        }
                    }
                }
            }

            attendanceTable.Rows.Clear();

            TableHeaderRow headerRow = new TableHeaderRow();
            headerRow.Cells.Add(new TableHeaderCell { Text = "Lecture Number" });
            headerRow.Cells.Add(new TableHeaderCell { Text = "Date" });
            headerRow.Cells.Add(new TableHeaderCell { Text = "Duration" });
            headerRow.Cells.Add(new TableHeaderCell { Text = "Presence" });
            attendanceTable.Rows.Add(headerRow);

            foreach (AttendanceData data in attendanceData)
            {
                TableRow row = new TableRow();
                row.Cells.Add(new TableCell { Text = data.LectureNumber });
                row.Cells.Add(new TableCell { Text = data.Date });
                row.Cells.Add(new TableCell { Text = data.Duration });
                row.Cells.Add(new TableCell { Text = data.Presence });
                attendanceTable.Rows.Add(row);
            }

            if (attendanceData.Count == 0)
            {
                TableRow noDataMessageRow = new TableRow();
                TableCell noDataMessageCell = new TableCell { Text = "No attendance data available." };
                noDataMessageCell.ColumnSpan = 4;
                noDataMessageRow.Cells.Add(noDataMessageCell);
                attendanceTable.Rows.Add(noDataMessageRow);
            }


            double totalLectures = attendanceData.Count;
            double attendedLectures = 0;

            foreach (AttendanceData data in attendanceData)
            {
                if (data.Presence == "P")
                {
                    attendedLectures++;
                }
                else if (data.Presence == "L")
                {
                    attendedLectures += .5;
                }
            }

            int attendancePercentage = (int)(((float)attendedLectures / totalLectures) * 100);
            string percentageText = attendancePercentage.ToString() + "%";

            percentageBar.InnerText = percentageText;
            percentageBar.Style["width"] = percentageText;
            if (attendancePercentage == 0)
            {
                percentageBar.Style["background-color"] = "#f00";
            }
            else if (attendancePercentage >= 90)
            {
                percentageBar.Style["background-color"] = "#44AC48";
            }
            else if (attendancePercentage >= 80)
            {
                percentageBar.Style["background-color"] = "#fd0";
            }
            else
            {
                percentageBar.Style["background-color"] = "#f00";
            }


        }

        public class AttendanceData
        {
            public string LectureNumber { get; set; }
            public string Date { get; set; }
            public string Duration { get; set; }
            public string Presence { get; set; }
        }
    }
}
