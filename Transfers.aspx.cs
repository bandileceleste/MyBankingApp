using System;
using System.Configuration; // handles ConnectionStrings
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BankingApp
{
    public partial class Transfers : System.Web.UI.Page
    {
        // Retrieve connection string from Web.config
        private readonly string _connectionString = ConfigurationManager.ConnectionStrings["BankingAppDBConnectionString"]?.ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // check if user is logged in
            if (Session["cusID"] == null || string.IsNullOrEmpty(Session["cusID"].ToString()))
            {
                Response.Redirect("LoginPage.aspx", true); // redirect to login if session is invalid
                return;
            }

            if (string.IsNullOrEmpty(_connectionString))
            {
                ShowMessage("Database connection string is missing or invalid.", true);
                return;
            }


            if (!IsPostBack)
            {
                PopulateMyAccountsDropdowns();
                BindAccountGrid();
                BindTransactionGrid();
            }
            // hide message label on every load unless explicitly shown
            lblMessage.Visible = false;
        }

        // populates dropdown lists with the logged-in user's accounts
        private void PopulateMyAccountsDropdowns()
        {
            string cusId = Session["cusID"].ToString();
            DataTable dtAccounts = new DataTable();

            string query = "SELECT accID, accType, balance FROM Account WHERE cusID = @cusID ORDER BY accType";

            try
            {
                using (SqlConnection con = new SqlConnection(_connectionString))
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@cusID", cusId);
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        sda.Fill(dtAccounts);
                    }
                }

                // add descriptive text field combining useful info
                dtAccounts.Columns.Add("AccountInfo", typeof(string));
                foreach (DataRow row in dtAccounts.Rows)
                {
                    row["AccountInfo"] = $"{row["accID"]} - {row["accType"]} (Balance: {Convert.ToDecimal(row["balance"]):C})";
                }


                // add default item
                ListItem defaultItem = new ListItem("-- Select Account --", "--");

                // add internal transfer Dropdowns
                ddlFromAccountInternal.DataSource = dtAccounts;
                ddlFromAccountInternal.DataTextField = "AccountInfo";
                ddlFromAccountInternal.DataValueField = "accID";
                ddlFromAccountInternal.DataBind();
                ddlFromAccountInternal.Items.Insert(0, defaultItem);


                ddlToAccountInternal.DataSource = dtAccounts;
                ddlToAccountInternal.DataTextField = "AccountInfo";
                ddlToAccountInternal.DataValueField = "accID";
                ddlToAccountInternal.DataBind();
                ddlToAccountInternal.Items.Insert(0, defaultItem);

                // Populate External Transfer Dropdown
                ddlFromAccountExternal.DataSource = dtAccounts;
                ddlFromAccountExternal.DataTextField = "AccountInfo";
                ddlFromAccountExternal.DataValueField = "accID";
                ddlFromAccountExternal.DataBind();
                ddlFromAccountExternal.Items.Insert(0, defaultItem);
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading accounts: " + ex.Message, true);
            }
        }

        // binds the logged-in user's accounts to the GridView
        private void BindAccountGrid()
        {
            string cusId = Session["cusID"].ToString();
            string query = "SELECT accID, accType, balance FROM Account WHERE cusID = @cusID ORDER BY accType";

            try
            {
                using (SqlConnection con = new SqlConnection(_connectionString))
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@cusID", cusId);
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        grdMyAccounts.DataSource = dt;
                        grdMyAccounts.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading accounts grid: " + ex.Message, true);
            }
        }

        // updates the logged-in user's transactions to the GridView
        private void BindTransactionGrid()
        {
            string cusId = Session["cusID"].ToString();
            // select transactions only for accounts belonging to the current customer
            string query = @"
                 SELECT t.transID, t.accID, t.transType, t.amount, t.transDate
                 FROM Transact t
                 INNER JOIN Account a ON t.accID = a.accID
                 WHERE a.cusID = @cusID
                 ORDER BY t.transDate DESC"; // show most recent first

            try
            {
                using (SqlConnection con = new SqlConnection(_connectionString))
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@cusID", cusId);
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        grdMyTransactions.DataSource = dt;
                        grdMyTransactions.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading transaction grid: " + ex.Message, true);
            }
        }

        protected void grdMyTransactions_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdMyTransactions.PageIndex = e.NewPageIndex;
            BindTransactionGrid(); // Rebind the grid with the new page index
        }

        // gets the current balance of a specific account
        private decimal GetAccountBalance(SqlConnection con, SqlTransaction transaction, string accountId)
        {
            string query = "SELECT balance FROM Account WHERE accID = @accID";
            using (SqlCommand cmd = new SqlCommand(query, con, transaction)) // Use the transaction
            {
                cmd.Parameters.AddWithValue("@accID", accountId);
                object result = cmd.ExecuteScalar();
                return result != null && result != DBNull.Value ? Convert.ToDecimal(result) : -1; // Return -1 or throw exception if not found
            }
        }

        // records a transaction
        private void RecordTransaction(SqlConnection con, SqlTransaction transaction, string accountId, string transType, decimal amount)
        {
            string insertQuery = "INSERT INTO Transact (accID, transType, amount, transDate) VALUES (@accID, @transType, @amount, @transDate)";
            using (SqlCommand cmd = new SqlCommand(insertQuery, con, transaction))
            {
                cmd.Parameters.AddWithValue("@accID", accountId);
                cmd.Parameters.AddWithValue("@transType", transType);
                cmd.Parameters.AddWithValue("@amount", amount);
                cmd.Parameters.AddWithValue("@transDate", DateTime.Now);
                cmd.ExecuteNonQuery();
            }
        }

        // updates account balance
        private bool UpdateBalance(SqlConnection con, SqlTransaction transaction, string accountId, decimal newBalance)
        {
            string updateQuery = "UPDATE Account SET balance = @newBalance WHERE accID = @accID";
            using (SqlCommand cmd = new SqlCommand(updateQuery, con, transaction))
            {
                cmd.Parameters.AddWithValue("@newBalance", newBalance);
                cmd.Parameters.AddWithValue("@accID", accountId);
                return cmd.ExecuteNonQuery() > 0; // returns true if update was successful
            }
        }


        // handles the internal transfers
        protected void btnInternalTransfer_Click(object sender, EventArgs e)
        {
            // vlaidation
            if (ddlFromAccountInternal.SelectedValue == "--" || ddlToAccountInternal.SelectedValue == "--")
            {
                ShowMessage("Please select both 'From' and 'To' accounts.", true);
                return;
            }
            if (ddlFromAccountInternal.SelectedValue == ddlToAccountInternal.SelectedValue)
            {
                ShowMessage("Cannot transfer to the same account.", true);
                return;
            }
            if (!decimal.TryParse(txtInternalAmount.Text, out decimal amount) || amount <= 0)
            {
                ShowMessage("Please enter a valid positive amount.", true);
                return;
            }

            string fromAccountId = ddlFromAccountInternal.SelectedValue;
            string toAccountId = ddlToAccountInternal.SelectedValue;

            SqlConnection con = null;
            SqlTransaction transaction = null;

            try
            {
                con = new SqlConnection(_connectionString);
                con.Open();
                transaction = con.BeginTransaction(); // start SQL transaction

                // check sender's balance
                decimal fromBalance = GetAccountBalance(con, transaction, fromAccountId);
                if (fromBalance < amount)
                {
                    ShowMessage("Insufficient funds in the 'From' account.", true);
                    transaction?.Rollback(); // use null-conditional operator
                    return;
                }

                // check if 'To' account exists-dropdown population should ensure this
                decimal toBalance = GetAccountBalance(con, transaction, toAccountId);
                if (toBalance < 0) // check if account was found by GetAccountBalance
                {
                    ShowMessage("Recipient account could not be found.", true);
                    transaction?.Rollback();
                    return;
                }


                // 3. Perform Updates within Transaction
                decimal newFromBalance = fromBalance - amount;
                decimal newToBalance = toBalance + amount;

                if (!UpdateBalance(con, transaction, fromAccountId, newFromBalance) || !UpdateBalance(con, transaction, toAccountId, newToBalance))
                {
                    ShowMessage("Failed to update account balances.", true);
                    transaction?.Rollback();
                    return;
                }

                // 4. Record Transactions within Transaction
                RecordTransaction(con, transaction, fromAccountId, "Internal Transfer Out", -amount); // Record as negative amount for outgoing
                RecordTransaction(con, transaction, toAccountId, "Internal Transfer In", amount);


                // commit transaction
                transaction.Commit();
                ShowMessage($"Successfully transferred {amount:C} from {fromAccountId} to {toAccountId}.", false);

                // refresh UI
                PopulateMyAccountsDropdowns(); // balances have changed
                BindAccountGrid();
                BindTransactionGrid();
                ClearInternalForm();
            }
            catch (Exception ex)
            {
                transaction?.Rollback(); // rollback on error
                ShowMessage("An error occurred during internal transfer: " + ex.Message, true);
            }
            finally
            {
                // close connection
                con?.Close();
            }
        }


        // Handles the External Transfer button click
        protected void btnExternalTransfer_Click(object sender, EventArgs e)
        {
            // validation
            if (ddlFromAccountExternal.SelectedValue == "--")
            {
                ShowMessage("Please select an account to transfer from.", true);
                return;
            }
            if (string.IsNullOrWhiteSpace(txtRecipientCusID.Text) || string.IsNullOrWhiteSpace(txtRecipientAccID.Text))
            {
                ShowMessage("Recipient Customer ID and Account ID are required.", true);
                return;
            }
            if (!decimal.TryParse(txtExternalAmount.Text, out decimal amount) || amount <= 0)
            {
                ShowMessage("Please enter a valid positive amount.", true);
                return;
            }

            string fromAccountId = ddlFromAccountExternal.SelectedValue;
            string recipientCusId = txtRecipientCusID.Text.Trim();
            string recipientAccId = txtRecipientAccID.Text.Trim();

            if (fromAccountId.Equals(recipientAccId, StringComparison.OrdinalIgnoreCase))
            {
                ShowMessage("Cannot perform an external transfer to your own account. Use Internal Transfer instead.", true);
                return;
            }


            SqlConnection con = null;
            SqlTransaction transaction = null;

            try
            {
                con = new SqlConnection(_connectionString);
                con.Open();
                transaction = con.BeginTransaction();

                // verify recipient account and ownership
                string verifyRecipientQuery = "SELECT cusID FROM Account WHERE accID = @accID";
                string actualRecipientCusId = null;
                using (SqlCommand verifyCmd = new SqlCommand(verifyRecipientQuery, con, transaction))
                {
                    verifyCmd.Parameters.AddWithValue("@accID", recipientAccId);
                    object result = verifyCmd.ExecuteScalar();
                    if (result != null && result != DBNull.Value)
                    {
                        actualRecipientCusId = result.ToString();
                    }
                }

                if (actualRecipientCusId == null)
                {
                    ShowMessage($"Recipient account ID '{recipientAccId}' not found.", true);
                    transaction?.Rollback();
                    return;
                }
                // check if provided recipient cusID matches the actual owner
                if (!actualRecipientCusId.Equals(recipientCusId, StringComparison.OrdinalIgnoreCase))
                {
                    ShowMessage($"Recipient account ID '{recipientAccId}' does not belong to customer '{recipientCusId}'. Please verify details.", true);
                    transaction?.Rollback();
                    return;
                }

                // check sender's balance
                decimal fromBalance = GetAccountBalance(con, transaction, fromAccountId);
                if (fromBalance < amount)
                {
                    ShowMessage("Insufficient funds in the 'From' account.", true);
                    transaction?.Rollback();
                    return;
                }

                // get recipient's current balance
                decimal recipientBalance = GetAccountBalance(con, transaction, recipientAccId);

                // perform updates within transaction
                decimal newFromBalance = fromBalance - amount;
                decimal newRecipientBalance = recipientBalance + amount;


                if (!UpdateBalance(con, transaction, fromAccountId, newFromBalance) || !UpdateBalance(con, transaction, recipientAccId, newRecipientBalance))
                {
                    ShowMessage("Failed to update account balances.", true);
                    transaction?.Rollback();
                    return;
                }


                // record transactions within Transaction
                string senderTransType = $"External Transfer Out to {recipientAccId}"; // More descriptive type
                string recipientTransType = $"External Transfer In from {fromAccountId}";

                RecordTransaction(con, transaction, fromAccountId, senderTransType, -amount); // Sender log
                RecordTransaction(con, transaction, recipientAccId, recipientTransType, amount); // Recipient log

                // commit transaction
                transaction.Commit();
                ShowMessage($"Successfully transferred {amount:C} from {fromAccountId} to {recipientAccId}.", false);


                // 7. refresh UI
                PopulateMyAccountsDropdowns(); // balances have changed
                BindAccountGrid();
                BindTransactionGrid();
                ClearExternalForm();

            }
            catch (Exception ex)
            {
                transaction?.Rollback();
                ShowMessage("An error occurred during external transfer: " + ex.Message, true);
            }
            finally
            {
                con?.Close();
            }
        }


        // helper method to display messages
        private void ShowMessage(string message, bool isError)
        {
            lblMessage.Text = message;
            lblMessage.CssClass = isError ? "alert alert-danger mt-3" : "alert alert-success mt-3"; // Use Bootstrap alert classes
            lblMessage.Visible = true;
        }

        // clears the internal transfer form
        private void ClearInternalForm()
        {
            ddlFromAccountInternal.SelectedIndex = 0;
            ddlToAccountInternal.SelectedIndex = 0;
            txtInternalAmount.Text = string.Empty;
        }

        // clears the external transfer form
        private void ClearExternalForm()
        {
            ddlFromAccountExternal.SelectedIndex = 0;
            txtRecipientCusID.Text = string.Empty;
            txtRecipientAccID.Text = string.Empty;
            txtExternalAmount.Text = string.Empty;
        }
    }
}