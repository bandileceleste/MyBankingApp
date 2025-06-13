using System;
using System.Data.SqlClient;  // SQL connection
using System.Configuration;  // Access the connection string
using System.Data;
using System.Web;

namespace BankingApp
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection con = new SqlConnection("Data Source=CELESTE;Initial Catalog=BankingAppDB;Integrated Security=True;Encrypt=True;TrustServerCertificate=True"))
                {
                    string query = "SELECT cusID, name, surname FROM Customer WHERE emailAddress = @email AND password = @password";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@email", txtEmail.Text.Trim());
                        cmd.Parameters.AddWithValue("@password", txtPass.Text.Trim()); // try use hashing here

                        con.Open();
                        SqlDataReader reader = cmd.ExecuteReader();
                        if (reader.Read())
                        {
                            // Store customer ID in session
                            Session["cusID"] = reader["cusID"].ToString();
                            Session["customerName"] = reader["name"].ToString();
                            Session["customerSurname"] = reader["surname"].ToString();

                            // Redirect to profile page
                            Response.Redirect("UserProfile.aspx");
                        }
                        else
                        {
                            lblMessage.Text = "Invalid email or password.";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = ex.Message;
            }
        }
    }
}