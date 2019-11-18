<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AdmControlsConfig.ascx.cs" Inherits="cms_admin_Homepage_Controls_AdmControlsConfiguration" %>
<%@ Register TagPrefix="cc1" Namespace="CssJscriptOptimizer.Controls" Assembly="CssJscriptOptimizer" %>
<cc1:StyleSheetCombiner ID="sheetCombiner" runat="server">
    <link href="~/cms/admin/Moduls/Homepage/Config/AdmControlsConfig/_cs.css" rel="stylesheet" type="text/css" />
</cc1:StyleSheetCombiner>
<div id="AdmRoad">
    <a class="TextRoad">Bạn đang ở: </a>
    <a title="Trang chủ" class="TextRoad" href="admin.aspx">Trang chủ</a>
    <a title="Cấu hình" class="TextRoad arrow" href="admin.aspx?uc=config">Cấu hình</a>
    <div class="cbh0"><!----></div>        
</div>
<div id="AdmControlsConfig">
    <div class="title">Cấu hình trang chủ trang quản trị</div>
    <div>
        Tích chọn các mục bạn muốn hiển thị tại trang chủ trang quản trị và nhập thứ tự để sắp xếp chúng
    </div> 
    <div class="cbh20"><!----></div>
    <asp:Panel ID="pnCauHinhTrangChu" runat="server" CssClass="pl10">
        <div class="item" style='<%=SetDisplay(HorizaMenuConfig.ShowNew)%>'>            
            <div class="fwb">Tin tức</div>
            <div class="khungThuocTinh">
                <asp:Panel ID="Panel1" runat="server" CssClass="pb5">                    
                    <asp:HiddenField ID="HiddenField1" runat="server" Value="cms/admin/Moduls/Homepage/Index.ascx->cms/admin/Moduls/New/Item/SubControl/SubControlComment.ascx"/>
                    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                    <asp:CheckBox ID="CheckBox1" runat="server" Text="Phản hồi mới"/>                    
                </asp:Panel>
                <asp:Panel ID="Panel2" runat="server" CssClass="pb5">                    
                    <asp:HiddenField ID="HiddenField2" runat="server" Value="cms/admin/Moduls/Homepage/Index.ascx->cms/admin/Moduls/New/Item/SubControl/SubControlItemLastest.ascx"/>
                    <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                    <asp:CheckBox ID="CheckBox2" runat="server" Text="Tin mới cập nhật"/>                    
                </asp:Panel>
                <asp:Panel ID="Panel3" runat="server" CssClass="pb5">                    
                    <asp:HiddenField ID="HiddenField3" runat="server" Value="cms/admin/Moduls/Homepage/Index.ascx->cms/admin/Moduls/New/Item/SubControl/SubControlItemHostest.ascx"/>
                    <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
                    <asp:CheckBox ID="CheckBox3" runat="server" Text="Tin xem nhiều"/>                    
                </asp:Panel>
            </div>
        </div>
        
        <div class="item" style='<%=SetDisplay(HorizaMenuConfig.ShowProduct)%>'>
            <div class="fwb">Sản phẩm</div>
            <div class="khungThuocTinh">
                <asp:Panel ID="Panel4" runat="server" CssClass="pb5">                    
                    <asp:HiddenField ID="HiddenField4" runat="server" Value="cms/admin/Moduls/Homepage/Index.ascx->cms/admin/Moduls/Product/Item/SubControl/SubControlComment.ascx"/>
                    <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox>
                    <asp:CheckBox ID="CheckBox4" runat="server" Text="Phản hồi mới"/>                    
                </asp:Panel>
                <asp:Panel ID="Panel5" runat="server" CssClass="pb5">                    
                    <asp:HiddenField ID="HiddenField5" runat="server" Value="cms/admin/Moduls/Homepage/Index.ascx->cms/admin/Moduls/Product/Item/SubControl/SubControlItemLastest.ascx"/>
                    <asp:TextBox ID="TextBox5" runat="server"></asp:TextBox>
                    <asp:CheckBox ID="CheckBox5" runat="server" Text="Sản phẩm mới cập nhật"/>                    
                </asp:Panel>
                <asp:Panel ID="Panel6" runat="server" CssClass="pb5">                    
                    <asp:HiddenField ID="HiddenField6" runat="server" Value="cms/admin/Moduls/Homepage/Index.ascx->cms/admin/Moduls/Product/Item/SubControl/SubControlItemHostest.ascx"/>
                    <asp:TextBox ID="TextBox6" runat="server"></asp:TextBox>
                    <asp:CheckBox ID="CheckBox6" runat="server" Text="Sản phẩm xem nhiều"/>                    
                </asp:Panel>            
            </div>
        </div>
        
        <div class="item" style='<%=SetDisplay(HorizaMenuConfig.ShowService)%>'>
            <div class="fwb">Dịch vụ</div>
            <div class="khungThuocTinh">
                <asp:Panel ID="Panel7" runat="server" CssClass="pb5">                    
                    <asp:HiddenField ID="HiddenField7" runat="server" Value="cms/admin/Moduls/Homepage/Index.ascx->cms/admin/Moduls/Service/Item/SubControl/SubControlComment.ascx"/>
                    <asp:TextBox ID="TextBox7" runat="server"></asp:TextBox>
                    <asp:CheckBox ID="CheckBox7" runat="server" Text="Phản hồi mới"/>                    
                </asp:Panel>
                <asp:Panel ID="Panel8" runat="server" CssClass="pb5">                    
                    <asp:HiddenField ID="HiddenField8" runat="server" Value="cms/admin/Moduls/Homepage/Index.ascx->cms/admin/Moduls/Service/Item/SubControl/SubControlItemLastest.ascx"/>
                    <asp:TextBox ID="TextBox8" runat="server"></asp:TextBox>
                    <asp:CheckBox ID="CheckBox8" runat="server" Text="Dịch vụ mới cập nhật"/>                    
                </asp:Panel>
                <asp:Panel ID="Panel9" runat="server" CssClass="pb5">                    
                    <asp:HiddenField ID="HiddenField9" runat="server" Value="cms/admin/Moduls/Homepage/Index.ascx->cms/admin/Moduls/Service/Item/SubControl/SubControlItemHostest.ascx"/>
                    <asp:TextBox ID="TextBox9" runat="server"></asp:TextBox>
                    <asp:CheckBox ID="CheckBox9" runat="server" Text="Dịch vụ xem nhiều"/>                    
                </asp:Panel>            
            </div>
        </div>
        
        <div class="item" style='<%=SetDisplay(HorizaMenuConfig.ShowCustomer)%>'>
                <div class="fwb">Khách hàng</div>
                <div class="khungThuocTinh">
                    <asp:Panel ID="Panel10" runat="server" CssClass="pb5">                    
                        <asp:HiddenField ID="HiddenField10" runat="server" Value="cms/admin/Moduls/Homepage/Index.ascx->cms/admin/Moduls/Customer/Item/SubControl/SubControlComment.ascx"/>
                        <asp:TextBox ID="TextBox10" runat="server"></asp:TextBox>
                        <asp:CheckBox ID="CheckBox10" runat="server" Text="Phản hồi mới"/>                    
                    </asp:Panel>
                    <asp:Panel ID="Panel11" runat="server" CssClass="pb5">                    
                        <asp:HiddenField ID="HiddenField11" runat="server" Value="cms/admin/Moduls/Homepage/Index.ascx->cms/admin/Moduls/Customer/Item/SubControl/SubControlItemLastest.ascx"/>
                        <asp:TextBox ID="TextBox11" runat="server"></asp:TextBox>
                        <asp:CheckBox ID="CheckBox11" runat="server" Text="Khách hàng mới cập nhật"/>                    
                    </asp:Panel>
                    <asp:Panel ID="Panel12" runat="server" CssClass="pb5">                    
                        <asp:HiddenField ID="HiddenField12" runat="server" Value="cms/admin/Moduls/Homepage/Index.ascx->cms/admin/Moduls/Customer/Item/SubControl/SubControlItemHostest.ascx"/>
                        <asp:TextBox ID="TextBox12" runat="server"></asp:TextBox>
                        <asp:CheckBox ID="CheckBox12" runat="server" Text="Khách hàng xem nhiều"/>                    
                    </asp:Panel>
                </div>
            </div>        
        
        <div class="item" style='<%=SetDisplay(HorizaMenuConfig.ShowFilelibrary)%>'>
            <div class="fwb">Thư viện dữ liệu</div>
            <div class="khungThuocTinh">
                <asp:Panel ID="Panel13" runat="server" CssClass="pb5">                    
                    <asp:HiddenField ID="HiddenField13" runat="server" Value="cms/admin/Moduls/Homepage/Index.ascx->cms/admin/Moduls/FileLibrary/Item/SubControl/SubControlComment.ascx"/>
                    <asp:TextBox ID="TextBox13" runat="server"></asp:TextBox>
                    <asp:CheckBox ID="CheckBox13" runat="server" Text="Phản hồi mới"/>                    
                </asp:Panel>
                <asp:Panel ID="Panel14" runat="server" CssClass="pb5">                    
                    <asp:HiddenField ID="HiddenField14" runat="server" Value="cms/admin/Moduls/Homepage/Index.ascx->cms/admin/Moduls/FileLibrary/Item/SubControl/SubControlItemLastest.ascx"/>
                    <asp:TextBox ID="TextBox14" runat="server"></asp:TextBox>
                    <asp:CheckBox ID="CheckBox14" runat="server" Text="Dữ liệu mới cập nhật"/>                    
                </asp:Panel>
                <asp:Panel ID="Panel15" runat="server" CssClass="pb5">                    
                    <asp:HiddenField ID="HiddenField15" runat="server" Value="cms/admin/Moduls/Homepage/Index.ascx->cms/admin/Moduls/FileLibrary/Item/SubControl/SubControlItemHostest.ascx"/>
                    <asp:TextBox ID="TextBox15" runat="server"></asp:TextBox>
                    <asp:CheckBox ID="CheckBox15" runat="server" Text="Dữ liệu xem nhiều"/>                    
                </asp:Panel>
            </div>
        </div>
        
        <div class="item" style='<%=SetDisplay(HorizaMenuConfig.ShowPhotoAlbum)%>'>
            <div class="fwb">Hình ảnh</div>
            <div class="khungThuocTinh">
                <asp:Panel ID="Panel16" runat="server" CssClass="pb5">                    
                    <asp:HiddenField ID="HiddenField16" runat="server" Value="cms/admin/Moduls/Homepage/Index.ascx->cms/admin/Moduls/PhotoAlbum/Item/SubControl/SubControlComment.ascx"/>
                    <asp:TextBox ID="TextBox16" runat="server"></asp:TextBox>
                    <asp:CheckBox ID="CheckBox16" runat="server" Text="Phản hồi mới"/>                    
                </asp:Panel>
                <asp:Panel ID="Panel17" runat="server" CssClass="pb5">                    
                    <asp:HiddenField ID="HiddenField17" runat="server" Value="cms/admin/Moduls/Homepage/Index.ascx->cms/admin/Moduls/PhotoAlbum/Item/SubControl/SubControlItemLastest.ascx"/>
                    <asp:TextBox ID="TextBox17" runat="server"></asp:TextBox>
                    <asp:CheckBox ID="CheckBox17" runat="server" Text="Hình ảnh mới cập nhật"/>                    
                </asp:Panel>
                <asp:Panel ID="Panel18" runat="server" CssClass="pb5">                    
                    <asp:HiddenField ID="HiddenField18" runat="server" Value="cms/admin/Moduls/Homepage/Index.ascx->cms/admin/Moduls/PhotoAlbum/Item/SubControl/SubControlItemHostest.ascx"/>
                    <asp:TextBox ID="TextBox18" runat="server"></asp:TextBox>
                    <asp:CheckBox ID="CheckBox18" runat="server" Text="Hình ảnh xem nhiều"/>                    
                </asp:Panel>
            </div>
        </div>
        
        <div class="item" style='<%=SetDisplay(HorizaMenuConfig.ShowVideo)%>'>
            <div class="fwb">Video</div>
            <div class="khungThuocTinh">
                <asp:Panel ID="Panel19" runat="server" CssClass="pb5">                    
                    <asp:HiddenField ID="HiddenField19" runat="server" Value="cms/admin/Moduls/Homepage/Index.ascx->cms/admin/Moduls/Video/Item/SubControl/SubControlComment.ascx"/>
                    <asp:TextBox ID="TextBox19" runat="server"></asp:TextBox>
                    <asp:CheckBox ID="CheckBox19" runat="server" Text="Phản hồi mới"/>                    
                </asp:Panel>
                <asp:Panel ID="Panel20" runat="server" CssClass="pb5">                    
                    <asp:HiddenField ID="HiddenField20" runat="server" Value="cms/admin/Moduls/Homepage/Index.ascx->cms/admin/Moduls/Video/Item/SubControl/SubControlItemLastest.ascx"/>
                    <asp:TextBox ID="TextBox20" runat="server"></asp:TextBox>
                    <asp:CheckBox ID="CheckBox20" runat="server" Text="Video mới cập nhật"/>                    
                </asp:Panel>
                <asp:Panel ID="Panel21" runat="server" CssClass="pb5">                    
                    <asp:HiddenField ID="HiddenField21" runat="server" Value="cms/admin/Moduls/Homepage/Index.ascx->cms/admin/Moduls/Video/Item/SubControl/SubControlItemHostest.ascx"/>
                    <asp:TextBox ID="TextBox21" runat="server"></asp:TextBox>
                    <asp:CheckBox ID="CheckBox21" runat="server" Text="Video xem nhiều"/>                    
                </asp:Panel>
            </div>
        </div>
        
        <div class="item" style='<%=SetDisplay(HorizaMenuConfig.ShowTour)%>'>
            <div class="fwb">Tour du lịch</div>
            <div class="khungThuocTinh">
                <asp:Panel ID="Panel22" runat="server" CssClass="pb5">                    
                    <asp:HiddenField ID="HiddenField22" runat="server" Value="cms/admin/Moduls/Homepage/Index.ascx->cms/admin/Moduls/Tour/Item/SubControl/SubControlComment.ascx"/>
                    <asp:TextBox ID="TextBox22" runat="server"></asp:TextBox>
                    <asp:CheckBox ID="CheckBox22" runat="server" Text="Phản hồi mới"/>                    
                </asp:Panel>
                <asp:Panel ID="Panel23" runat="server" CssClass="pb5">                    
                    <asp:HiddenField ID="HiddenField23" runat="server" Value="cms/admin/Moduls/Homepage/Index.ascx->cms/admin/Moduls/Tour/Item/SubControl/SubControlItemLastest.ascx"/>
                    <asp:TextBox ID="TextBox23" runat="server"></asp:TextBox>
                    <asp:CheckBox ID="CheckBox23" runat="server" Text="Tour mới cập nhật"/>                    
                </asp:Panel>
                <asp:Panel ID="Panel24" runat="server" CssClass="pb5">                    
                    <asp:HiddenField ID="HiddenField24" runat="server" Value="cms/admin/Moduls/Homepage/Index.ascx->cms/admin/Moduls/Tour/Item/SubControl/SubControlItemHostest.ascx"/>
                    <asp:TextBox ID="TextBox24" runat="server"></asp:TextBox>
                    <asp:CheckBox ID="CheckBox24" runat="server" Text="Tour xem nhiều"/>                    
                </asp:Panel>
            </div>
        </div>
        
        <div class="item" style='<%=SetDisplay(HorizaMenuConfig.ShowHotel)%>'>
            <div class="fwb">Khách sạn</div>
            <div class="khungThuocTinh">
                <asp:Panel ID="Panel25" runat="server" CssClass="pb5">                    
                    <asp:HiddenField ID="HiddenField25" runat="server" Value="cms/admin/Moduls/Homepage/Index.ascx->cms/admin/Moduls/Hotel/Item/SubControl/SubControlComment.ascx"/>
                    <asp:TextBox ID="TextBox25" runat="server"></asp:TextBox>
                    <asp:CheckBox ID="CheckBox25" runat="server" Text="Phản hồi mới"/>                    
                </asp:Panel>
                <asp:Panel ID="Panel26" runat="server" CssClass="pb5">                    
                    <asp:HiddenField ID="HiddenField26" runat="server" Value="cms/admin/Moduls/Homepage/Index.ascx->cms/admin/Moduls/Hotel/Item/SubControl/SubControlItemLastest.ascx"/>
                    <asp:TextBox ID="TextBox26" runat="server"></asp:TextBox>
                    <asp:CheckBox ID="CheckBox26" runat="server" Text="Khách sạn mới cập nhật"/>                    
                </asp:Panel>
                <asp:Panel ID="Panel27" runat="server" CssClass="pb5">                    
                    <asp:HiddenField ID="HiddenField27" runat="server" Value="cms/admin/Moduls/Homepage/Index.ascx->cms/admin/Moduls/Hotel/Item/SubControl/SubControlItemHostest.ascx"/>
                    <asp:TextBox ID="TextBox27" runat="server"></asp:TextBox>
                    <asp:CheckBox ID="CheckBox27" runat="server" Text="Khách sạn xem nhiều"/>                    
                </asp:Panel>
            </div>
        </div>
        
        <div class="item" style='<%=SetDisplay(HorizaMenuConfig.ShowQA)%>'>
            <div class="fwb">Hỏi đáp</div>
            <div class="khungThuocTinh">
                <asp:Panel ID="Panel28" runat="server" CssClass="pb5">                    
                    <asp:HiddenField ID="HiddenField28" runat="server" Value="cms/admin/Moduls/Homepage/Index.ascx->cms/admin/Moduls/QA/Item/SubControl/SubControlComment.ascx"/>
                    <asp:TextBox ID="TextBox28" runat="server"></asp:TextBox>
                    <asp:CheckBox ID="CheckBox28" runat="server" Text="Phản hồi mới"/>                    
                </asp:Panel>
                <asp:Panel ID="Panel29" runat="server" CssClass="pb5">                    
                    <asp:HiddenField ID="HiddenField29" runat="server" Value="cms/admin/Moduls/Homepage/Index.ascx->cms/admin/Moduls/QA/Item/SubControl/SubControlItemLastest.ascx"/>
                    <asp:TextBox ID="TextBox29" runat="server"></asp:TextBox>
                    <asp:CheckBox ID="CheckBox29" runat="server" Text="Hỏi đáp mới cập nhật"/>                    
                </asp:Panel>
                <asp:Panel ID="Panel30" runat="server" CssClass="pb5">                    
                    <asp:HiddenField ID="HiddenField30" runat="server" Value="cms/admin/Moduls/Homepage/Index.ascx->cms/admin/Moduls/QA/Item/SubControl/SubControlItemHostest.ascx"/>
                    <asp:TextBox ID="TextBox30" runat="server"></asp:TextBox>
                    <asp:CheckBox ID="CheckBox30" runat="server" Text="Hỏi đáp xem nhiều"/>                    
                </asp:Panel>
            </div>
        </div>
        
        <div class="cb"><!----></div>
    </asp:Panel>

    <div class="cb h20"><!----></div>
    <div>
        <asp:Button ID="btSave" runat="server" onclick="btSave_Click" Width="120px" Text="Đồng ý" OnClientClick="return CheckInput()"/>
    </div>
    <div class="cb h10"><!----></div>
</div>