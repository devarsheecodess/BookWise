<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="WebForm2.aspx.cs" Inherits="LibrarySystem.WebForm2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .home-container {
            display: flex;
            flex-direction: column;
            gap: 30px;
        }

        .stats {
            display: flex;
            gap: 40px;
        }

        .card {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            min-width: 200px;
            text-align: center;
        }

        .card h2 {
            font-size: 22px;
            margin-bottom: 10px;
            color: #333;
        }

        .card span {
            font-size: 26px;
            font-weight: bold;
            color: #1abc9c;
        }

        .time-section {
            margin-top: 30px;
            font-size: 18px;
        }
    </style>

    <div class="home-container">
        <div class="stats">
            <div class="card">
                <h2>Total Books</h2>
                <span><asp:Label ID="lblTotalBooks" runat="server" Text="0" /></span>
            </div>
            <div class="card">
                <h2>Borrowed Books</h2>
                <span><asp:Label ID="lblBorrowedBooks" runat="server" Text="0" /></span>
            </div>
        </div>

        <div class="card time-section">
            <p>Time: <asp:Label ID="lblTime" runat="server" /></p>
            <p>Date: <asp:Label ID="lblDate" runat="server" /></p>
            <p>Day: <asp:Label ID="lblDay" runat="server" /></p>
        </div>
    </div>
</asp:Content>
