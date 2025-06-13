<%@ Page Title="User Login" Language="C#" MasterPageFile="~/BankingApp.Master" AutoEventWireup="true" CodeBehind="LoginPage.aspx.cs" Inherits="BankingApp.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-5" data-aos="fade-up">
                <div class="card shadow-sm">
                    <div class="card-body p-4 p-md-5">

                        <div class="text-center mb-4">
                            <i class="bi bi-person-circle fs-1 text-primary"></i>
                            <h3 class="mt-2">User Login</h3>
                        </div>

                        <div class="mb-3">
                            <asp:Label AssociatedControlID="txtEmail" CssClass="form-label" runat="server">Email address</asp:Label>
                            <asp:TextBox ID="txtEmail" CssClass="form-control" runat="server" TextMode="Email" placeholder="your.email@example.com"></asp:TextBox>
                            <asp:RequiredFieldValidator
                                ID="RequiredFieldValidator1" runat="server"
                                ErrorMessage="Email is required!"
                                ControlToValidate="txtEmail"
                                CssClass="text-danger small mt-1 d-block">
                            </asp:RequiredFieldValidator>
                        </div>

                        <div class="mb-3">
                             <div class="d-flex justify-content-between">
                                 <asp:Label AssociatedControlID="txtPass" CssClass="form-label" runat="server">Password</asp:Label>
                                 <a href="#!" class="small">Forgot password?</a>
                             </div>
                             <asp:TextBox ID="txtPass" CssClass="form-control" runat="server" TextMode="Password"></asp:TextBox>
                             <asp:RequiredFieldValidator
                                ID="RequiredFieldValidator2" runat="server"
                                ErrorMessage="Password field cannot be empty!"
                                ControlToValidate="txtPass"
                                CssClass="text-danger small mt-1 d-block">
                             </asp:RequiredFieldValidator>
                         </div>

                         <div class="form-check mb-3">
                             <asp:CheckBox ID="CheckBox1" CssClass="form-check-input" runat="server" Checked="True" />
                             <asp:Label AssociatedControlID="CheckBox1" class="form-check-label" runat="server"> Remember me </asp:Label>
                        </div>

                         <div class="d-grid mb-3">
                            <asp:Button ID="btnLogin" CssClass="btn btn-primary btn-lg" runat="server" Text="Log in" OnClick="btnLogin_Click" />
                         </div>

                        <div class="text-center">
                             <asp:Label ID="lblMessage" runat="server" CssClass="text-danger" Visible="false"></asp:Label>
                         </div>

                        <!-- register link -->
                        <div class="text-center mt-3">
                             <p class="mb-0">Not a member? <a href="RegistrationPage.aspx">Register</a></p>
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