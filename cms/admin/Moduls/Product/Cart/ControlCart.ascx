<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ControlCart.ascx.cs" Inherits="cms_admin_Moduls_Product_Item_ControlCart" %>
<%@ Register TagPrefix="cc1" Namespace="CssJscriptOptimizer.Controls" Assembly="CssJscriptOptimizer" %>
<cc1:StyleSheetCombiner ID="sheetCombiner" runat="server"><link href="~/cms/admin/Moduls/Product/Cart/ControlCart/_cs.css" rel="stylesheet" type="text/css" /></cc1:StyleSheetCombiner>

<asp:HiddenField ID="hd_time" runat="server" />
<div id="ControlCart">
    <div class="BgTabTool">        
        <a href="javascript:DeleteListSubItems()" class="LinkDelete"><%=Developer.ProductKeyword.Xoa%></a>                                   
    </div>

    <div class="BgTabTitle" align="center">
        <div class="cot1 pt5" align="center"><input id="checkAll" type="checkbox" onchange="CheckAllCheckBox('CbItem',this)"/></div>
        <div class="split">|</div>                    
        <div class="cot2" align="left">        
            <%=Developer.ProductKeyword.ThongTinDonHang %>
        </div>
        <div class="split">|</div>                    
        <div class="cot3">
            <%=Developer.ProductKeyword.ThongTinNguoiGui %>
        </div>                        
        <div class="split">|</div>                    
        <div class="cot5">
            <%=Developer.ProductKeyword.TrangThai %>
        </div>                        
        <div class="split">|</div>                    
        <div class="fr pr5"><%=Developer.ProductKeyword.CongCu %></div>                    
        <div class="cb"><!----></div>
    </div>
    
    <div align="center" class="content">
        <asp:Repeater ID="rp_mn_users" runat="server">
            <ItemTemplate>
                <div id="Item-<%#Eval("IID").ToString()%>">
                    <div class="bgItem">
                        <div class="cot1"><input id="CbItem_<%#Eval("IID").ToString() %>" type="checkbox" /></div>                            
                        <div class="split">|</div>                            
                        <div class="cot2 lhContent" align="left">
                            <b>Mã đơn hàng:</b> <%#Eval(TatThanhJsc.Columns.ItemsColumns.VikeyColumn).ToString() %><br/>
                            <b>Phương thức thanh toán:</b> <%#LayHinhThucMua(Eval(TatThanhJsc.Columns.ItemsColumns.VidescColumn).ToString()) %><br/>
                            <b>Phí vận chuyển:</b> <%# TatThanhJsc.Extension.NumberExtension.FormatNumber(Eval(TatThanhJsc.Columns.ItemsColumns.FisalepriceColumn).ToString()) %><br/>
                            <b>Tổng tiền hàng:</b> <span class="maunoibat"><%#TatThanhJsc.Extension.NumberExtension.FormatNumber(Eval(TatThanhJsc.Columns.ItemsColumns.FipriceColumn).ToString())%></span><br/>
                            <b>Trạng thái thanh toán:</b> <%#LayTrangThaiThanhToan(Eval(TatThanhJsc.Columns.ItemsColumns.IitotalsubitemsColumn).ToString()) %><br/>
                            <b>Gửi lúc:</b> <%#((DateTime)Eval(TatThanhJsc.Columns.ItemsColumns.DicreatedateColumn)).ToString("dd/MM/yyyy hh:mm:ss tt") %><br/>
                        </div>
                        <div class="split">|</div>                            
                        <div class="cot3 lhContent" align="left">                            
                            <%#LayThongTinKhachHang(Eval(TatThanhJsc.Columns.ItemsColumns.VicontentColumn).ToString())%>
                        </div>                                                    
                        <div class="split">|</div>                            
                        <div class="cot5" align="center">
                            <a id="nc<%#Eval("IID").ToString()%>" href="javascript:UpdateEnableItem(<%#Eval("IID").ToString()%>)" class="EnableIcon<%#Eval("IIENABLE").ToString()%>">&nbsp;</a>
                        </div>
                        <div class="split">|</div>                            
                        <div class="fr tool pr5">                            
                            <a title="Click để xem chi tiết phản hồi này" href="javascript:void(0)" onclick="NewWindow_('cms/admin/Moduls/Product/Cart/Popup/ViewCartDetail.aspx?iid=<%#Eval("IID")%>','ImageList','950','600','yes','yes')"><span class='iconDonHang'><!----></span></a>
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
    <div id="FooterRightControl">
        <div class="pdFooterR">            
            <div class="ColPagging"><div id="AdminPagging"><asp:Literal ID="LtPagging" runat="server"></asp:Literal></div></div>
            <div class="cbh0"><!----></div>
        </div>
    </div>
</div>
