﻿<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ControlItem.ascx.cs" Inherits="cms_admin_Moduls_TrainTicket_Item_ControlItem" %>
<%@ Import Namespace="TatThanhJsc.Extension" %>
<%@ Register TagPrefix="cc1" Namespace="CssJscriptOptimizer.Controls" Assembly="CssJscriptOptimizer" %>
<cc1:StyleSheetCombiner ID="sheetCombiner" runat="server"><link href="~/cms/admin/Moduls/TrainTicket/Item/ControlItem/_cs.css" rel="stylesheet" type="text/css" /></cc1:StyleSheetCombiner>

<asp:HiddenField ID="hd_time" runat="server" />
<div id="admitem">
    <div class="BgTabTool">        
        <a href="<%=LinkCreate() %>" class="LinkCreate"><%=Developer.TrainTicketKeyword.ThemMoi%></a>
        &nbsp;|&nbsp;
        <a href="javascript:DeleteListItems()" class="LinkDelete"><%=Developer.TrainTicketKeyword.Xoa%></a>                   
        <div class="right">            
            <div class="ColPagging"><div class="AdminPagging"><asp:Literal ID="LtPaggingTop" runat="server"></asp:Literal></div></div>
            <div class="ColShowItem">            
                <div class="TextShow">Hiển thị</div>
                <div class="BoxShow">
                    <asp:DropDownList ID="DdlListShowItemTop" runat="server" Width="50px" Height="19px" CssClass="TextInBox" AutoPostBack="True" 
                    onselectedindexchanged="DdlListShowItemTop_SelectedIndexChanged">
                        <asp:ListItem Value="10">10</asp:ListItem>
                        <asp:ListItem Value="20">20</asp:ListItem>
                        <asp:ListItem Value="30">30</asp:ListItem>
                        <asp:ListItem Value="50">50</asp:ListItem>
                        <asp:ListItem Value="100">100</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="cb"><!----></div>
            </div>                                         
        </div>        
    </div>

    <div class="BgTabTitle" align="center">
        <div class="cot1 pt5" align="center"><input id="checkAll" type="checkbox" onchange="CheckAllCheckBox('CbItem',this)"/></div>
        <div class="split">|</div>                    
        <div class="cot2" align="left">        
            <asp:LinkButton ID="lbtName" runat="server" onclick="lbtName_Click" CssClass="arrowSort" ToolTip="Click để sắp xếp danh sách theo trường này"><%=Developer.TrainTicketKeyword.TieuDe %></asp:LinkButton>
        </div>
        <div class="split">|</div>                    
        <div class="cot3">
            <asp:LinkButton ID="lbtDate" runat="server" onclick="lbtDate_Click" CssClass="arrowSort" ToolTip="Click để sắp xếp danh sách theo trường này"><%=Developer.TrainTicketKeyword.NgayDang %></asp:LinkButton>
        </div>                
        <div class="split">|</div>                    
        <div class="cot4">
            <asp:LinkButton ID="lbtView" runat="server" onclick="lbtView_Click" CssClass="arrowSort" ToolTip="Click để sắp xếp danh sách theo trường này"><%=Developer.TrainTicketKeyword.LuotXem %></asp:LinkButton>
        </div>                
        <div class="split">|</div>                    
        <div class="cot5">
            <asp:LinkButton ID="lbtStatus" runat="server" onclick="lbtStatus_Click" CssClass="arrowSort" ToolTip="Click để sắp xếp danh sách theo trường này"><%=Developer.TrainTicketKeyword.TrangThai %></asp:LinkButton>
        </div>                        
        <div class="split">|</div>                    
        <div class="fr pr5"><%=Developer.TrainTicketKeyword.CongCu %></div>                    
        <div class="cb"><!----></div>
    </div>
    
    <div align="center" class="content">
        <asp:Literal ID="LtListItems" runat="server"></asp:Literal>
        <asp:Repeater ID="rp_mn_users" runat="server" onitemcommand="rp_mn_users_ItemCommand">
            <ItemTemplate>
                <div class="Item" id="Item-<%#Eval("IID").ToString()%>">
                    <div class="bgItem">
                        <div class="cot1"><input id="CbItem_<%#Eval("IID").ToString() %>" type="checkbox" /></div>                            
                        <div class="split">|</div>                            
                        <div class="cot2" align="left">
                            <div class="fl">
                                <%#ImagesExtension.GetImage(pic, Eval("VIIMAGE").ToString(), "", "SizeImage", true, true, Eval("VICONTENT").ToString())%>
                            </div>
                            <div>
                                <%#Eval("VITITLE").ToString() %>
                            </div>
                        </div>                            
                        <div class="split">|</div>                            
                        <div class="cot3"><%#TimeExtension.FormatTime(Eval("DCREATEDATE"),"dd/MM/yyyy - HH:mm")%></div>
                        <div class="split">|</div>                            
                        <div class="cot4" align="center">
                            <%#Eval("IITOTALVIEW").ToString()%>
                        </div>
                        <div class="split">|</div>                            
                        <div class="cot5" align="center">
                            <a id="nc<%#Eval("IID").ToString()%>" href="javascript:UpdateEnableItem(<%#Eval("IID").ToString()%>)" class="EnableIcon<%#Eval("IIENABLE").ToString()%>">&nbsp;</a>
                        </div>
                        <div class="split">|</div>                        
                        <div class="fr tool pr5">
                            <a class="<%=TrainTicketConfig.KeyHienThiQuanLyPhanHoiTrainTicket %>" href="javascript:NewWindow_('cms/admin/Moduls/TrainTicket/Item/PopUp/ViewComments.aspx?iid=<%#Eval("IID")%>','ImageList','950','600','yes','yes')"><span class='iconPhanHoi'><!----></span></a>
                            <a class="<%=TrainTicketConfig.KeyHienThiThemNhieuAnhChoTrainTicket %>" title="<%=Developer.TrainTicketKeyword.ClickDeThemHinhAnh %>" href="javascript:NewWindow_('cms/admin/Moduls/TrainTicket/Item/PopUp/AddPictureToItems.aspx?iid=<%#Eval("IID")%>','ImageList','950','600','yes','yes')"><span class='iconThemAnh'><!----></span></a>
                            
                            <a class="<%=TagConfig.KeyHienThiTagChoTrainTicket%>" title="Click để thêm tag" href="javascript:NewWindow_('cms/admin/TempControls/PopUp/Items/AddTags.aspx?iid=<%#Eval("IID")%>&Modul=<%=app %>','ImageList','950','600','yes','yes')"><span class='iconThemTag'><!----></span></a>

                            <a title="<%=Developer.TrainTicketKeyword.ClickDeThemVaoNhom %>" href="javascript:NewWindow_('cms/admin/Moduls/TrainTicket/Item/Popup/AddItemToGroups.aspx?iid=<%#Eval("IID")%>','ImageList','800','450','yes','yes')"><span class='iconThemVaoNhom'><!----></span></a>                                           <a href="<%#LinkUpdate(Eval("IID").ToString())%>"><span class="iconEdit"><!----></span></a>                        
                            <a href="javascript:DeleteItem('<%#Eval("IID").ToString()%>','<%#Eval("VITITLE").ToString()%>')"><span class='iconDelete'><!----></span></a>
                        </div>
                        <div class="cbh0"><!----></div>                        
                    </div>                                        
                </div>          
            </ItemTemplate>
            <SeparatorTemplate><div class="vien"><!----></div></SeparatorTemplate>
        </asp:Repeater>
    </div>
    <div class="cb h25"><!----></div>    
