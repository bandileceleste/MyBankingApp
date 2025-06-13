<%@ Page Title="Transaction Management" Language="C#" MasterPageFile="~/BankingApp.Master" AutoEventWireup="true" CodeBehind="TransManagement.aspx.cs" Inherits="BankingApp.WebForm8" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-4">
         <div class="section-title" data-aos="fade-up">
            <h2>Transaction History</h2>
            <p>View all customer transactions.</p>
        </div>
        <div class="row justify-content-center" data-aos="fade-up" data-aos-delay="100"> <%-- Center the column --%>
            <div class="col-lg-10"> <%-- Use a wider column since it's the main content --%>
                <div class="card shadow-sm">
                     <div class="card-header">
                         <h5 class="mb-0"><i class="bi bi-table me-2"></i>All Transactions</h5>
                     </div>
                    <div class="card-body">
                         <div class="table-responsive">
                            <asp:GridView CssClass="table table-striped table-bordered table-hover" ID="grdTrans" runat="server" AutoGenerateColumns="False" DataSourceID="Transactions">
                                <Columns>
                                    <asp:BoundField DataField="transID" HeaderText="Trans. ID" ReadOnly="True" SortExpression="transID" />
                                    <asp:BoundField DataField="accID" HeaderText="Account ID" SortExpression="accID" />
                                    <asp:BoundField DataField="transType" HeaderText="Type" SortExpression="transType" />
                                    <asp:BoundField DataField="amount" HeaderText="Amount" SortExpression="amount" DataFormatString="{0:C}"/>
                                    <asp:BoundField DataField="transDate" HeaderText="Date" SortExpression="transDate" DataFormatString="{0:yyyy-MM-dd HH:mm}"/>
                                </Columns>
                                 <EmptyDataTemplate>No transactions found.</EmptyDataTemplate>
                            </asp:GridView>
                         </div>
                        <asp:SqlDataSource ID="Transactions" runat="server" ConnectionString="<%$ ConnectionStrings:BankingAppDBConnectionString %>" SelectCommand="SELECT [transID], [accID], [transType], [amount], [transDate] FROM [Transact] ORDER BY [transDate] DESC"></asp:SqlDataSource> <%-- Ordered by date descending --%>
                    </div> <%-- End card-body --%>
                </div> <%-- End card --%>
            </div> <%-- End col-lg-10 --%>
        </div> <%-- End row --%>
    </div> <%-- End container --%>
</asp:Content>