<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InformationAccount.aspx.cs" Inherits="cms_admin_ModulMain_User_PopUp_InformationAccount" %>
<%@ Import Namespace="TatThanhJsc.Extension" %>

<%@ Import Namespace="TatThanhJsc"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Chi tiết thông tin tài khoản</title>
    <link href="../cs/css.css" rel="stylesheet" type="text/css" />
    <link href="../../../cs/admin.css" rel="stylesheet" type="text/css" />
    <link href="../../../cs/Common.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <div id="PopUpInformationAccount">
        <div class="bdControl">
            <div class="bgTabControl"><div class="pl10">Thông tin tài khoản:</div></div>
            <div class="pt10 pb10">
            <asp:Repeater ID="rp_information_user" runat="server">
                <ItemTemplate>
                <div>
                    <div class="ColText"><b>Tên tài khoản:</b> </div>
                    <div class="ColValue"><%#Eval("UserName") %></div>
                    <div class="cbh0"><!----></div>
                    <div class="pdSpaceRow"><div class="bgSpaceRow"><div class="h1"><!----></div></div></div>
                    <div class="ColText"><b>Họ và tên:</b> </div>
                    <div class="ColValue"><%#Eval("UserFirstName")%>&nbsp;<%#Eval("UserLastName")%></div>
                    <div class="cbh0"><!----></div>
                    <div class="pdSpaceRow"><div class="bgSpaceRow"><div class="h1"><!----></div></div></div>
                    <div class="ColText"><b>Địa chỉ:</b></div>
                    <div class="ColValue"> <%#Eval("UserAddress")%></div>
                    <div class="cbh0"><!----></div>
                    <div class="pdSpaceRow"><div class="bgSpaceRow"><div class="h1"><!----></div></div></div>
                    <div class="ColText"><b>Số điện thoại:</b></div>
                    <div class="ColValue"><%#Eval("UserPhoneNumber")%></div>
                    <div class="cbh0"><!----></div>
                    <div class="pdSpaceRow"><div class="bgSpaceRow"><div class="h1"><!----></div></div></div>
                    <div class="ColText"><b>Thư điện tử:</b></div>
                    <div class="ColValue"><%#Eval("UserEmail")%></div>
                    <div class="cbh0"><!----></div>                
                    <div class="pdSpaceRow"><div class="bgSpaceRow"><div class="h1"><!----></div></div></div>
                    <div class="ColText"><b>Ngày tạo tài khoản:</b></div>
                    <div class="ColValue"><%#TimeExtension.FormatTime(Eval("UserCreateDate"),6)%></div>
                    <div class="cbh0"><!----></div>
                    <div class="pdSpaceRow"><div class="bgSpaceRow"><div class="h1"><!----></div></div></div>
                    <div class="ColText"><b>Lần đăng nhập cuối cùng:</b></div>
                    <div class="ColValue"><%#TimeExtension.FormatTime(Eval("UserLastLogindate"),6)%></div>
                    <div class="cbh0"><!----></div>
                    <div class="pdSpaceRow"><div class="bgSpaceRow"><div class="h1"><!----></div></div></div>
                    <div class="ColText"><b>Lần đăng xuất cuối cùng:</b></div>
                    <div class="ColValue"><%#TimeExtension.FormatTime(Eval(TatThanhJsc.Columns.UsersColumns.UserlastlockoutdateColumn), 6)%></div>
                    <div class="cbh0"><!----></div>
                    <div class="pdSpaceRow"><div class="bgSpaceRow"><div class="h1"><!----></div></div></div>
                    <div class="ColText"><b>Tình trang:</b></div>
                    <div class="ColValue"><%#Eval("UserIsApproved").ToString() == "1" ? "Đang hoạt động" : "Đang bị khóa"%></div>
                    <div class="cbh0"><!----></div>
                    <div class="pdSpaceRow"><div class="bgSpaceRow"><div class="h1"><!----></div></div></div>
                    <div class="ColText"><b>Ghi chú thêm:</b></div>
                    <div class="ColValue"><%#Eval("UserComment")%></div>
                    <div class="cbh0"><!----></div>
                </div>
                </ItemTemplate>
            </asp:Repeater>
            </div>
        </div>
    </div>
    </form>
</body>
</html>
