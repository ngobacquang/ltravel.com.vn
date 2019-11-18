<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddTags.aspx.cs" Inherits="cms_admin_TempControls_PopUp_Items_AddTags" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add Tag</title>
    <link href="../../../cs/Common.css" rel="stylesheet" />
    <link href="AddTags/css.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <div id="AddTags">
        <div class="pb15 fwb pt10">Bài viết: <asp:Literal ID="ltrTenBaiViet" runat="server"></asp:Literal></div>
        <div class="fl">
            Tích chọn các tag cần thêm cho bài viết này
        </div>
        <div class="fr">
            Tìm tag theo modul: 
            <asp:DropDownList ID="ddlTagModul" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlTagModul_SelectedIndexChanged"></asp:DropDownList>
        </div>
        <div class="cb"><!----></div>
        <div class="listTag">
            <asp:CheckBoxList ID="cblListTag" runat="server"></asp:CheckBoxList>
        </div>
        <div class="pt10">
            <asp:Button ID="btSave" runat="server" Text="Lưu lại" OnClick="btSave_Click" />
        </div>
    </div>
    </form>
</body>
</html>
