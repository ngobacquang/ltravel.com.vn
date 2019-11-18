<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ControlBooking02.ascx.cs" Inherits="cms_admin_Moduls_Tour_Booking_ControlBooking02" %>
<%@ Import Namespace="TatThanhJsc.Extension" %>
<%@ Import Namespace="TatThanhJsc.Columns" %>

<asp:HiddenField ID="hd_time" runat="server" />

<div id="ControlItem">
    <div id="ControlComment">
        <div class="BgTabTool">
        <a href="javascript:DeleteListItems()" class="LinkDelete"><%=Developer.TourKeyword.Xoa%></a>                   
        <div class="right">            
            <div class="ColPagging"><div class="AdminPagging"><asp:Literal ID="LtPaggingTop" runat="server"></asp:Literal></div></div>
            <div class="ColShowItem">            
                <div class="TextShow">Hiển thị</div>
                <div class="BoxShow">
                    <asp:DropDownList ID="DdlListShowItemTop" runat="server" Width="50px" Height="19px" CssClass="TextInBox" AutoPostBack="True" 
                    onselectedindexchanged="DdlListShowItemTop_SelectedIndexChanged">
                        <asp:ListItem Value="5">5</asp:ListItem>
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
            Thông tin
        </div>
        <div class="split">|</div>                    
        <div class="cot3">
            <asp:LinkButton ID="lbtDate" runat="server" onclick="lbtDate_Click" CssClass="arrowSort" ToolTip="Click để sắp xếp danh sách theo trường này">Gửi lúc</asp:LinkButton>
        </div>        
        <div class="split">|</div>                    
        <div class="cot5">
            <asp:LinkButton ID="lbtStatus" runat="server" onclick="lbtStatus_Click" CssClass="arrowSort" ToolTip="Click để sắp xếp danh sách theo trường này"><%=Developer.TourKeyword.TrangThai %></asp:LinkButton>
        </div>                        
        <div class="split">|</div>                    
        <div class="fr pr5"><%=Developer.TourKeyword.CongCu %></div>                    
        <div class="cb"><!----></div>
    </div>
    
    <div align="center" class="content">
        <asp:Repeater ID="rp_mn_users" runat="server">
            <ItemTemplate>
                <div class="Item" id="Item-<%#Eval("IID").ToString()%>">
                    <div class="bgItem">
                        <div class="cot1"><input id="CbItem_<%#Eval("IID").ToString() %>" type="checkbox" /></div>                            
                        <div class="split">|</div>                            
                        <div class="cot2" align="left" style="line-height:18px">
                            <%#TrichThongTinDatHang(Eval("VICONTENT").ToString()) %>
                        </div>                            
                        <div class="split">|</div>                            
                        <div class="cot3"><%#TatThanhJsc.Extension.TimeExtension.FormatTime(Eval("DICREATEDATE"),"dd/MM/yyyy - HH:mm")%></div>
                        <div class="split">|</div>                            
                        <div class="cot5" align="center">
                            <a onclick="return confirm('Bạn có chắc chắn muốn đổi trạng thái đơn hàng này (x: chưa xử lý xong; v: đã xử lý xong)?')" id="nc<%#Eval("IID").ToString()%>" href="javascript:UpdateEnableItem(<%#Eval("IID").ToString()%>)" class="EnableIcon<%#Eval("IIENABLE").ToString()%>">&nbsp;</a>
                        </div>
                        <div class="split">|</div>                        
                        <div class="fr tool pr5">
                            <a href="javascript:DeleteItem('<%#Eval("IID").ToString()%>','')"><span class='iconDelete'><!----></span></a>
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
                    <asp:ListItem Value="5">5</asp:ListItem>
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

<div id="SubItemSearch" style="display:none">
    <div class="frame">
        <div class="frame2">
            <div class="fl pr10">
                <asp:TextBox ID="tbTitleSearch" runat="server" placeholder="Gõ tiêu đề cần tìm"></asp:TextBox>
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
            var height = $("#SubItemSearch").outerHeight();
            $(".colLeft").css("margin-bottom", height + "px");
            $(".colRight").css("margin-bottom", height + "px");
        });
        $(window).scroll(function () {
            if (($("#SubItemSearch").offset().top + $("#SubItemSearch").outerHeight()) > ($("#AdmFooter").offset().top + 20))
                $("#SubItemSearch").css("bottom", "43px");

            if (($("#SubItemSearch").offset().top + $("#SubItemSearch").outerHeight()) <= ($("#AdmFooter").offset().top - 20))
                $("#SubItemSearch").css("bottom", "0");
        });
    </script>
</div>