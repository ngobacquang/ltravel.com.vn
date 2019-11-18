<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CopyItemFromOtherSite.aspx.cs" Inherits="cms_admin_TempControls_PopUp_Items_CopyItemFromOtherSite" %>

<%@ Register Src="~/cms/admin/Moduls/CommonControls/AdmCautionStop.ascx" TagPrefix="uc1" TagName="AdmCautionStop" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Copy tin từ website trong cùng hệ thống</title>
    
    <link href="../../../cs/Common.css" rel="stylesheet" />
    <link href="CopyItemFromOtherSite/css.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <asp:Panel ID="pnStop" runat="server">
            <uc1:AdmCautionStop runat="server" ID="AdmCautionStop" />
        </asp:Panel>
        <asp:Panel ID="pnContent" runat="server" Visible="False">
        <div class="titlepage">Sao chép tin</div>
        
        <div class="cot1">
            <div class="head">Nguồn</div>
            <div class="h10"><!----></div>
            <div class="row">
                <div class="text">Chọn website</div>
                <div class="control">
                    <asp:DropDownList ID="ddlWebSource" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlWebSource_SelectedIndexChanged"></asp:DropDownList>
                </div>
                <div class="cb"></div>
            </div>
            <div class="row">
                <div class="text">Chọn ngôn ngữ</div>
                <div class="control">
                    <asp:DropDownList ID="ddlLanguageSource" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlLanguageSource_SelectedIndexChanged"></asp:DropDownList>
                </div>
                <div class="cb"></div>
            </div>
            <div class="row">
                <div class="text">Chọn modul</div>
                <div class="control">
                    <asp:DropDownList ID="ddlModulSource" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlModulSource_SelectedIndexChanged"></asp:DropDownList>
                </div>
                <div class="cb"></div>
            </div>
            <div class="row">
                <div class="text">Chọn danh mục</div>
                <div class="control">
                    <asp:DropDownList ID="ddlCateSource" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlCateSource_SelectedIndexChanged"></asp:DropDownList>
                </div>
                <div class="cb"></div>
            </div>
        </div>
        
        <div class="cot2">
            <div class="head">Đích</div>
            <div class="h10"><!----></div>
            <div class="row">
                <div class="text">Chọn ngôn ngữ</div>
                <div class="control">
                    <asp:DropDownList ID="ddlLanguageDest" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlLanguageDest_SelectedIndexChanged"></asp:DropDownList>
                </div>
                <div class="cb"></div>
            </div>
            <div class="row">
                <div class="text">Chọn modul</div>
                <div class="control">
                    <asp:DropDownList ID="ddlModulDest" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlModulDest_SelectedIndexChanged"></asp:DropDownList>
                </div>
                <div class="cb"></div>
            </div>
            <div class="row">
                <div class="text">Chọn danh mục</div>
                <div class="control">
                    <asp:DropDownList ID="ddlCateDest" runat="server"></asp:DropDownList>
                </div>
                <div class="cb"></div>
            </div>
        </div>
        <div class="cb h10"><!----></div>
        
        <div class="head">Danh sách tin tìm thấy <span class="fwn">(Click chọn một tin và nhấn Tiếp tục)</span></div>
        <div class="list">
            <asp:ListBox ID="lbListItem" runat="server" CssClass="listbox"></asp:ListBox>
        </div>
        <div class="tar pt10 pb10">
            <asp:Button ID="btNext" runat="server" Text="Tiếp tục" OnClick="btNext_Click" />
        </div>
        <div>
            <asp:Literal ID="ltrIframe" runat="server"></asp:Literal>
        </div>
        
        <asp:Panel ID="pnLoginOtherSite" runat="server" Visible="False">
            <div class="head">Ngoài ra bạn có thể truy cập để quản trị các web site khác trong hệ thống</div>
            <div class="row pt20">
                <div class="text">Chọn website</div>
                <div class="control">
                    <asp:DropDownList ID="ddlWebToLogin" runat="server"></asp:DropDownList>
                </div>
                <div class="cb"></div>
            </div>
            <div class="tar pt10 pb10">
                <asp:Button ID="btLogin" runat="server" Text="Đăng nhập" CausesValidation="False" OnClick="btLogin_Click"/>
            </div>
        </asp:Panel>
        </asp:Panel>
    </form>
    
</body>
</html>
