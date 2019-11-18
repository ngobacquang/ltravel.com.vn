<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SubControlComment.ascx.cs" Inherits="cms_admin_Moduls_TrainTicket_Item_SubControl_SubControlComment" %>
<%@ Register TagPrefix="cc1" Namespace="CssJscriptOptimizer.Controls" Assembly="CssJscriptOptimizer" %>
<cc1:StyleSheetCombiner ID="sheetCombiner" runat="server">    
    <link href="~/cms/admin/Moduls/TrainTicket/Item/SubControl/SubControlComment/_cs.css" rel="stylesheet" type="text/css" />   
</cc1:StyleSheetCombiner>

<asp:UpdatePanel ID="UpdatePanel1" runat="server">
<ContentTemplate>
<div id="SubTrainTicketComment">    
    <div class="header">
        <div class="tab"><%=subControlsTitle%></div>
        <div class="icon"><a><div class='iconClose'><!----></div></a></div>
        <div class="icon">
            <asp:LinkButton ID="lbtRefresh" runat="server" onclick="lbtRefresh_Click"><div class='iconRefresh'><!----></div></asp:LinkButton>
        </div>
        <div class="cb"><!----></div>
    </div>    
    <div class="content">        
        <div class="head">
            <div class="cot1"><div class="pl15">Thông tin người gửi</div></div>
            <div class="cot2"><div class="pl15">Trích nội dung</div></div>
            <div class="cot3"><div class="pl15">Gửi lúc</div></div>
            <div class="fr pr5">Công cụ</div>
            <div class="cb"><!----></div>
        </div>
        <div class="cb h1"><!----></div>
        <asp:Repeater ID="RpItems" runat="server">
            <ItemTemplate>
                <div class="Item" id="Item-<%#Eval("ISID").ToString()%>">
                    <div class="cot1">
                        <div class="pl15">
                            <div><b>Họ tên:</b> <%#Eval(TatThanhJsc.Columns.SubitemsColumns.VsatuthorColumn).ToString() %></div>
                            <div class="pt5"><b>Email:</b> <%#Eval(TatThanhJsc.Columns.SubitemsColumns.VsemailColumn).ToString()%></div>
                            <div class="pt5"><b>Gửi lúc:</b> <%#Eval(TatThanhJsc.Columns.SubitemsColumns.DscreatedateColumn).ToString() %></div>
                        </div>
                    </div>     
                    <div class="cot2">
                        <div class="pl15">
                            <%#TatThanhJsc.Extension.StringExtension.GetCharInDesc(200,Eval(TatThanhJsc.Columns.SubitemsColumns.VscontentColumn).ToString(),true) %>
                        </div>
                    </div>     
                    <div class="cot3">
                        <div class="pl15">
                            <%#((DateTime)Eval("DUPDATE")).ToString("dd/MM/yyyy - hh:mm:ss tt")%>
                        </div>
                    </div>     
                    <div class="fr tool">
                        <a title="Ẩn / Hiện" id="nc<%#Eval("ISID").ToString()%>" href="javascript:UpdateEnableSubItem(<%#Eval("ISID").ToString()%>)" class="EnableIcon<%#Eval("IIENABLE").ToString() %>">&nbsp;</a>                        
                        <a title="Xem chi tiết phản hồi" href="javascript:void(0)" onclick="TrainTicketWindow_('cms/admin/Moduls/TrainTicket/Item/Popup/ViewComments.aspx?iid=<%#Eval("IID")%>&isid=<%#Eval("isid")%>#<%#Eval("isid")%>','ImageList','950','600','yes','yes')"><span class='iconPhanHoi'><!----></span></a>
                        <a title="Xóa" href="javascript:DeleteSubItem('<%#Eval("ISID").ToString()%>','<%#Eval("VSTITLE").ToString()%>')"><span class='iconDelete'><!----></span></a>
                    </div>
                    <div class="cb"><!----></div>
                </div>
            </ItemTemplate>
        </asp:Repeater>        
    </div>    
</div>
</ContentTemplate>
</asp:UpdatePanel>