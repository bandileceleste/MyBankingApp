<%@ Page Title="Customer Management" Language="C#" MasterPageFile="~/BankingApp.Master" AutoEventWireup="true" CodeBehind="CustomerManagement.aspx.cs" Inherits="BankingApp.WebForm5" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-4">
         <div class="section-title" data-aos="fade-up">
             <h2>Customer Management</h2>
             <p>Add, update, or delete customer records.</p>
         </div>
        <div class="row gy-4">
            <!-- Customer Form Column -->
            <div class="col-lg-5" data-aos="fade-right">
                <div class="card shadow-sm h-100">
                    <div class="card-header">
                         <h5 class="mb-0"><i class="bi bi-person-plus-fill me-2"></i>Customer Details</h5>
                     </div>
                    <div class="card-body p-4">

                       <div class="mb-3">
                            <asp:Label runat="server" AssociatedControlID="txtCusID" CssClass="form-label">Customer ID</asp:Label>
                            <div class="input-group">
                                <asp:TextBox CssClass="form-control" ID="txtCusID" runat="server" placeholder="Enter ID to load or leave blank for new"></asp:TextBox>
                                <asp:Button CssClass="btn btn-outline-secondary" ID="btnGO" runat="server" Text="Load" ToolTip="Load Customer" OnClick="btnGO_Click" /> <%-- Changed text/style --%>
                             </div>
                        </div>

                       <div class="row g-3"> 
                            <div class="col-md-6 mb-3">
                                <asp:Label runat="server" AssociatedControlID="txtCusName" CssClass="form-label">First Name</asp:Label>
                                <asp:TextBox CssClass="form-control" ID="txtCusName" runat="server" placeholder="e.g John"></asp:TextBox>
                            </div>
                           <div class="col-md-6 mb-3">
                                <asp:Label runat="server" AssociatedControlID="txtCusLast" CssClass="form-label">Last Name</asp:Label>
                                <asp:TextBox CssClass="form-control" ID="txtCusLast" runat="server" placeholder="e.g Smith"></asp:TextBox>
                           </div>
                            <div class="col-md-6 mb-3">
                                <asp:Label runat="server" AssociatedControlID="txtNum" CssClass="form-label">Mobile Number</asp:Label>
                                <asp:TextBox CssClass="form-control" ID="txtNum" runat="server" placeholder="e.g 0784710023" TextMode="Phone"></asp:TextBox>
                           </div>
                       </div>

                       <div class="row mt-4">
                            <div class="col-12 d-flex justify-content-between gap-2">
                               <asp:Button CssClass="btn btn-success flex-grow-1" ID="btnAdd" runat="server" Text="Add" OnClick="btnAdd_Click"></asp:Button>
                               <asp:Button CssClass="btn btn-primary flex-grow-1" ID="btnUpdate" runat="server" Text="Update" OnClick="btnUpdate_Click"></asp:Button>
                               <asp:Button CssClass="btn btn-danger flex-grow-1" ID="btnDelete" runat="server" Text="Delete" OnClick="btnDelete_Click" OnClientClick="return confirm('Are you sure you want to delete this customer and all associated accounts/transactions?');"></asp:Button> <%-- Added strong confirmation --%>
                            </div>
                       </div>
                    </div>
                </div>
            </div>

            <!-- Customer List Column -->
            <div class="col-lg-7" data-aos="fade-left" data-aos-delay="100">
                 <div class="card shadow-sm h-100">
                     <div class="card-header">
                         <h5 class="mb-0"><i class="bi bi-list-ul me-2"></i>Existing Customers</h5>
                     </div>
                     <div class="card-body">
                        <div class="table-responsive">
                            <asp:GridView ID="GridView1" runat="server"
                                AutoGenerateColumns="False"
                                DataSourceID="CustomerTable"
                                CssClass="table table-striped table-bordered table-hover"
                                GridLines="None"> 
                                <Columns>
                                    <asp:BoundField DataField="cusID" HeaderText="Customer ID" ReadOnly="True" SortExpression="cusID" />
                                    <asp:BoundField DataField="name" HeaderText="First Name" SortExpression="name" />
                                    <asp:BoundField DataField="surname" HeaderText="Last Name" SortExpression="surname" />
                                    <asp:BoundField DataField="mobileNum" HeaderText="Mobile Number" SortExpression="mobileNum" />
                                </Columns>
                                <EmptyDataTemplate>No customers found.</EmptyDataTemplate>
                            </asp:GridView>
                         </div>
                         <asp:SqlDataSource ID="CustomerTable" runat="server" ConnectionString="<%$ ConnectionStrings:BankingAppDBConnectionString %>" SelectCommand="SELECT [cusID], [name], [surname], [mobileNum] FROM [Customer] ORDER BY [cusID]"></asp:SqlDataSource>
                     </div>
                 </div>
           </div>
        </div>
    </div>
</asp:Content>