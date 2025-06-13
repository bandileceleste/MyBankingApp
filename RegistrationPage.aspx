<%@ Page Title="Register" Language="C#" MasterPageFile="~/BankingApp.Master" AutoEventWireup="true" CodeBehind="RegistrationPage.aspx.cs" Inherits="BankingApp.WebForm4" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-7" data-aos="fade-up">
                <div class="card shadow-sm">
                    <div class="card-body p-4 p-md-5">

                        <div class="text-center mb-4">
                            <i class="bi bi-person-plus-fill fs-1 text-primary"></i>
                            <h3 class="mt-2">Create an Account</h3>
                        </div>

                        <div class="row g-3">
                            <div class="col-md-6">
                                <asp:Label AssociatedControlID="txtFirst" CssClass="form-label" runat="server">First Name(s)</asp:Label>
                                <asp:TextBox ID="txtFirst" CssClass="form-control" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator
                                    ID="RequiredFieldValidator4" runat="server"
                                    ErrorMessage="First name is required!"
                                    ControlToValidate="txtFirst" CssClass="text-danger small mt-1 d-block">
                                 </asp:RequiredFieldValidator>
                            </div>
                            <div class="col-md-6">
                                <asp:Label AssociatedControlID="txtLast" CssClass="form-label" runat="server">Last Name</asp:Label>
                                <asp:TextBox ID="txtLast" CssClass="form-control" runat="server"></asp:TextBox>
                                 <asp:RequiredFieldValidator
                                    ID="RequiredFieldValidator5" runat="server"
                                    ErrorMessage="Last name is required!"
                                    ControlToValidate="txtLast" CssClass="text-danger small mt-1 d-block">
                                 </asp:RequiredFieldValidator>
                            </div>

                             <div class="col-md-6">
                                <asp:Label AssociatedControlID="txtID" CssClass="form-label" runat="server">ID/Passport Number</asp:Label>
                                <asp:TextBox ID="txtID" CssClass="form-control" runat="server"></asp:TextBox>
                                 <asp:RequiredFieldValidator
                                    ID="revID" runat="server"
                                    ErrorMessage="ID or Passport number is required!"
                                    ControlToValidate="txtID" CssClass="text-danger small mt-1 d-block">
                                 </asp:RequiredFieldValidator>
                             </div>
                             <div class="col-md-6">
                                <asp:Label AssociatedControlID="ddlCountries" CssClass="form-label" runat="server">Nationality</asp:Label>
                                <asp:DropDownList ID="ddlCountries" runat="server" CssClass="form-select"></asp:DropDownList>
                             </div>

                            <div class="col-md-6">
                                <asp:Label AssociatedControlID="txtNum" CssClass="form-label" runat="server">Mobile Number</asp:Label>
                                <asp:TextBox ID="txtNum" runat="server" TextMode="Phone" CssClass="form-control" placeholder="e.g. 0712345678"></asp:TextBox>
                                <asp:RequiredFieldValidator
                                    ID="RequiredFieldValidator1" runat="server" ForeColor=""
                                    ErrorMessage="Mobile number required!" Display="Dynamic"
                                    ControlToValidate="txtNum" CssClass="text-danger small mt-1 d-block">
                                 </asp:RequiredFieldValidator>
                                 <asp:RegularExpressionValidator
                                    ID="revMobile" runat="server"
                                    ErrorMessage="Mobile number must be 10 digits!" Display="Dynamic"
                                    ValidationExpression="^\d{10}$"
                                    ControlToValidate="txtNum" CssClass="text-danger small mt-1 d-block">
                                 </asp:RegularExpressionValidator>
                            </div>
                            <div class="col-md-6">
                                <asp:Label AssociatedControlID="txtEmail" CssClass="form-label" runat="server">Email Address</asp:Label>
                                <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" CssClass="form-control" placeholder="your.email@example.com"></asp:TextBox>
                                <asp:RegularExpressionValidator
                                    ID="revEmail" runat="server"
                                    ErrorMessage="Invalid email format!" Display="Dynamic"
                                    ValidationExpression="^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$"
                                    ControlToValidate="txtEmail" CssClass="text-danger small mt-1 d-block">
                                </asp:RegularExpressionValidator>
                             </div>

                             <div class="col-md-6">
                                <asp:Label AssociatedControlID="txtPass" CssClass="form-label" runat="server">Password</asp:Label>
                                <asp:TextBox ID="txtPass" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                                 <asp:RegularExpressionValidator
                                    ID="revPassword" runat="server"
                                    ErrorMessage="Min 8 chars: 1 uppercase, 1 number, 1 special char." Display="Dynamic"
                                    ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$"
                                    ControlToValidate="txtPass" CssClass="text-danger small mt-1 d-block">
                                </asp:RegularExpressionValidator>
                                <%-- Add a RequiredFieldValidator for Password --%>
                            </div>
                            <div class="col-md-6">
                                <asp:Label AssociatedControlID="txtConfirm" CssClass="form-label" runat="server">Confirm Password</asp:Label>
                                <asp:TextBox ID="txtConfirm" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                                 <asp:CompareValidator
                                    ID="cvPassword" runat="server"
                                    ErrorMessage="Passwords do not match!" Display="Dynamic"
                                    ControlToValidate="txtConfirm"
                                    ControlToCompare="txtPass" CssClass="text-danger small mt-1 d-block">
                                </asp:CompareValidator>
                                 <%-- Add a RequiredFieldValidator for Confirm Password --%>
                            </div>
                         </div>

                         <div class="d-grid mt-4 mb-3">
                             <asp:Button ID="btnReg" CssClass="btn btn-primary btn-lg" runat="server" Text="Register" OnClick="btnReg_Click" /> <%-- Removed inline styles --%>
                         </div>

                         <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="alert alert-danger" HeaderText="Please correct the following:" />

                         <div class="text-center">
                            <p>Already have a profile? <a href="LoginPage.aspx">Log In</a></p>
                         </div>

                        <hr class="my-4">

                        <div class="text-center">
                             <a href="HomePage.aspx"><i class="bi bi-arrow-left me-1"></i>Back To Home</a>
                        </div>

                    </div>
                </div> 
            </div>
        </div>
     </div>
</asp:Content>