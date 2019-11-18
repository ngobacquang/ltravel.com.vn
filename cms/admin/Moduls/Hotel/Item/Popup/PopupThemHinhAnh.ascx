<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PopupThemHinhAnh.ascx.cs" Inherits="cms_admin_Moduls_Hotel_Item_Popup_PopupThemHinhAnh" %>
<%@ Import Namespace="TatThanhJsc.Extension" %>
<div class="fadePopup" id="fadePopupHinhAnh" onclick=" ClosePopupHinhAnh() "></div>
<div class="lightPopup" id="lightPopupHinhAnh">
    <a class="btClose" href="javascript:ClosePopupHinhAnh()">Đóng lại</a>
        
    <asp:Panel ID="pnCoIid" runat="server" CssClass="lightPopupBox">
        <iframe frameborder="0" width="100%" src="<%= UrlExtension.WebisteUrl %>cms/admin/Moduls/Hotel/Item/Popup/PopupThemHinhAnh.aspx?iid=<%=iid %>"></iframe>
    </asp:Panel>
    <asp:Panel ID="pnKhongCoIid" runat="server" CssClass="lightPopupBox">
        <div class="emptyresult">Hiện tại hình ảnh chỉ có thể thêm sau khi đã tạo khách sạn.<br/>Vui lòng hoàn thành việc tạo khách sạn sau đó chọn cập nhật khách sạn để thêm hình ảnh.<br/>Xin cảm ơn!</div>
    </asp:Panel>    
</div>
<script type="text/javascript">
    function ThemHinhAnh() {
        $(".fadePopup#fadePopupHinhAnh").show();
        $(".lightPopup#lightPopupHinhAnh iframe").attr("src", "<%= UrlExtension.WebisteUrl %>cms/admin/Moduls/Hotel/Item/Popup/PopupThemHinhAnh.aspx?iid=<%=iid %>");
        $(".lightPopup#lightPopupHinhAnh").show();
    }

    function ClosePopupHinhAnh() {
        $(".fadePopup").hide();
        $(".lightPopup").hide();

        LayDanhSachHinhAnh(<%=iid %>);
    }

    function EditPhoto(isid) {
        $(".fadePopup#fadePopupHinhAnh").show();
        $(".lightPopup#lightPopupHinhAnh iframe").attr("src", "<%= UrlExtension.WebisteUrl %>cms/admin/Moduls/Hotel/Item/Popup/PopupThemHinhAnh.aspx?iid=<%=iid %>&isid=" + isid);
        $(".lightPopup#lightPopupHinhAnh").show();
    }
</script>

<div class="danhSachHinhAnh">
    
</div>
<script type="text/javascript">
    function LayDanhSachHinhAnh(iid) {
        loading(true);
        jQuery.ajax({
            url: weburl + "cms/admin/Moduls/Hotel/Item/Popup/PopupThemHinhAnhAjax.aspx",
            type: "POST",
            //dataType: "json",
            data: {
                "action": "LayDanhSachHinhAnh",
                "iid": iid                
            },
            success: function (res) {
                loading(false);

                $(".danhSachHinhAnh").html(res);
            },
            error: function (error) { //Lỗi xảy ra
                loading(false);
            }
        });
    }

    LayDanhSachHinhAnh(<%=iid %>);
</script>

<script type="text/javascript">
    function DeletePhoto(isid) {
        jConfirm("Sẽ xóa hình ảnh này?", "Xác nhận", function(r) {
            if (r) {
                loading(true);
                jQuery.ajax({
                    url: weburl + "cms/admin/Moduls/Hotel/Item/Popup/PopupThemHinhAnhAjax.aspx",
                    type: "POST",
                    //dataType: "json",
                    data: {
                        "action": "DeletePhoto",
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