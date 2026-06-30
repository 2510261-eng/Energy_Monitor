<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="EnergyMonitor._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <%-- Página raíz: redirige a la pantalla de login local --%>
    <asp:Literal runat="server" Text='<meta http-equiv="refresh" content="0;url=/WebSite/Login.aspx" />' />
</asp:Content>
