<%@ Page Title="User Profile" Language="C#" MasterPageFile="~/BankingApp.Master" AutoEventWireup="true" CodeBehind="UserProfile.aspx.cs" Inherits="BankingApp.UserProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-4">
        <div class="row gy-4">

            <!-- User Profile Column -->
            <div class="col-lg-5" data-aos="fade-right">
                <div class="card shadow-sm h-100"> 
                    <div class="card-header text-center">
                         <i class="bi bi-person-circle fs-1 mb-2"></i> 
                         <h4>Your Profile</h4>
                    </div>
                    <div class="card-body p-4">

                        <!-- user information to be displayed in read-only textboxes -->
                        <div class="row mb-3">
                             <div class="col-md-6">
                                <asp:Label ID="Label1" runat="server" Text="First Name(s)" CssClass="form-label"></asp:Label>
                                <asp:TextBox ID="txtFirst" runat="server" ReadOnly="True" CssClass="form-control"></asp:TextBox>
                            </div>
                             <div class="col-md-6">
                                <asp:Label ID="Label2" runat="server" Text="Last Name" CssClass="form-label"></asp:Label>
                                <asp:TextBox ID="txtLast" runat="server" ReadOnly="True" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <asp:Label ID="Label4" runat="server" Text="ID/Passport Number" CssClass="form-label"></asp:Label>
                                <asp:TextBox ID="txtID" runat="server" ReadOnly="True" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="col-md-6">
                                <asp:Label ID="Label5" runat="server" Text="Nationality" CssClass="form-label"></asp:Label>
                                <asp:TextBox ID="txtNation" runat="server" ReadOnly="True" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <asp:Label ID="Label6" runat="server" Text="Mobile Number" CssClass="form-label"></asp:Label>
                                <asp:TextBox ID="txtNum" runat="server" TextMode="Phone" CssClass="form-control"></asp:TextBox> <!-- mobile is editable -->
                            </div>
                            <div class="col-md-6">
                                <asp:Label ID="Label7" runat="server" Text="Email Address" CssClass="form-label"></asp:Label>
                                <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" CssClass="form-control"></asp:TextBox> <!-- email is editable -->
                            </div>
                        </div>

                         <div class="row mb-3">
                             <div class="col-md-4">
                                <asp:Label ID="Label8" runat="server" Text="Customer ID" CssClass="form-label"></asp:Label>
                                <asp:TextBox ID="txtCusID" runat="server" ReadOnly="True" CssClass="form-control"></asp:TextBox>
                             </div>
                              <div class="col-md-4">
                                 <asp:Label ID="Label9" runat="server" Text="Old Password" CssClass="form-label"></asp:Label>
                                 <asp:TextBox ID="txtOldPass" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="col-md-4">
                                 <asp:Label ID="Label3" runat="server" Text="New Password" CssClass="form-label"></asp:Label>
                                 <asp:TextBox ID="txtNewPass" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                            </div>
                         </div>

                         <div class="d-grid gap-2 mt-4">
                            <asp:Button ID="btnUpdate" CssClass="btn btn-primary btn-lg" runat="server" Text="Update Profile" OnClick="btnUpdate_Click"/>
                            <asp:HyperLink ID="lnkGoToTransfers" runat="server" NavigateUrl="~/Transfers.aspx" CssClass="btn btn-success btn-lg">
                                <i class="bi bi-arrow-left-right me-2"></i>Make a Transfer
                            </asp:HyperLink>
                         </div>
                     </div> 
                </div>
            </div> 

            <!-- transactions & accounts section -->
            <div class="col-lg-7" data-aos="fade-left" data-aos-delay="100">
                <div class="card shadow-sm h-100">
                    <div class="card-header text-center">
                        <i class="bi bi-receipt fs-1 mb-2"></i>
                         <h4>Transactions & Accounts</h4>
                    </div>
                    <div class="card-body p-4">

                        <!-- transaction section -->
                        <h5 class="mb-3">Perform Transaction</h5>
                        <div class="row g-3 mb-3"> 
                            <div class="col-md-4">
                                <asp:Label ID="Label10" runat="server" Text="Account ID" CssClass="form-label"></asp:Label>
                                <asp:TextBox ID="txtAcc" Placeholder="e.g. u0001" CssClass="form-control" runat="server"></asp:TextBox>
                            </div>
                            <div class="col-md-4">
                                <asp:Label ID="Label11" runat="server" Text="Transaction Type" CssClass="form-label"></asp:Label>
                                <asp:DropDownList ID="ddlType" runat="server" CssClass="form-select"></asp:DropDownList> 
                            </div>
                            <div class="col-md-4">
                                <asp:Label ID="Label12" runat="server" Text="Amount" CssClass="form-label"></asp:Label>
                                <asp:TextBox ID="txtAmount" Placeholder="e.g. 500.00" CssClass="form-control" runat="server"></asp:TextBox>
                            </div>
                        </div>
                         <div class="d-grid mb-4">
                            <asp:Button ID="btnTransact" CssClass="btn btn-success" runat="server" Text="Perform Transaction" OnClick="btnAdd_Click"/>
                         </div>

                         <hr />

                        <!-- transactions history section -->
                         <h5 class="mt-4 mb-3">Transaction History</h5>
                         <div class="table-responsive">
                            <asp:GridView CssClass="table table-striped table-bordered table-hover" ID="grdTransaction" runat="server" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:BoundField DataField="transID" HeaderText="Transaction ID" ReadOnly="True" SortExpression="transID" />
                                    <asp:BoundField DataField="accID" HeaderText="Account ID" SortExpression="accID" />
                                    <asp:BoundField DataField="transType" HeaderText="Transaction Type" SortExpression="transType" />
                                    <asp:BoundField DataField="amount" HeaderText="Amount" SortExpression="amount" />
                                    <asp:BoundField DataField="transDate" HeaderText="Transaction Date" SortExpression="transDate" />
                                </Columns>
                                <EmptyDataTemplate>No transactions found.</EmptyDataTemplate>
                            </asp:GridView>
                         </div>

                         <hr />

                        <!-- accounts information section -->
                         <h5 class="mt-4 mb-3">Accounts Information</h5>
                         <div class="table-responsive">
                            <asp:GridView CssClass="table table-striped table-bordered table-hover" ID="grdAccounts" runat="server" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:BoundField DataField="accID" HeaderText="Account ID" ReadOnly="True" SortExpression="accID" />
                                    <asp:BoundField DataField="accType" HeaderText="Account Type" SortExpression="accType" />
                                    <asp:BoundField DataField="balance" HeaderText="Current Balance" SortExpression="balance" DataFormatString="{0:C}"/> <%-- Format as currency --%>
                                </Columns>
                                <EmptyDataTemplate>No accounts found.</EmptyDataTemplate>
                            </asp:GridView>
                         </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>