using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace DB_Project.Pages
{
    public partial class Evaluate : System.Web.UI.Page
    {
        string courseCode;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                if (Request.QueryString["courseCode"] != null)
                {

                    courseCode = Request.QueryString["courseCode"];
                    string connectionString = "Data Source=DESKTOP-O9EM53U\\SQLEXPRESS;Initial Catalog=DBPROJECT;Integrated Security=True";
                    string userId = Request.Cookies["UserInfo"]["ID"];

                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        connection.Open();
                        string courseQuery = "SELECT CT.courseCode, C.courseName, S.sectionName FROM COURSETEACHING CT JOIN COURSES C ON CT.courseCode = C.courseCode JOIN SECTIONS S ON CT.sectionID = S.sectionID WHERE CT.courseCode = @courseCode;";
                        SqlCommand courseCommand = new SqlCommand(courseQuery, connection);
                        courseCommand.Parameters.AddWithValue("@courseCode", courseCode);
                        SqlDataReader courseReader = courseCommand.ExecuteReader();

                        if (courseReader.Read())
                        {
                            courseCodeLabel.Text = courseReader["courseCode"].ToString();
                            courseNameLabel.Text = courseReader["courseName"].ToString();
                            sectionLabel.Text = courseReader["sectionName"].ToString();
                        }

                        courseReader.Close();
                        connection.Close();
                    }

                    string query = "SELECT USERS.userID, USERS.name FROM USERS JOIN STUDENTS ON USERS.userID = STUDENTS.userID JOIN COURSETAKING ON STUDENTS.userID = COURSETAKING.studentID WHERE COURSETAKING.courseCode = @CourseCode;";
                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        connection.Open();

                        SqlCommand command = new SqlCommand(query, connection);
                        command.Parameters.AddWithValue("@CourseCode", courseCode);

                        SqlDataReader reader = command.ExecuteReader();
                        while (reader.Read())
                        {
                            string rollNumber = reader["userID"].ToString();
                            string name = reader["name"].ToString();

                            HtmlTableRow tableRow = new HtmlTableRow();
                            HtmlTableCell rollNumberCell = new HtmlTableCell();
                            HtmlTableCell nameCell = new HtmlTableCell();
                            HtmlTableCell obtainedMarksCell = new HtmlTableCell();

                            rollNumberCell.InnerText = rollNumber;
                            nameCell.InnerText = name;

                            TextBox obtainedMarksTextBox = new TextBox();
                            obtainedMarksTextBox.ID = "obtainedMarksTextBox_" + rollNumber;
                            obtainedMarksCell.Controls.Add(obtainedMarksTextBox);

                            tableRow.Cells.Add(rollNumberCell);
                            tableRow.Cells.Add(nameCell);
                            tableRow.Cells.Add(obtainedMarksCell);

                            table.Controls.Add(tableRow);

                        }

                        reader.Close();
                        connection.Close();
                    }
                }
            }
        }

        protected void OnSearchButton_Click(object sender, EventArgs e)
        {

            successLabel.Text = "Marks inserted successfully!";
        }

    }
}