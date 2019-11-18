<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewCommentsReply.aspx.cs" Inherits="cms_admin_Moduls_Product_PopUp_Items_ViewCommentsReply" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Trả lời bình luận</title>
    <style type="text/css">
        body{font:normal 12px Arial;width:750px;margin:auto}
        .pt15{padding-top:15px}
        .pb5{padding-bottom:5px}
        .cb{clear:both}
        .h10{height:10px}
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div class="pt15 pb5">
        Người trả lời:<br />
        <asp:TextBox ID="tbName" runat="server" Width="300px"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" SetFocusOnError="true" Display="Dynamic" ControlToValidate="tbName"></asp:RequiredFieldValidator>
    </div>
    <div class="pb5">
        Nội dung:<br />
        <asp:TextBox ID="tbNoiDung" runat="server" TextMode="MultiLine" Width="700px" Height="80px"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" SetFocusOnError="true" Display="Dynamic" ControlToValidate="tbNoiDung"></asp:RequiredFieldValidator>
    </div>
    <div>
        <asp:Button ID="btOK" runat="server" Text="Trả lời" onclick="btOK_Click" />
        <asp:Button ID="btCancel" runat="server" Text="Quay lại" CausesValidation="false" onclick="btCancel_Click"/>
    </div>
    <div class="pt15 pb5"><b>Danh sách trả lời đã gửi:</b></div>
    <asp:Repeater ID="rptList" runat="server" onitemcommand="rptList_ItemCommand">
        <ItemTemplate>
            <div>Ngày trả lời: <%#Eval(TatThanhJsc.Columns.SubitemsColumns.DscreatedateColumn) %></div>
            <div>Người trả lời: <%#Eval(TatThanhJsc.Columns.SubitemsColumns.VsatuthorColumn) %></div>
            <div>Nội dung: <%#Eval(TatThanhJsc.Columns.SubitemsColumns.VscontentColumn) %></div>                
            <div><asp:LinkButton ID="lbtDelete" CommandName="delete" CommandArgument="<%#Eval(TatThanhJsc.Columns.SubitemsColumns.IsidColumn) %>" OnClientClick="return confirm('Bạn có chắc chắn muốn xoá trả lời này?')" runat="server" CausesValidation="false">Xoá</asp:LinkButton></div>
            <div class="cb h10"><!----></div>
        </ItemTemplate>    
    </asp:Repeater>    
    </form>
</body>
</html>
