using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace Project_DB.Pages
{
    public partial class FeedbackReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                UpdateFeedback();
        }

        protected void UpdateFeedback(object sender, EventArgs e)
        {
            UpdateFeedback();
        }

        protected void UpdateFeedback()
        {
            string element = category.SelectedValue;
            label1.Text = element;

            string connectionString = "Data Source=DESKTOP-O9EM53U\\SQLEXPRESS;Initial Catalog=DBPROJECT;Integrated Security=True";
            string userId = Request.Cookies["UserInfo"]["ID"];

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string query = "SELECT [ELEMENTVALUE] FROM FEEDBACK WHERE [FEEDBACKELEMENT] = @element AND [TEACHERID] = @username";

                SqlCommand command = new SqlCommand(query, connection);

                command.Parameters.AddWithValue("@element", element);
                command.Parameters.AddWithValue("@username", userId);

                SqlDataReader reader = command.ExecuteReader();

                TableHeaderRow headRow = new TableHeaderRow();
                TableHeaderCell headCell = new TableHeaderCell();

                headCell.Text = "Rating";
                headRow.Cells.Add(headCell);
                results.Rows.Add(headRow);

                // Add the data to the table
                while (reader.Read())
                {
                    TableRow row = new TableRow();
                    TableCell cell1 = new TableCell();

                    cell1.Text = reader["elementValue"].ToString();

                    row.Cells.Add(cell1);

                    results.Rows.Add(row);
                }

                if (results.Rows.Count == 1)
                {
                    TableRow noDataMessageRow = new TableRow();
                    TableCell noDataMessageCell = new TableCell { Text = "No feedback data available." };
                    noDataMessageCell.ColumnSpan = 4;
                    noDataMessageRow.Cells.Add(noDataMessageCell);
                    results.Rows.Add(noDataMessageRow);
                }

                reader.Close();
                connection.Close();
            }
        }
    }
}