<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewComments.aspx.cs" Inherits="cms_admin_ModulMain_PhotoAlbum_PopUp_Items_ViewComments" ValidateRequest="false"%>
<%@ Import Namespace="TatThanhJsc.Extension" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Phản hồi của album về album</title>        
    <script src="../../../../js/TWindow.js" type="text/javascript"></script>
    <link href="ViewComments/_cs.css" rel="stylesheet" type="text/css" />
    <link href="../../../../cs/Common.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">    
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate> 
    <div id="ViewComments">
    <div class="w900 ma ffTahoma fs12">        
        
        <div class='fwb pb10 pt10'>
            Danh sách các phản hồi:            
        </div>
        <div class='pb5 pl10'>            
            <asp:CheckBox ID="chk_list" runat="server" AutoPostBack="true" oncheckedchanged="chk_list_CheckedChanged" /> Chọn/bỏ chọn tất cả
            &nbsp;&nbsp;
            <span class='iconDelete'><!----></span>
            <asp:LinkButton ID="btDelete" runat="server"
            ToolTip="Click để xoá các phản hồi đang chọn" CssClass="lbtInsert"  
            OnClientClick="return confirm('Bạn có chắc chắn muốn xóa các mục vừa chọn?');"
            onclick="btDelete_Click">Xoá các phản hồi đang chọn</asp:LinkButton>            
        </div>        
        <div class="bdas">
            <asp:Repeater ID="rptList" runat="server" onitemcommand="rptList_ItemCommand">
                <ItemTemplate>
                    <div class='pt5 pb15 pl10 pr10 bdbs <%#currentCommentView(Eval("isid").ToString()) %>'>                        
                        <div class='pb5 bdbs'>
                            <div class='fl bdrs pr10'>
                                <asp:CheckBox ID="chk_item" runat="server" ToolTip='<%#Eval("isid") %>'/> Chọn
                            </div>
                            <div class='fl bdrs pl10 pr10 pt3'>
                                Đã duyệt: <asp:LinkButton ID="LinkButton4" runat="server" CommandName="EditEnable" CommandArgument='<%#Eval("isid").ToString() %>' ToolTip="Click vào để thay đổi trạng thái">
                                        <div class="EnableIcon<%#Eval(TatThanhJsc.Columns.SubitemsColumns.IsenableColumn).ToString()%>"><!----></div>
                                </asp:LinkButton>
                            </div>
                            <div class='fl bdrs pl10 pr10 pt3'>
                                <asp:LinkButton ToolTip="Click để xóa mục đang chọn" ID="lnk_delete" runat="server" CssClass="lbtInsert" CommandName="delete" CommandArgument='<%#Eval("isid").ToString() %>'>Xoá</asp:LinkButton>
                            </div>
                            <div class='fl pl10 pt3'>
                                <a class="lbtInsert" href="javascript:NewWindow_('<%=UrlExtension.WebisteUrl %>cms/admin/Moduls/PhotoAlbum/Item/Popup/ViewCommentsReply.aspx?iid=<%#Eval("IID")%>&isid=<%#Eval("isid")%>','ImageList','950','600','yes','yes')">Trả lời</a>
                            </div>                            
                            <a name="<%#Eval("isid") %>">&nbsp;</a>
                            <div class='cb'><!----></div>
                        </div>
                        <div class='lh20'>
                            Ngày gửi: <%#Eval(TatThanhJsc.Columns.SubitemsColumns.DscreatedateColumn).ToString()%>
                            <br />Họ tên: <%#Eval(TatThanhJsc.Columns.SubitemsColumns.VstitleColumn).ToString() %>
                            <br />Email: <%#Eval(TatThanhJsc.Columns.SubitemsColumns.VsemailColumn).ToString() %>
                            <br /><br />Nội dung: <%#Eval(TatThanhJsc.Columns.SubitemsColumns.VscontentColumn).ToString()%>                            
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>            
        </div>
        <div class='cbh20'><!----></div>
        <asp:Literal ID="ltrHotelName" runat="server"></asp:Literal>        
    </div>
    </div>
    </ContentTemplate>
    </asp:UpdatePanel>
    </form>
</body>
</html>
