using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BankingApp
{
    public partial class WebForm5 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            GridView1.DataBind();
        }

        bool checkIfCustomerExists()
        {
            try
            {
                SqlConnection con = new SqlConnection("Data Source=CELESTE;Initial Catalog=BankingAppDB;Integrated Security=True;Encrypt=True;TrustServerCertificate=True");
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                string selectQuery = "SELECT * FROM Customer Where cusID='" + txtCusID.Text.Trim() + "'";
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
            txtCusID.Text = "";
            txtCusName.Text = "";
            txtCusLast.Text = "";
            txtNum.Text = "";
        }

        void addNewCustomer()
        {
            string generatedIdNum = Guid.NewGuid().ToString("N").Substring(0, 13); // take first 13 chars for id num

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
                INSERT INTO Customer (name, surname, mobileNum, idNum, nationality, emailAddress, password, confPassword) 
                VALUES (@name, @surname, @mobileNumber, @idNum,
                        'South Africa',  -- default nationality
                        CONCAT(@mobileNumber, '-', NEWID(), '@default.com'), -- auto-generate email
                        'DefaultPass123',  -- Default password
                        'DefaultPass123')";
        
            using (SqlCommand cmd = new SqlCommand(insertQuery, con))
                    {
                        cmd.Parameters.AddWithValue("@name", txtCusName.Text.Trim());
                        cmd.Parameters.AddWithValue("@surname", txtCusLast.Text.Trim());
                        cmd.Parameters.AddWithValue("@mobileNumber", txtNum.Text.Trim());
                        cmd.Parameters.AddWithValue("@idNum", generatedIdNum);

                        cmd.ExecuteNonQuery();
                    }
                }

                Response.Write("<script>alert('Customer added successfully!');</script>");
                clearForm();
                GridView1.DataBind();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }


        void updateCustomer()
        {
            try
            {
                SqlConnection con = new SqlConnection("Data Source=CELESTE;Initial Catalog=BankingAppDB;Integrated Security=True;Encrypt=True;TrustServerCertificate=True");
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                string updateQuery = "UPDATE Customer SET name=@name, surname=@surname, mobileNum=@mobileNum WHERE cusID='" + txtCusID.Text.Trim() + "'";
                SqlCommand cmd = new SqlCommand(updateQuery, con);
                cmd.Parameters.AddWithValue("@name", txtCusName.Text.Trim());
                cmd.Parameters.AddWithValue("@surname", txtCusLast.Text.Trim());
                cmd.Parameters.AddWithValue("@mobileNum", txtNum.Text.Trim());

                cmd.ExecuteNonQuery();
                con.Close();
                Response.Write("<script>alert('Customer updated successfully!');</script>");
                clearForm();
                GridView1.DataBind();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

        void deleteCustomer()
        {
            try
            {
                SqlConnection con = new SqlConnection("Data Source=CELESTE;Initial Catalog=BankingAppDB;Integrated Security=True;Encrypt=True;TrustServerCertificate=True");
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                string deleteQuery = "DELETE FROM Customer WHERE cusID='" + txtCusID.Text.Trim() + "'";
                SqlCommand cmd = new SqlCommand(deleteQuery, con);

                cmd.ExecuteNonQuery();
                con.Close();
                Response.Write("<script>alert('Customer deleted successfully!');</script>");
                clearForm();
                GridView1.DataBind();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if(checkIfCustomerExists())
            {
                Response.Write("<script>alert('Customer already exists!' Please use a different Customer ID');</script>");
            }
            else
            {
                addNewCustomer();
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (checkIfCustomerExists())
            {
                updateCustomer();
            }
            else
            {
                Response.Write("<script>alert('Customer does not exist.' Please add customer to database');</script>");
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            if (checkIfCustomerExists())
            {
                deleteCustomer();
            }
            else
            {
                Response.Write("<script>alert('Customer does not exist.' Please add customer to database');</script>");
            }
        }

        protected void btnGO_Click(object sender, EventArgs e)
        {

        }      
    }
}