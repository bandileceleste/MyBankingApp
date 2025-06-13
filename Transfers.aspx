<%@ Page Title="Make Transfers" Language="C#" MasterPageFile="~/BankingApp.Master" AutoEventWireup="true" CodeBehind="Transfers.aspx.cs" Inherits="BankingApp.Transfers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .nav-link.active {
            background-color: #0d6efd !important;
            color: white !important;
            border-color: #0d6efd #0d6efd #dee2e6 !important; 
        }
        .nav-tabs .nav-link {
             color: #0d6efd;
        }
         .tab-content {
            border: 1px solid #dee2e6;
            border-top: none;
            padding: 1.5rem;
            border-bottom-left-radius: 0.25rem;
            border-bottom-right-radius: 0.25rem;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-4">

        <div class="section-title" data-aos="fade-up">
            <h2>Funds Transfer</h2>
            <p>Move funds between your accounts or send money to other customers.</p>
        </div>

        <asp:Label ID="lblMessage" runat="server" CssClass="alert" Visible="false"></asp:Label>

        <div class="row gy-4">
             <!-- Transfer Forms Column -->
            <div class="col-lg-6" data-aos="fade-right">
                <div class="card shadow-sm h-100">
                    <div class="card-header">
                         <h5 class="mb-0"><i class="bi bi-arrow-left-right me-2"></i>Make a Transfer</h5>
                    </div>
                     <div class="card-body p-3">
                        <!-- Nav Tabs -->
                        <ul class="nav nav-tabs mb-3" id="transferTabs" role="tablist">
                          <li class="nav-item" role="presentation">
                            <button class="nav-link active" id="internal-tab" data-bs-toggle="tab" data-bs-target="#internal-transfer" type="button" role="tab" aria-controls="internal-transfer" aria-selected="true">Internal Transfer</button>
                          </li>
                          <li class="nav-item" role="presentation">
                            <button class="nav-link" id="external-tab" data-bs-toggle="tab" data-bs-target="#external-transfer" type="button" role="tab" aria-controls="external-transfer" aria-selected="false">External Transfer</button>
                          </li>
                        </ul>

                        <!-- Tab Content -->
                        <div class="tab-content" id="transferTabContent">

                          <!-- Internal Transfer Pane -->
                          <div class="tab-pane fade show active" id="internal-transfer" role="tabpanel" aria-labelledby="internal-tab">
                            <h6 class="mb-3">Transfer Between Your Accounts</h6>
                            <div class="mb-3">
                                <asp:Label AssociatedControlID="ddlFromAccountInternal" CssClass="form-label" runat="server">From Account:</asp:Label>
                                <asp:DropDownList ID="ddlFromAccountInternal" runat="server" CssClass="form-select"></asp:DropDownList>
                                <asp:RequiredFieldValidator InitialValue="--" ControlToValidate="ddlFromAccountInternal" CssClass="text-danger small mt-1 d-block" ErrorMessage="Please select account to transfer from." runat="server" />
                            </div>
                             <div class="mb-3">
                                <asp:Label AssociatedControlID="ddlToAccountInternal" CssClass="form-label" runat="server">To Account:</asp:Label>
                                <asp:DropDownList ID="ddlToAccountInternal" runat="server" CssClass="form-select"></asp:DropDownList>
                                <asp:RequiredFieldValidator InitialValue="--" ControlToValidate="ddlToAccountInternal" CssClass="text-danger small mt-1 d-block" ErrorMessage="Please select account to transfer to." runat="server" />
                                <asp:CompareValidator ControlToValidate="ddlToAccountInternal" ControlToCompare="ddlFromAccountInternal" Operator="NotEqual" Type="String"
                                     CssClass="text-danger small mt-1 d-block" ErrorMessage="Cannot transfer to the same account." runat="server" />
                            </div>
                             <div class="mb-3">
                                <asp:Label AssociatedControlID="txtInternalAmount" CssClass="form-label" runat="server">Amount:</asp:Label>
                                <asp:TextBox ID="txtInternalAmount" runat="server" TextMode="SingleLine" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ControlToValidate="txtInternalAmount" CssClass="text-danger small mt-1 d-block" ErrorMessage="Amount is required." runat="server" />
                                <asp:CompareValidator ControlToValidate="txtInternalAmount" Operator="DataTypeCheck" Type="Currency" CssClass="text-danger small mt-1 d-block" ErrorMessage="Please enter a valid amount." runat="server" />
                                <!-- <asp:CompareValidator ControlToValidate="txtInternalAmount" Operator="GreaterThan" Type="Currency" ValueToCompare="0" CssClass="text-danger small mt-1 d-block" ErrorMessage="Amount must be positive." runat="server" /> -->
                            </div>
                            <div class="d-grid">
                                <asp:Button ID="btnInternalTransfer" runat="server" Text="Transfer Internally" CssClass="btn btn-primary" OnClick="btnInternalTransfer_Click" />
                            </div>
                          </div>

                          <!-- External Transfer Pane -->
                          <div class="tab-pane fade" id="external-transfer" role="tabpanel" aria-labelledby="external-tab">
                             <h6 class="mb-3">Transfer to Another Customer</h6>
                             <div class="mb-3">
                                <asp:Label AssociatedControlID="ddlFromAccountExternal" CssClass="form-label" runat="server">From Account:</asp:Label>
                                <asp:DropDownList ID="ddlFromAccountExternal" runat="server" CssClass="form-select"></asp:DropDownList>
                                <asp:RequiredFieldValidator InitialValue="--" ControlToValidate="ddlFromAccountExternal" CssClass="text-danger small mt-1 d-block" ErrorMessage="Please select account to transfer from." runat="server" />
                             </div>
                             <div class="mb-3">
                                <asp:Label AssociatedControlID="txtRecipientCusID" CssClass="form-label" runat="server">Recipient Customer ID:</asp:Label>
                                <asp:TextBox ID="txtRecipientCusID" runat="server" placeholder="e.g. c0002" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ControlToValidate="txtRecipientCusID" CssClass="text-danger small mt-1 d-block" ErrorMessage="Recipient Customer ID is required." runat="server" />
                             </div>
                             <div class="mb-3">
                                <asp:Label AssociatedControlID="txtRecipientAccID" CssClass="form-label" runat="server">Recipient Account ID:</asp:Label>
                                <asp:TextBox ID="txtRecipientAccID" runat="server" placeholder="e.g. u0003" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ControlToValidate="txtRecipientAccID" CssClass="text-danger small mt-1 d-block" ErrorMessage="Recipient Account ID is required." runat="server" />
                                 <asp:CompareValidator ControlToValidate="txtRecipientAccID" ControlToCompare="ddlFromAccountExternal" Operator="NotEqual" Type="String"
                                    CssClass="text-danger small mt-1 d-block" ErrorMessage="Cannot transfer to your own account externally." runat="server" />
                             </div>
                              <div class="mb-3">
                                <asp:Label AssociatedControlID="txtExternalAmount" CssClass="form-label" runat="server">Amount:</asp:Label>
                                <asp:TextBox ID="txtExternalAmount" runat="server" TextMode="Number" Step="0.01" CssClass="form-control"></asp:TextBox>
                                 <asp:RequiredFieldValidator ControlToValidate="txtExternalAmount" CssClass="text-danger small mt-1 d-block" ErrorMessage="Amount is required." runat="server" />
                                <asp:CompareValidator ControlToValidate="txtExternalAmount" Operator="DataTypeCheck" Type="Currency" CssClass="text-danger small mt-1 d-block" ErrorMessage="Please enter a valid amount." runat="server" />
                                <asp:CompareValidator ControlToValidate="txtExternalAmount" Operator="GreaterThan" Type="Currency" ValueToCompare="0" CssClass="text-danger small mt-1 d-block" ErrorMessage="Amount must be positive." runat="server" />
                            </div>
                            <div class="d-grid">
                                <asp:Button ID="btnExternalTransfer" runat="server" Text="Transfer Externally" CssClass="btn btn-primary" OnClick="btnExternalTransfer_Click"/>
                            </div>
                          </div>
                        </div> 
                    </div> 
                </div> 
            </div> 

             <!-- Accounts & Transactions Column -->
            <div class="col-lg-6" data-aos="fade-left" data-aos-delay="100">
                <div class="card shadow-sm mb-4"> 
                     <div class="card-header">
                         <h5 class="mb-0"><i class="bi bi-wallet2 me-2"></i>Your Accounts</h5>
                     </div>
                     <div class="card-body">
                        <div class="table-responsive">
                            <asp:GridView ID="grdMyAccounts" runat="server" CssClass="table table-striped table-bordered table-hover" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:BoundField DataField="accID" HeaderText="Account ID" />
                                    <asp:BoundField DataField="accType" HeaderText="Type" />
                                    <asp:BoundField DataField="balance" HeaderText="Balance" DataFormatString="{0:C}" />
                                </Columns>
                                <EmptyDataTemplate>You currently have no accounts.</EmptyDataTemplate>
                            </asp:GridView>
                        </div>
                    </div>
                </div>

                <div class="card shadow-sm mt-4"> 
                     <div class="card-header">
                         <h5 class="mb-0"><i class="bi bi-receipt me-2"></i>Recent Transactions</h5>
                     </div>
                    <div class="card-body">
                        <div class="table-responsive">
                           <asp:GridView ID="grdMyTransactions" runat="server" CssClass="table table-striped table-bordered table-hover" AutoGenerateColumns="False" AllowPaging="True" PageSize="5" OnPageIndexChanging="grdMyTransactions_PageIndexChanging">
                                <Columns>
                                     <asp:BoundField DataField="transID" HeaderText="Trans ID" />
                                     <asp:BoundField DataField="accID" HeaderText="Account ID" />
                                     <asp:BoundField DataField="transType" HeaderText="Type" />
                                     <asp:BoundField DataField="amount" HeaderText="Amount" DataFormatString="{0:C}" ItemStyle-CssClass="text-nowrap" >
<ItemStyle CssClass="text-nowrap"></ItemStyle>
                                     </asp:BoundField>
                                     <asp:BoundField DataField="transDate" HeaderText="Date" DataFormatString="{0:yyyy-MM-dd HH:mm}" ItemStyle-CssClass="text-nowrap" >
<ItemStyle CssClass="text-nowrap"></ItemStyle>
                                     </asp:BoundField>
                                </Columns>
                                <EmptyDataTemplate>You have no recent transactions.</EmptyDataTemplate>
                                <PagerStyle CssClass="pagination justify-content-center" HorizontalAlign="Center" />
                           </asp:GridView>
                        </div>
                    </div>
                </div>
            </div> 

        </div>
    </div>
</asp:Content>