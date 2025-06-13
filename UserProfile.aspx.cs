using System;
using System.Linq;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BankingApp
{
    public partial class UserProfile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) // Prevents reloading on every postback
            {
                ddlType.Items.Add(new ListItem("Select", ""));
                ddlType.Items.Add(new ListItem("Deposit", "1"));
                ddlType.Items.Add(new ListItem("Withdraw", "2"));

                if (Session["cusID"] == null || string.IsNullOrEmpty(Session["cusID"].ToString()))
                {
                    Response.Redirect("LoginPage.aspx"); // Redirect to login if session is null
                }
                else
                {
                    displayCustomerDetails();
                    displayCustomerAccounts();
                   displayTransactions();
                }
            }
        }

        void displayCustomerDetails()
        {
            try
            {
                using (SqlConnection con = new SqlConnection("Data Source=CELESTE;Initial Catalog=BankingAppDB;Integrated Security=True;Encrypt=True;TrustServerCertificate=True"))
                {
                    string selectQuery = "SELECT * FROM Customer Where cusID=@cusID";
                    using (SqlCommand cmd = new SqlCommand(selectQuery, con))
                    {
                        cmd.Parameters.AddWithValue("@cusID", Session["cusID"].ToString());
                        con.Open();
                        SqlDataReader dr = cmd.ExecuteReader();

                        if (dr.Read())
                        {
                            txtCusID.Text = dr["cusID"].ToString();
                            txtFirst.Text = dr["name"].ToString();
                            txtLast.Text = dr["surname"].ToString();
                            txtNum.Text = dr["mobileNum"].ToString();
                            txtID.Text = dr["idNum"].ToString();
                            txtNation.Text = dr["nationality"].ToString();
                            txtEmail.Text = dr["emailAddress"].ToString();
                            txtOldPass.Text = dr["password"].ToString();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

        // check if ac
        bool checkIfAccountExists()
        {
            try
            {
                using (SqlConnection con = new SqlConnection("Data Source=CELESTE;Initial Catalog=BankingAppDB;Integrated Security=True;Encrypt=True;TrustServerCertificate=True"))
                {
                    con.Open();
                    string selectQuery = "SELECT * FROM Account WHERE accID=@accID";
                    using (SqlCommand cmd = new SqlCommand(selectQuery, con))
                    {
                        cmd.Parameters.AddWithValue("@accID", txtAcc.Text.Trim());
                        SqlDataReader dr = cmd.ExecuteReader();
                        return dr.HasRows;
                    }
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
            txtAcc.Text = "";
            txtAmount.Text = "";
        }

        // retrieve customer info from cusID session and display in GridView
        void displayCustomerAccounts()
        {
            try
            {
                using (SqlConnection con = new SqlConnection("Data Source=CELESTE;Initial Catalog=BankingAppDB;Integrated Security=True;Encrypt=True;TrustServerCertificate=True"))
                {
                    string query = "SELECT accID, accType, balance FROM Account WHERE cusID = @cusID";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@cusID", Session["cusID"].ToString());
                        using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            sda.Fill(dt);
                            grdAccounts.DataSource = dt;
                            grdAccounts.DataBind();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

        // method to perform transaction based on transaction type
        void addTransaction()
        {
            try
            {
                using (SqlConnection con = new SqlConnection("Data Source=CELESTE;Initial Catalog=BankingAppDB;Integrated Security=True;Encrypt=True;TrustServerCertificate=True"))
                {
                    con.Open();

                    string balanceQuery = "SELECT balance FROM Account WHERE accID = @accID";
                    double currentBalance = 0;

                    // check if account exists
                    using (SqlCommand balancecmd = new SqlCommand(balanceQuery, con))
                    {
                        balancecmd.Parameters.AddWithValue("@accID", txtAcc.Text.Trim());
                        object result = balancecmd.ExecuteScalar();
                        if (result != null)
                            currentBalance = Convert.ToDouble(result);
                        else
                        {
                            Response.Write("<script>alert('Account not found.');</script>");
                            return;
                        }
                    }

                    double transAmount = Convert.ToDouble(txtAmount.Text.Trim());
                    double newBalance = currentBalance;

                    // perform transaction based on transaction type: 1=Deposit, 2=Withdrawal
                    if (ddlType.SelectedItem.Value == "1")
                        newBalance += transAmount;
                    else if (ddlType.SelectedItem.Value == "2")
                    {
                        if (transAmount > currentBalance)
                        {
                            Response.Write("<script>alert('Insufficient funds!');</script>");
                            return;
                        }
                        newBalance -= transAmount;
                    }

                    // update the remaining balance in the account
                    using (SqlCommand updateCmd = new SqlCommand("UPDATE Account SET balance = @newBalance WHERE accID=@accID", con))
                    {
                        updateCmd.Parameters.AddWithValue("@newBalance", newBalance);
                        updateCmd.Parameters.AddWithValue("@accID", txtAcc.Text.Trim());
                        updateCmd.ExecuteNonQuery();
                    }

                    // insert the transaction into the transaction table
                    using (SqlCommand cmd = new SqlCommand("INSERT INTO Transact (accID, transType, amount, transDate) VALUES (@accID, @transType, @amount, @transDate)", con))
                    {
                        cmd.Parameters.AddWithValue("@accID", txtAcc.Text.Trim());
                        cmd.Parameters.AddWithValue("@transType", ddlType.SelectedItem.Text);
                        cmd.Parameters.AddWithValue("@amount", transAmount);
                        cmd.Parameters.AddWithValue("@transDate", DateTime.Now);
                        cmd.ExecuteNonQuery();
                    }
                }

                Response.Write("<script>alert('Transaction added successfully!');</script>");
                displayTransactions();
                displayCustomerAccounts();
                clearForm();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

        // updates the user's profile
        void updateProfile()
        {
            try
            {
                using (SqlConnection con = new SqlConnection("Data Source=CELESTE;Initial Catalog=BankingAppDB;Integrated Security=True;Encrypt=True;TrustServerCertificate=True"))
                {
                    con.Open();

                    // query that updates user information that is updateable
                    string updateQuery = @"
                    UPDATE Customer 
                    SET mobileNum=@mobileNum, 
                    emailAddress=@emailAddress, 
                    password=@password, 
                    confPassword=@password
                    WHERE cusID=@cusID";

                    using (SqlCommand cmd = new SqlCommand(updateQuery, con))
                    {
                        cmd.Parameters.AddWithValue("@mobileNum", txtNum.Text.Trim());
                        cmd.Parameters.AddWithValue("@emailAddress", txtEmail.Text.Trim());
                        cmd.Parameters.AddWithValue("@password", txtNewPass.Text.Trim());
                        cmd.Parameters.AddWithValue("@cusID", txtCusID.Text.Trim());

                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            Response.Write("<script>alert('Profile updated successfully!');</script>");
                        }
                        else
                        {
                            Response.Write("<script>alert('No changes made! Check your inputs.');</script>");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }
        }

        // casts the user's transactions onto the GridView
        void displayTransactions()
        {
            try
            {
                using (SqlConnection con = new SqlConnection("Data Source=CELESTE;Initial Catalog=BankingAppDB;Integrated Security=True;Encrypt=True;TrustServerCertificate=True"))
                {
                    string query = "SELECT * FROM Transact WHERE accID=@accID";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@accID", txtAcc.Text.Trim());
                        using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            sda.Fill(dt);
                            grdTransaction.DataSource = dt;
                            grdTransaction.DataBind();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

        // handles creation of new transaction
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if (checkIfAccountExists())
            {
                addTransaction();
            }
            else
            {
                Response.Write("<script>alert('None existent account. Please use an existing account to add transaction.')");
            }
        }

        // handles update of user details
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            updateProfile();
            displayCustomerDetails();
        }
    }
}