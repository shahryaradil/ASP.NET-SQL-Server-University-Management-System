using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Web;

namespace DB_Project.Pages
{
    public partial class Feedback : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void submitButton_Click(object sender, EventArgs e)
        {
            string studentID = Request.Cookies["UserInfo"]["ID"];
            string teacherName = Request.Form["teacher-name"];
            DateTime dateAndTime = DateTime.Now;

            string teacherID = string.Empty;
            string connectionString = "Data Source=DESKTOP-O9EM53U\\SQLEXPRESS;Initial Catalog=DBPROJECT;Integrated Security=True";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string query = "SELECT userID FROM FACULTY WHERE name = @teacherName";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@teacherName", teacherName);

                using (SqlDataReader reader = command.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        teacherID = reader["userID"].ToString();
                    }
                    else
                    {
                        lblSuccessful.Text = "Incorrect teacher name entered.";
                        return;
                    }
                }

                connection.Close();
            }

            if (!string.IsNullOrEmpty(teacherID))
            {
                Dictionary<string, string> feedbackItems = new Dictionary<string, string>
                {
                    { "appearance-neatness", Request.Form["appearance-neatness"] },
                    { "appearance-attire", Request.Form["appearance-attire"] },
                    { "appearance-punctuality", Request.Form["appearance-punctuality"] },
                    { "appearance-commskills", Request.Form["appearance-commskills"] },
                    { "appearance-overall", Request.Form["appearance-overall"] },
                    { "knowledge-clarity", Request.Form["knowledge-clarity"] },
                    { "knowledge-depth", Request.Form["knowledge-depth"] },
                    { "knowledge-communication", Request.Form["knowledge-communication"] },
                    { "knowledge-examples", Request.Form["knowledge-examples"] },
                    { "knowledge-overall", Request.Form["knowledge-overall"] },
                    { "assessment-item1", Request.Form["assessment-item1"] },
                    { "assessment-item2", Request.Form["assessment-item2"] },
                };

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    foreach (var item in feedbackItems)
                    {
                        string feedbackElement = item.Key;
                        string elementValue = item.Value;

                        string query = "INSERT INTO Feedback (studentID, teacherID, dateAndTime, feedbackElement, elementValue) " +
                            "VALUES (@studentID, @teacherID, @dateAndTime, @feedbackElement, @elementValue)";

                        SqlCommand command = new SqlCommand(query, connection);
                        command.Parameters.AddWithValue("@studentID", studentID);
                        command.Parameters.AddWithValue("@teacherID", teacherID);
                        command.Parameters.AddWithValue("@dateAndTime", dateAndTime);
                        command.Parameters.AddWithValue("@feedbackElement", feedbackElement);
                        command.Parameters.AddWithValue("@elementValue", elementValue);

                        command.ExecuteNonQuery();
                    }

                    connection.Close();
                }

                lblSuccessful.Text = "Feedback submitted successfully!";
            }
        }


    }
}
