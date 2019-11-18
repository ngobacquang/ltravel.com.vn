<%@ Control Language="C#" AutoEventWireup="true" CodeFile="InformationWebsite.ascx.cs" Inherits="cms_admin_System_website_InformationWebsite_AdmInformationWebsite" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<asp:HiddenField ID="hd_img" runat="server" />
<asp:HiddenField ID="HdImageMap" runat="server" />
<asp:HiddenField ID="hd_imgFacebook" runat="server" />
<asp:HiddenField ID="hdOldValue" runat="server" />
<asp:HiddenField ID="hdOldValueTop" runat="server" />
<div id="AdmInformationWebsite">
    <div class="pdControl">    
        
    <div style="display:none">
        <div class="FormatColText"><div>Tiền tệ dùng trên website:</div></div>
        <div class="fl w8">&nbsp;</div>
        <div>
            <%--Tham khảo danh sách từ http://www.vietcombank.com.vn/ExchangeRates/ExrateXML.aspx--%>
            <asp:DropDownList ID="ddlCurrency" runat="server">
                <asp:ListItem Value="VND" Text="VND - VIETNAM DONG"></asp:ListItem>
                <asp:ListItem Value="AUD" Text="AUD - AUST.DOLLAR"></asp:ListItem>
                <asp:ListItem Value="CAD" Text="CAD - CANADIAN DOLLAR"></asp:ListItem>
                <asp:ListItem Value="CHF" Text="CHF - SWISS FRANCE"></asp:ListItem>
                <asp:ListItem Value="DKK" Text="DKK - DANISH KRONE"></asp:ListItem>
                <asp:ListItem Value="EUR" Text="EUR - EURO"></asp:ListItem>
                <asp:ListItem Value="GBP" Text="GBP - BRITISH POUND"></asp:ListItem>
                <asp:ListItem Value="HKD" Text="HKD - HONGKONG DOLLAR"></asp:ListItem>
                <asp:ListItem Value="INR" Text="INR - INDIAN RUPEE"></asp:ListItem>
                <asp:ListItem Value="JPY" Text="JPY - JAPANESE YEN"></asp:ListItem>
                <asp:ListItem Value="KRW" Text="KRW - SOUTH KOREAN WON"></asp:ListItem>
                <asp:ListItem Value="KWD" Text="KWD - KUWAITI DINAR"></asp:ListItem>
                <asp:ListItem Value="MYR" Text="MYR - MALAYSIAN RINGGIT"></asp:ListItem>
                <asp:ListItem Value="NOK" Text="NOK - NORWEGIAN KRONER"></asp:ListItem>
                <asp:ListItem Value="RUB" Text="RUB - RUSSIAN RUBLE"></asp:ListItem>
                <asp:ListItem Value="SAR" Text="SAR - SAUDI RIAL"></asp:ListItem>
                <asp:ListItem Value="SEK" Text="SEK - SWEDISH KRONA"></asp:ListItem>
                <asp:ListItem Value="SGD" Text="SGD - SINGAPORE DOLLAR"></asp:ListItem>
                <asp:ListItem Value="THB" Text="THB - THAI BAHT"></asp:ListItem>
                <asp:ListItem Value="USD" Text="USD - US DOLLAR"></asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="cbh8"><!----></div>
    </div>

      <div class="dn">
        <div class="FormatColText"><div>Điện thoại liên hệ:</div></div>
    <div class="fl w8">&nbsp;</div>
    <div><asp:TextBox ID="TextPhoneContact" runat="server" Width="200px"></asp:TextBox></div>
    <div class="cbh8"><!----></div>
      </div>

    <div class="FormatColText"><div>Hotline:</div></div>
    <div class="fl w8">&nbsp;</div>
    <div><asp:TextBox ID="TextHotLine" runat="server" Width="200px"></asp:TextBox></div>
    <div class="cbh8"><!----></div>
            
      <div class="dn">
        <div class="FormatColText"><div>Email liên hệ:</div></div>
    <div class="fl w8">&nbsp;</div>
    <div><asp:TextBox ID="tbEmail" runat="server" Width="200px"></asp:TextBox></div>
    <div class="cbh8"><!----></div>
      </div>
        
      <div class="dn">
        <asp:Panel ID="pnSocialLink" runat="server">
    <div class="FormatColText"><div>Link fanpage Facebook:</div></div>
    <div class="fl w8">&nbsp;</div>
    <div><asp:TextBox ID="tbKeyLinkFanPageFaceBook" runat="server" Width="500px"></asp:TextBox></div>
    <div class="cbh8"><!----></div>
      </div>
        
    

    <div class="dn">        
        <div class="FormatColText"><div>Địa chỉ:</div></div>
        <div class="fl w8">&nbsp;</div>
        <div><asp:TextBox ID="tbKeyLinkFanPageGPlus" runat="server" Width="500px"></asp:TextBox></div>
        <div class="cbh8"><!----></div>
        <div class="FormatColText"><div>Link fanpage Twitter:</div></div>
        <div class="fl w8">&nbsp;</div>
        <div><asp:TextBox ID="tbKeyLinkFanPageTwitter" runat="server" Width="500px"></asp:TextBox></div>
        <div class="cbh8"><!----></div>
    </div>
    </asp:Panel>

    <asp:Panel ID="pnYouTubeCode" runat="server">
    <div class="FormatColText"><div>Mã video từ Youtube:</div></div>
    <div class="fl w8">&nbsp;</div>
    <div><asp:TextBox ID="tbYoutubeVideo" runat="server" Width="500px"></asp:TextBox></div>
    <div class="cbh8"><!----></div>
    </asp:Panel>
    
    <div class="FormatColText"><div>Logo trang chủ khi chia sẻ qua facebook (>=200x200px):</div></div>
    <div class="fl w8">&nbsp;</div>
    <div class="fl">
        <div><asp:Literal ID="ltrimgFacebook" runat="server"></asp:Literal></div>
        <div><asp:LinkButton ID="lnk_delete_Image_currentFacebook" runat="server" Visible="false" >Xóa hình ảnh hiện tại</asp:LinkButton></div>
        <div><asp:FileUpload ID="flimgFacebook" runat="server" Width="320px" /></div>
    </div>
    <div class="cbh8"><!----></div>

    <div class="FormatColText"><div>Logo khu vực quản trị website:</div></div>
    <div class="fl w8">&nbsp;</div>
    <div class="fl">
        <div><asp:Literal ID="ltimg" runat="server"></asp:Literal></div>
        <div><asp:LinkButton ID="lnk_delete_Image_current" runat="server" Visible="false" >Xóa hình ảnh hiện tại</asp:LinkButton></div>
        <div><asp:FileUpload ID="flimg" runat="server" Width="320px" /></div>
    </div>
    <div class="cbh8"><!----></div>    
    <div class="FormatColText"><div>Icon trên thanh địa chỉ trình duyệt(favicon.ico, 48x48px):</div></div>
    <div class="fl w8">&nbsp;</div>
    <div class="fl">
        <div><asp:Literal ID="ltMap" runat="server"></asp:Literal></div>
        <div><asp:LinkButton ID="LnkDeleteImageMap" runat="server" Visible="false" >Xóa hình ảnh hiện tại</asp:LinkButton></div>
        <div><asp:FileUpload ID="FlMap" runat="server" Width="320px" /></div>
    </div>

    <div class="cbh20"><!----></div>
    <div class="FormatColText"><div>Mã nhúng Tripadvisor cuối trang:</div></div>
    <div class="cbh8"><!----></div>
    <div><asp:TextBox ID="tbTripadvisor" runat="server" Width="730" Height="100" TextMode="multiline"></asp:TextBox></div>
    <div class="cbh8"><!----></div>
    
    <div class="FormatColText" style="width: 300px"><div>Nội dung copyright cuối trang:</div></div>
    <div class="cbh15"><!----></div>
    <div class='fl'>
        <CKEditor:CKEditorControl ID="txt_content_footer_top" Width="730" runat="server" FilebrowserImageBrowseUrl="ckeditor/ckfinder/ckfinder.aspx?type=Images&path=pic/SystemWebsite"></CKEditor:CKEditorControl>
    </div>
    <div class="cbh8"><!----></div>

        <div style="display:none">
            <div class="cbh8"><!----></div>
            <div class="FormatColText"><div>Nội dung dưới chân website - dòng dưới:</div></div>
            <div class="cbh8"><!----></div>
            <div class='fl'>
                <CKEditor:CKEditorControl ID="txt_content_footer" runat="server" FilebrowserImageBrowseUrl="ckeditor/ckfinder/ckfinder.aspx?type=Images&path=pic/SystemWebsite"></CKEditor:CKEditorControl>
            </div>
            <div class="cbh8"><!----></div>
        </div>
   <div>
       <asp:LinkButton ID="btn_save" runat="server" onclick="btn_save_Click"><img src="cms/admin/cs/Icon/btnUpdate.png" border="0" /></asp:LinkButton>
   </div>
</div>
</div>