using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace BankingApp
{
    public partial class WebForm3 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) // Prevents reloading on every postback
            {
                ddlAcc.Items.Add(new ListItem("Select", ""));
                ddlAcc.Items.Add(new ListItem("Savings", "1"));
                ddlAcc.Items.Add(new ListItem("Cheque", "2"));
                ddlAcc.Items.Add(new ListItem("Business", "3"));
            }

            grdAcc.DataBind();
        }

        bool checkIfAccountExists()
        {
            try
            {
                SqlConnection con = new SqlConnection("Data Source=CELESTE;Initial Catalog=BankingAppDB;Integrated Security=True;Encrypt=True;TrustServerCertificate=True");
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                string selectQuery = "SELECT * FROM Account Where accID='" + txtAccID.Text.Trim() + "'";
                SqlCommand cmd = new SqlCommand(selectQuery, con);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                if (dt.Rows.Count >= 1)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
                return false;
            }
        }

        void clearForm()
        {
            txtAccID.Text = "";
            txtCusID.Text = "";
            txtBalance.Text = "";
        }

        void addNewAccount()
        {
            try
            {
                using (SqlConnection con = new SqlConnection("Data Source=CELESTE;Initial Catalog=BankingAppDB;Integrated Security=True;Encrypt=True;TrustServerCertificate=True"))
                {
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }

                    // Insert statement with auto-generated fields
                    string insertQuery = @"
                INSERT INTO Account (cusID, accType, balance) 
                VALUES (@cusID, @accType, @balance)";

                    using (SqlCommand cmd = new SqlCommand(insertQuery, con))
                    {
                        cmd.Parameters.AddWithValue("@cusID", txtCusID.Text.Trim());
                        cmd.Parameters.AddWithValue("@accType", ddlAcc.SelectedItem.Text);
                        cmd.Parameters.AddWithValue("@balance", txtBalance.Text.Trim());

                        cmd.ExecuteNonQuery();
                    }
                }

                Response.Write("<script>alert('Account added successfully!');</script>");
                clearForm();
                grdAcc.DataBind();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

        void updateAccount()
        {
            try
            {
                SqlConnection con = new SqlConnection("Data Source=CELESTE;Initial Catalog=BankingAppDB;Integrated Security=True;Encrypt=True;TrustServerCertificate=True");
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                string updateQuery = "UPDATE Account SET cusID=@cusID, accType=@accType, balance=@balance WHERE accID='" + txtAccID.Text.Trim() + "'";
                SqlCommand cmd = new SqlCommand(updateQuery, con);
                cmd.Parameters.AddWithValue("@cusID", txtCusID.Text.Trim());
                cmd.Parameters.AddWithValue("@accType", ddlAcc.SelectedItem.Text);
                cmd.Parameters.AddWithValue("@balance", txtBalance.Text.Trim());

                cmd.ExecuteNonQuery();
                con.Close();
                Response.Write("<script>alert('Account updated successfully!');</script>");
                clearForm();
                grdAcc.DataBind();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

        void deleteAccount()
        {
            try
            {
                SqlConnection con = new SqlConnection("Data Source=CELESTE;Initial Catalog=BankingAppDB;Integrated Security=True;Encrypt=True;TrustServerCertificate=True");
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                string deleteQuery = "DELETE FROM Account WHERE accID='" + txtAccID.Text.Trim() + "'";
                SqlCommand cmd = new SqlCommand(deleteQuery, con);

                cmd.ExecuteNonQuery();
                con.Close();
                Response.Write("<script>alert('Account deleted successfully!');</script>");
                clearForm();
                grdAcc.DataBind();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if (checkIfAccountExists())
            {
                Response.Write("<script>alert('Account already exists!');</script>");
            }
            else
            {
                addNewAccount();
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (checkIfAccountExists())
            {
                updateAccount();
            }
            else
            {
                Response.Write("<script>alert('Account does not exist.');</script>");
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            if (checkIfAccountExists())
            {
                deleteAccount();
            }
            else
            {
                Response.Write("<script>alert('Account does not exist.');</script>");
            }
        }
    }
}