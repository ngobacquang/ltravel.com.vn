<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SendMesAlert.aspx.cs" Inherits="cms_admin_Moduls_Member_List_PopUp_SendMesAlert" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="PopUp.css" rel="stylesheet" type="text/css" />
</head>
<body class="m0">
    <form id="form1" runat="server">
    <asp:HiddenField ID="HdInsertUpdate" runat="server" />
    <asp:HiddenField ID="HdIsid" runat="server" />

    <div id="SendMesAlert">
        <asp:Panel ID="PnShow" runat="server">
        <div class="BgTabTool"><asp:LinkButton ID="LbSendNotice" runat="server" CssClass="SendNotice" onclick="LbSendNotice_Click">Gửi thông báo</asp:LinkButton></div>
        <div class="BgTabContent">
            <div class="ColInfoNotice"><div class="pdTxtInfo">Thông tin tin nhắn</div></div>
            <div class="ColSpaceNotice">|</div>
            <div class="ColToolNotice">Công cụ</div>
            <div class="cb"><!----></div>
        </div>
        <div>
            <asp:Repeater ID="RpListNoticeBQT" runat="server" 
                onitemcommand="RpListNoticeBQT_ItemCommand">
                <ItemTemplate>
                    <div class="ColInfoNotice">
                        <div class="ContentItem">
                        <b><div><%#Eval("VSTITLE").ToString() %></div></b>
                        <div class="cb5"><!----></div>
                        <div><%#Eval("VSCONTENT").ToString() %></div>
                        </div>
                    </div>
                    <div class="ColSpaceNotice pt10">|</div>
                    <div class="ColToolNotice">
                        <asp:LinkButton ID="LbUpdate" runat="server" CssClass="ToolNotice" CommandName="edit" CommandArgument='<%#Eval("ISID").ToString() %>'>Cập nhật</asp:LinkButton>
                        <asp:LinkButton ID="LbDel" runat="server" CssClass="ToolNotice" CommandName="del" CommandArgument='<%#Eval("ISID").ToString() %>'>Xóa</asp:LinkButton>
                        <div class="cb"><!----></div>
                    </div>
                    <div class="cb"><!----></div>
                    <div class="SpaceItem"><!----></div>

                </ItemTemplate>
            </asp:Repeater>
        </div>
        </asp:Panel>
        <asp:Panel ID="PnFormNotice" runat="server" Visible="False">
            <asp:Literal ID="LtMes" runat="server"></asp:Literal>
            <div class="ColTxt">Tiêu đề:</div>
            <div class="ColVal"><asp:TextBox ID="TbTtl" runat="server" Width="250px"></asp:TextBox></div>
            <div class="cb10"><!----></div>
            <div class="ColTxt">Nội dung:</div>
            <div class="ColVal"><asp:TextBox ID="TbContent" runat="server" Width="550px" Height="120px" TextMode="MultiLine"></asp:TextBox></div>
            <div class="cb10"><!----></div>
            <div class="pdBtn"><asp:Button ID="BtnOk" runat="server" Text="Đồng ý" onclick="BtnOk_Click" /></div>

        </asp:Panel>
    </div>
    </form>
</body>
</html>
