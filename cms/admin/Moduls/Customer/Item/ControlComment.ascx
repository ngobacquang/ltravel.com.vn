<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ControlComment.ascx.cs" Inherits="cms_admin_Moduls_Customer_Item_ControlComment" %>
<%@ Register TagPrefix="cc1" Namespace="CssJscriptOptimizer.Controls" Assembly="CssJscriptOptimizer" %>
<cc1:StyleSheetCombiner ID="sheetCombiner" runat="server"><link href="~/cms/admin/Moduls/Customer/Item/ControlComment/_cs.css" rel="stylesheet" type="text/css" /></cc1:StyleSheetCombiner>

<asp:HiddenField ID="hd_time" runat="server" />
<div id="ControlComment">
    <div class="BgTabTool">        
        <a href="javascript:DeleteListSubItems()" class="LinkDelete"><%=Developer.CustomerKeyword.Xoa%></a>                                   
    </div>

    <div class="BgTabTitle" align="center">
        <div class="cot1 pt5" align="center"><input id="checkAll" type="checkbox" onchange="CheckAllCheckBox('CbItem',this)"/></div>
        <div class="split">|</div>                    
        <div class="cot2" align="left">        
            <%=Developer.CustomerKeyword.ThongTinNguoiGui %>
        </div>
        <div class="split">|</div>                    
        <div class="cot3">
            <%=Developer.CustomerKeyword.TrichNoiDung %>
        </div>                        
        <div class="split">|</div>                    
        <div class="cot5">
            <%=Developer.CustomerKeyword.TrangThai %>
        </div>                        
        <div class="split">|</div>                    
        <div class="fr pr5"><%=Developer.CustomerKeyword.CongCu %></div>                    
        <div class="cb"><!----></div>
    </div>
    
    <div align="center" class="content">
        <asp:Repeater ID="rp_mn_users" runat="server">
            <ItemTemplate>
                <div id="Item-<%#Eval("ISID").ToString()%>">
                    <div class="bgItem">
                        <div class="cot1"><input id="CbItem_<%#Eval("ISID").ToString() %>" type="checkbox" /></div>                            
                        <div class="split">|</div>                            
                        <div class="cot2" align="left">
                            <div><b>Họ tên:</b> <%#Eval(TatThanhJsc.Columns.SubitemsColumns.VsatuthorColumn).ToString() %></div>
                            <div class="pt5"><b>Email:</b> <%#Eval(TatThanhJsc.Columns.SubitemsColumns.VsemailColumn).ToString()%></div>
                            <div class="pt5"><b>Gửi lúc:</b> <%#Eval(TatThanhJsc.Columns.SubitemsColumns.DscreatedateColumn).ToString() %></div>
                        </div>
                        <div class="split">|</div>                            
                        <div class="cot3" align="left">                            
                            <%#TatThanhJsc.Extension.StringExtension.GetCharInDesc(200,Eval(TatThanhJsc.Columns.SubitemsColumns.VscontentColumn).ToString(),true) %>
                        </div>                                                    
                        <div class="split">|</div>                            
                        <div class="cot5" align="center">
                            <a id="nc<%#Eval("ISID").ToString()%>" href="javascript:UpdateEnableSubItem(<%#Eval("ISID").ToString()%>)" class="EnableIcon<%#Eval("ISENABLE").ToString()%>">&nbsp;</a>
                        </div>
                        <div class="split">|</div>                            
                        <div class="fr tool pr5">                            
                            <a title="Click để xem chi tiết phản hồi này" href="javascript:void(0)" onclick="NewWindow_('cms/admin/Moduls/Customer/Item/Popup/ViewComments.aspx?iid=<%#Eval("IID")%>&isid=<%#Eval("isid")%>#<%#Eval("isid")%>','ImageList','950','600','yes','yes')"><span class='iconPhanHoi'><!----></span></a>
                            <a href="javascript:DeleteSubItem('<%#Eval("ISID").ToString()%>','<%#Eval("VSTITLE").ToString()%>')"><span class='iconDelete'><!----></span></a>                            
                        </div>
                        <div class="cbh0"><!----></div>                        
                    </div>
                </div>          
            </ItemTemplate>
            <SeparatorTemplate><div class="vien"><!----></div></SeparatorTemplate>
        </asp:Repeater>
    </div>
    <div class="cb h25"><!----></div>
    <div id="FooterRightControl">
        <div class="pdFooterR">
            <div class="ColShowItem">
                <div class="TextShow">Hiển thị</div>
                <div class="BoxShow">
                    <asp:DropDownList ID="DdlListShowItem" runat="server" Width="50px" Height="19px" CssClass="TextInBox">
                        <asp:ListItem Value="10">10</asp:ListItem>
                        <asp:ListItem Value="20">20</asp:ListItem>
                        <asp:ListItem Value="30">30</asp:ListItem>
                        <asp:ListItem Value="50">50</asp:ListItem>
                        <asp:ListItem Value="100">100</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="cb"><!----></div>
            </div>
            <div class="ColPagging"><div id="AdminPagging"><asp:Literal ID="LtPagging" runat="server"></asp:Literal></div></div>
            <div class="cbh0"><!----></div>
        </div>
    </div>
</div>