</div>
<div id="FooterRightControl">
    <div class="pdFooterR">
        <div class="ColPagging"><div class="AdminPagging"><asp:Literal ID="LtPagging" runat="server"></asp:Literal></div></div>
        <div class="ColShowItem">            
            <div class="TextShow">Hiển thị</div>
            <div class="BoxShow">
                <asp:DropDownList ID="DdlListShowItem" runat="server" Width="50px" 
                    Height="19px" CssClass="TextInBox" AutoPostBack="True" 
                    onselectedindexchanged="DdlListShowItem_SelectedIndexChanged">
                    <asp:ListItem Value="10">10</asp:ListItem>
                    <asp:ListItem Value="20">20</asp:ListItem>
                    <asp:ListItem Value="30">30</asp:ListItem>
                    <asp:ListItem Value="50">50</asp:ListItem>
                    <asp:ListItem Value="100">100</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="cb"><!----></div>
        </div>        
        <div class="cbh0"><!----></div>
    </div>
</div>
<div id="SubItemTrainTicketSearch">
    <div class="frame">
        <div class="frame2">
            <div class="fl pr10">
                <asp:TextBox ID="tbTitleSearch" runat="server" placeholder="Tên Vé tàu"></asp:TextBox>
            </div>
            <div class="fl pr10">
                <asp:TextBox ID="tbKeySearch" runat="server" placeholder="Mã Vé tàu"></asp:TextBox>
            </div>
            <div class="fl">
                <asp:DropDownList ID="ddlCateSearch" runat="server">
                </asp:DropDownList>
            </div>
            <div class="fr tar">
                <asp:LinkButton ID="ltrSearch" runat="server" CssClass="lbtSearch" 
                    onclick="ltrSearch_Click">&nbsp;</asp:LinkButton>
            </div>
            <div class="cb"><!----></div>
        </div>
    </div>
    <script type="text/javascript">
        $(window).load(function () {
            var height = ($("#TrainTicketModul").outerHeight() + $("#SubItemTrainTicketSearch").outerHeight());
            $(".PositionLeftControl").css("height", height + "px");
            $(".PositionRightControl").css("height", height + "px");
        });
        $(window).scroll(function () {            
            if (($("#SubItemTrainTicketSearch").offset().top + $("#SubItemTrainTicketSearch").outerHeight()) > ($("#AdmFooter").offset().top + 20))
                $("#SubItemTrainTicketSearch").css("bottom", "43px");

            if (($("#SubItemTrainTicketSearch").offset().top + $("#SubItemTrainTicketSearch").outerHeight()) <= ($("#AdmFooter").offset().top-20))
                $("#SubItemTrainTicketSearch").css("bottom", "0");
        });
    </script>
</div>