<%@ Page Title="Account Management" Language="C#" MasterPageFile="~/BankingApp.Master" AutoEventWireup="true" CodeBehind="AccountManagement.aspx.cs" Inherits="BankingApp.WebForm3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-4">
         <div class="section-title" data-aos="fade-up"> <%-- Added section title --%>
             <h2>Account Management</h2>
             <p>Add, update, or delete customer accounts.</p>
         </div>
        <div class="row gy-4">
            <!-- Account Form Column -->
            <div class="col-lg-5" data-aos="fade-right">
                <div class="card shadow-sm h-100">
                    <div class="card-header">
                        <h5 class="mb-0"><i class="bi bi-pencil-square me-2"></i>Account Details</h5> <%-- Icon added --%>
                    </div>
                    <div class="card-body p-4">

                        <div class="row g-3"> <%-- g-3 for gutters --%>
                            <div class="col-md-6 mb-3"> <%-- Use mb-3 or put labels+inputs in own rows --%>
                                <asp:Label runat="server" AssociatedControlID="txtAccID" CssClass="form-label">Account ID</asp:Label>
                                <asp:TextBox CssClass="form-control" ID="txtAccID" runat="server" placeholder="e.g u0001"></asp:TextBox>
                                <%-- Add validation controls if needed --%>
                            </div>
                            <div class="col-md-6 mb-3">
                                <asp:Label runat="server" AssociatedControlID="txtCusID" CssClass="form-label">Customer ID</asp:Label>
                                <asp:TextBox CssClass="form-control" ID="txtCusID" runat="server" placeholder="e.g c0001"></asp:TextBox>
                             </div>

                            <div class="col-md-6 mb-3">
                                <asp:Label runat="server" AssociatedControlID="ddlAcc" CssClass="form-label">Account Type</asp:Label>
                                <asp:DropDownList ID="ddlAcc" runat="server" CssClass="form-select"></asp:DropDownList>
                            </div>
                            <div class="col-md-6 mb-3">
                                <asp:Label runat="server" AssociatedControlID="txtBalance" CssClass="form-label">Balance</asp:Label>
                                <asp:TextBox CssClass="form-control" ID="txtBalance" runat="server" placeholder="e.g 1000.00" TextMode="Number" Step="0.01"></asp:TextBox> <%-- Added Number type --%>
                            </div>
                         </div>

                        <%-- Button Row --%>
                        <div class="row mt-4">
                             <div class="col-12 d-flex justify-content-between gap-2"> <%-- Flexbox for button spacing --%>
                                <asp:Button CssClass="btn btn-success flex-grow-1" ID="btnAdd" runat="server" Text="Add" OnClick="btnAdd_Click"></asp:Button>
                                <asp:Button CssClass="btn btn-primary flex-grow-1" ID="btnUpdate" runat="server" Text="Update" OnClick="btnUpdate_Click"></asp:Button>
                                <asp:Button CssClass="btn btn-danger flex-grow-1" ID="btnDelete" runat="server" Text="Delete" OnClick="btnDelete_Click" OnClientClick="return confirm('Are you sure you want to delete this account?');"></asp:Button> <%-- Added confirmation --%>
                            </div>
                       </div>
                    </div> <%-- End card-body --%>
                </div> <%-- End card --%>
            </div> <%-- End col-lg-5 --%>

            <!-- Account List Column -->
            <div class="col-lg-7" data-aos="fade-left" data-aos-delay="100">
                <div class="card shadow-sm h-100">
                     <div class="card-header">
                         <h5 class="mb-0"><i class="bi bi-list-ul me-2"></i>Existing Accounts</h5> <%-- Icon added --%>
                     </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <asp:GridView CssClass="table table-striped table-bordered table-hover" ID="grdAcc" runat="server" AutoGenerateColumns="False" DataSourceID="Accounts">
                                <Columns>
                                    <asp:BoundField DataField="accID" HeaderText="Account ID" ReadOnly="True" SortExpression="accID" />
                                    <asp:BoundField DataField="cusID" HeaderText="Customer ID" SortExpression="cusID" />
                                    <asp:BoundField DataField="accType" HeaderText="Account Type" SortExpression="accType" />
                                    <asp:BoundField DataField="balance" HeaderText="Balance" SortExpression="balance" DataFormatString="{0:C}" /> <%-- Format as currency --%>
                                </Columns>
                                <EmptyDataTemplate>No accounts found.</EmptyDataTemplate>
                            </asp:GridView>
                        </div>
                        <asp:SqlDataSource ID="Accounts" runat="server" ConnectionString="<%$ ConnectionStrings:BankingAppDBConnectionString %>" SelectCommand="SELECT [accID], [cusID], [accType], [balance] FROM [Account] ORDER BY [accType]"></asp:SqlDataSource>
                    </div> <%-- End card-body --%>
                </div> <%-- End card --%>
           </div> <%-- End col-lg-7 --%>
        </div> <%-- End row --%>
    </div> <%-- End container --%>
</asp:Content>