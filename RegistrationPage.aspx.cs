using System;
using System.Collections.Generic;
using System.Data.SqlClient;  //for SQL connection
using System.Configuration;  // used to access the connection string
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BankingApp
{
    public partial class WebForm4 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) // so that there is no reloading every postback
            {
                List<string> countries = new List<string>
                {
                    "Afghanistan", "Albania", "Algeria", "Andorra", "Angola", "Argentina", "Armenia", "Australia", "Austria",
                    "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin",
                    "Bhutan", "Bolivia", "Botswana", "Brazil", "Bulgaria", "Burkina Faso", "Burundi", "Cambodia", "Cameroon",
                    "Canada", "Chile", "China", "Colombia", "Costa Rica", "Croatia", "Cuba", "Cyprus", "Czech Republic",
                    "Denmark", "Dominican Republic", "Ecuador", "Egypt", "El Salvador", "Estonia", "Eswatini", "Ethiopia",
                    "Finland", "France", "Germany", "Ghana", "Greece", "Guatemala", "Honduras", "Hungary", "Iceland", "India",
                    "Indonesia", "Iran", "Iraq", "Ireland", "Israel", "Italy", "Jamaica", "Japan", "Jordan", "Kazakhstan",
                    "Kenya", "Kuwait", "Laos", "Latvia", "Lebanon", "Liberia", "Libya", "Lithuania", "Luxembourg", "Madagascar",
                    "Malaysia", "Maldives", "Mali", "Malta", "Mauritania", "Mexico", "Moldova", "Monaco", "Mongolia", "Morocco",
                    "Mozambique", "Myanmar", "Namibia", "Nepal", "Netherlands", "New Zealand", "Nicaragua", "Niger", "Nigeria",
                    "North Korea", "Norway", "Oman", "Pakistan", "Panama", "Paraguay", "Peru", "Philippines", "Poland",
                    "Portugal", "Qatar", "Romania", "Russia", "Rwanda", "Saudi Arabia", "Senegal", "Serbia", "Singapore",
                    "Slovakia", "Slovenia", "South Africa", "South Korea", "Spain", "Sri Lanka", "Sudan", "Sweden",
                    "Switzerland", "Syria", "Tanzania", "Thailand", "Togo", "Tunisia", "Turkey", "Uganda", "Ukraine",
                    "United Arab Emirates", "United Kingdom", "United States", "Uruguay", "Uzbekistan", "Venezuela", "Vietnam",
                    "Yemen", "Zambia", "Zimbabwe"
                };

                ddlCountries.DataSource = countries;
                ddlCountries.DataBind();

                //default item
                ddlCountries.Items.Insert(0, new ListItem("-- Select a Country --", ""));
            }
        }

        protected void btnReg_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection("Data Source=CELESTE;Initial Catalog=BankingAppDB;Integrated Security=True;Encrypt=True;TrustServerCertificate=True");
            con.Open();
            string insertQuery = "INSERT INTO Customer VALUES(@name, @surname, @idNum, @nationality, @mobileNumber, @emailAddress, @password, @confPassword)";
            SqlCommand cmd = new SqlCommand(insertQuery, con);
            cmd.Parameters.AddWithValue("@name", txtFirst.Text);
            cmd.Parameters.AddWithValue("@surname", txtLast.Text);
            cmd.Parameters.AddWithValue("@idNum", txtID.Text);
            cmd.Parameters.AddWithValue("@nationality", ddlCountries.SelectedItem.Value);
            cmd.Parameters.AddWithValue("@mobileNumber", txtNum.Text);
            cmd.Parameters.AddWithValue("@emailAddress", txtEmail.Text);
            cmd.Parameters.AddWithValue("@password", txtPass.Text);
            cmd.Parameters.AddWithValue("@confPassword", txtConfirm.Text);
            int count = cmd.ExecuteNonQuery();
            if (count > 0)
            {
                Response.Write("<script>alert('Registered Successfully! Redirecting to Log In Page...')</script>");
                Response.Redirect("LoginPage.aspx");
            }
            else
            {
                Response.Write("<script>alert('Oops! Error in registration.')</script>");
            }
        }
    }

}
