<%@ Page Title="Admin Dashboard" Language="C#" MasterPageFile="~/BankingApp.Master" AutoEventWireup="true" CodeBehind="AdminPage.aspx.cs" Inherits="BankingApp.WebForm7" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section id="admin-options" class="services-section section-bg"> <%-- Reusing services-section styles, added section-bg for light gray background --%>
        <div class="container py-4">

            <div class="section-title" data-aos="fade-up">
                <h2>Admin Dashboard</h2>
                <p>Manage customers, accounts, and transactions.</p>
            </div>

            <div class="row gy-4 justify-content-center">

                <%-- Customer Management Card --%>
                <div class="col-lg-4 col-md-6 d-flex align-items-stretch" data-aos="fade-up" data-aos-delay="100">
                    <asp:HyperLink NavigateUrl="~/CustomerManagement.aspx" CssClass="service-card text-decoration-none" runat="server">
                        <i class="bi bi-people-fill card-img-top-icon"></i> <%-- Bootstrap Icon --%>
                        <div class="card-body">
                            <h5 class="card-title">Customer Management</h5>
                            <p class="card-text">View, add, edit, or delete customer information.</p>
                        </div>
                    </asp:HyperLink>
                </div>

                <%-- Account Management Card --%>
                <div class="col-lg-4 col-md-6 d-flex align-items-stretch" data-aos="fade-up" data-aos-delay="200">
                    <asp:HyperLink NavigateUrl="~/AccountManagement.aspx" CssClass="service-card text-decoration-none" runat="server">
                         <i class="bi bi-credit-card-2-front-fill card-img-top-icon"></i> <%-- Bootstrap Icon --%>
                        <div class="card-body">
                            <h5 class="card-title">Account Management</h5>
                            <p class="card-text">View, create, update, or delete customer accounts.</p>
                        </div>
                    </asp:HyperLink>
                </div>

                <%-- Transaction Management Card --%>
                <div class="col-lg-4 col-md-6 d-flex align-items-stretch" data-aos="fade-up" data-aos-delay="300">
                    <asp:HyperLink NavigateUrl="~/TransManagement.aspx" CssClass="service-card text-decoration-none" runat="server">
                         <i class="bi bi-file-earmark-text-fill card-img-top-icon"></i> <%-- Bootstrap Icon --%>
                        <div class="card-body">
                            <h5 class="card-title">View Transactions</h5>
                            <p class="card-text">Review all customer transaction history.</p>
                        </div>
                    </asp:HyperLink>
                </div>

                 <%-- Account Transfers Card (Assuming it goes to the same TransManagement page, update link if needed) --%>
                <div class="col-lg-4 col-md-6 d-flex align-items-stretch" data-aos="fade-up" data-aos-delay="400">
                    <asp:HyperLink NavigateUrl="~/TransManagement.aspx" CssClass="service-card text-decoration-none" runat="server"> <%-- UPDATE NavigateUrl if transfers have a different page --%>
                        <i class="bi bi-arrow-left-right card-img-top-icon"></i> <%-- Bootstrap Icon --%>
                        <div class="card-body">
                            <h5 class="card-title">Account Transfers</h5>
                            <p class="card-text">Perform transfers between accounts (Admin Function).</p> <%-- Clarified purpose --%>
                        </div>
                    </asp:HyperLink>
                </div>

            </div> <%-- End Row --%>
        </div> <%-- End Container --%>
    </section>
</asp:Content>