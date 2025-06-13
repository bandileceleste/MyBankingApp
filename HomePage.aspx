<%@ Page Title="Home - Celeste Bank" Language="C#" MasterPageFile="~/BankingApp.Master" AutoEventWireup="true" CodeBehind="HomePage.aspx.cs" Inherits="BankingApp.WebForm2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <section id="hero-banking"> 
        <div class="container" data-aos="zoom-in" data-aos-delay="100">
            <h1>Welcome to Celeste Bank</h1>
            <h2>Experience Secure and Convenient Banking</h2>
            <a href="LoginPage.aspx" class="btn-get-started scrollto">Login / Get Started</a>
        </div>
    </section>

    <section id="services" class="services-section"> 
        <div class="container">

            <div class="section-title" data-aos="fade-up">
                <h2>Our Services</h2>
                <p>Access a wide range of banking services securely and conveniently after logging in.</p>
            </div>

            <div class="row gy-4 justify-content-center">

                <div class="col-lg-3 col-md-6 d-flex align-items-stretch" data-aos="fade-up" data-aos-delay="100">
                     <asp:HyperLink NavigateUrl="~/LoginPage.aspx" CssClass="service-card text-decoration-none" runat="server">
                        <i class="bi bi-cash-stack card-img-top-icon"></i>
                        <div class="card-body">
                            <h5 class="card-title">Cash Withdrawal</h5>
                            <p class="card-text">Withdraw your cash at your nearest ATM at <em>ZERO BANKING FEES!</em></p>
                        </div>
                     </asp:HyperLink>
                </div>

                <div class="col-lg-3 col-md-6 d-flex align-items-stretch" data-aos="fade-up" data-aos-delay="200">
                    <asp:HyperLink NavigateUrl="~/LoginPage.aspx" CssClass="service-card text-decoration-none" runat="server">
                        <i class="bi bi-box-arrow-in-down card-img-top-icon"></i>
                        <div class="card-body">
                            <h5 class="card-title">Cash Deposit</h5>
                            <p class="card-text">Celeste Banking enables you to do cash deposits at your nearest ATM at <em>NO EXTRA COST!</em></p>
                        </div>
                    </asp:HyperLink>
                </div>

                <div class="col-lg-3 col-md-6 d-flex align-items-stretch" data-aos="fade-up" data-aos-delay="300">
                     <asp:HyperLink NavigateUrl="~/LoginPage.aspx" CssClass="service-card text-decoration-none" runat="server">
                        <i class="bi bi-piggy-bank card-img-top-icon"></i>
                        <div class="card-body">
                            <h5 class="card-title">Savings</h5>
                            <p class="card-text">Grow your future. Open up your high-interest savings account with us!</p>
                        </div>
                    </asp:HyperLink>
                </div>

                <div class="col-lg-3 col-md-6 d-flex align-items-stretch" data-aos="fade-up" data-aos-delay="400">
                     <asp:HyperLink NavigateUrl="~/LoginPage.aspx" CssClass="service-card text-decoration-none" runat="server">
                        <i class="bi bi-arrow-left-right card-img-top-icon"></i>
                        <div class="card-body">
                            <h5 class="card-title">Transfers</h5>
                            <p class="card-text">Perform local and international bank transfers quickly and securely!</p>
                        </div>
                    </asp:HyperLink>
                </div>

            </div>

        </div> 
    </section>

</asp:Content>