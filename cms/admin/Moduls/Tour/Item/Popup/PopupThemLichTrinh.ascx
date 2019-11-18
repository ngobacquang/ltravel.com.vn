<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PopupThemLichTrinh.ascx.cs" Inherits="cms_admin_Moduls_Tour_Item_Popup_PopupThemLichTrinh" %>
<%@ Import Namespace="TatThanhJsc.Extension" %>
<div class="fadePopup" id="fadePopupLichTrinh" onclick=" ClosePopupLichTrinh() "></div>
<div class="lightPopup" id="lightPopupLichTrinh">
    <a class="btClose" href="javascript:ClosePopupLichTrinh()">Đóng lại</a>
        
    <asp:Panel ID="pnCoIid" runat="server" CssClass="lightPopupBox">
        <iframe frameborder="0" width="100%" src="<%= UrlExtension.WebisteUrl %>cms/admin/Moduls/Tour/Item/Popup/PopupThemLichTrinh.aspx?iid=<%=iid %>"></iframe>
    </asp:Panel>
    <asp:Panel ID="pnKhongCoIid" runat="server" CssClass="lightPopupBox">
        <div class="emptyresult">Hiện tại lịch trình chỉ có thể thêm sau khi đã tạo tour.<br/>Vui lòng hoàn thành việc tạo tour sau đó chọn cập nhật tour để thêm lịch trình.<br/>Xin cảm ơn!</div>
    </asp:Panel>    
</div>
<script type="text/javascript">
    function ThemLichTrinh() {
        $(".fadePopup#fadePopupLichTrinh").show();        
        $(".lightPopup#lightPopupLichTrinh iframe").attr("src", "<%= UrlExtension.WebisteUrl %>cms/admin/Moduls/Tour/Item/Popup/PopupThemLichTrinh.aspx?iid=<%=iid %>");
        $(".lightPopup#lightPopupLichTrinh").show();
    }

    function ClosePopupLichTrinh() {
        $(".fadePopup").hide();
        $(".lightPopup").hide();

        LayDanhSachLichTrinh(<%=iid %>);
    }

    function EditItinerary(isid) {
        $(".fadePopup#fadePopupLichTrinh").show();
        $(".lightPopup#lightPopupLichTrinh iframe").attr("src", "<%= UrlExtension.WebisteUrl %>cms/admin/Moduls/Tour/Item/Popup/PopupThemLichTrinh.aspx?iid=<%=iid %>&isid=" + isid);
        $(".lightPopup#lightPopupLichTrinh").show();
    }
</script>

<div class="danhSachLichTrinh">
    
</div>
<script type="text/javascript">
    function LayDanhSachLichTrinh(iid) {
        loading(true);
        jQuery.ajax({
            url: weburl + "cms/admin/Moduls/Tour/Item/Popup/PopupThemLichTrinhAjax.aspx",
            type: "POST",
            //dataType: "json",
            data: {
                "action": "LayDanhSachLichTrinh",
                "iid": iid                
            },
            success: function (res) {
                loading(false);

                $(".danhSachLichTrinh").html(res);
            },
            error: function (error) { //Lỗi xảy ra
                loading(false);
            }
        });
    }

    LayDanhSachLichTrinh(<%=iid %>);
</script>

<script type="text/javascript">
    function DeleteItinerary(isid) {
        jConfirm("Sẽ xóa lịch trình này?", "Xác nhận", function(r) {
            if (r) {
                loading(true);
                jQuery.ajax({
                    url: weburl + "cms/admin/Moduls/Tour/Item/Popup/PopupThemLichTrinhAjax.aspx",
                    type: "POST",
                    //dataType: "json",
                    data: {
                        "action": "DeleteItinerary",
                        "isid": isid
                    },
                    success: function (res) {
                        loading(false);

                        $("#row_" + isid).slideUp();
                    },
                    error: function (error) { //Lỗi xảy ra
                        loading(false);
                    }
                });
            }
        });
    }
</script>