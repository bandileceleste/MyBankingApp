<%@ Page Title="Admin Login" Language="C#" MasterPageFile="~/BankingApp.Master" AutoEventWireup="true" CodeBehind="AdminLogin.aspx.cs" Inherits="BankingApp.WebForm6" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-5" data-aos="fade-up">  
                <div class="card shadow-sm">
                    <div class="card-body p-4 p-md-5"> 

                        <div class="text-center mb-4">
                             <i class="bi bi-person-badge-fill fs-1 text-primary"></i> 
                             <h3 class="mt-2">Admin Login</h3>
                         </div>

                        <!-- form inputs -->
                        <div class="mb-3">
                            <asp:Label AssociatedControlID="txtAdmin" CssClass="form-label" runat="server">Admin ID</asp:Label>
                            <asp:TextBox ID="txtAdmin" CssClass="form-control" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator
                                ID="RequiredFieldValidator1" runat="server"
                                ErrorMessage="Admin ID is required!"
                                ControlToValidate="txtAdmin"
                                CssClass="text-danger small mt-1 d-block"> 
                             </asp:RequiredFieldValidator>
                        </div>

                        <div class="mb-3">
                            <asp:Label AssociatedControlID="txtPasscode" CssClass="form-label" runat="server">Password</asp:Label>
                            <asp:TextBox ID="txtPasscode" CssClass="form-control" runat="server" TextMode="Password"></asp:TextBox>
                             <asp:RequiredFieldValidator
                                ID="RequiredFieldValidator2" runat="server"
                                ErrorMessage="Password field cannot be empty!"
                                ControlToValidate="txtPasscode"
                                CssClass="text-danger small mt-1 d-block">
                             </asp:RequiredFieldValidator>
                        </div>

                        <div class="d-grid mb-3">
                           <asp:Button ID="btnAdmin" CssClass="btn btn-primary btn-lg" runat="server" Text="Sign in" OnClick="btnAdmin_Click" />
                        </div>

                        <!-- error message -->
                        <div class="text-center">
                            <asp:Label ID="lblErrorMessage" runat="server" CssClass="text-danger" Visible="false"></asp:Label>
                        </div>

                         <hr class="my-4">

                        <!-- Back to Home link -->
                         <div class="text-center">
                             <a href="HomePage.aspx"><i class="bi bi-arrow-left me-1"></i>Back To Home</a>
                         </div>

                    </div>
                </div>
            </div>
        </div> 
    </div>
</asp:Content>