<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PopupThemLoaiPhong.ascx.cs" Inherits="cms_admin_Moduls_Hotel_Item_Popup_PopupThemLoaiPhong" %>
<%@ Import Namespace="TatThanhJsc.Extension" %>
<div class="fadePopup" id="fadePopupLoaiPhong" onclick=" ClosePopupLoaiPhong() "></div>
<div class="lightPopup" id="lightPopupLoaiPhong">
    <a class="btClose" href="javascript:ClosePopupLoaiPhong()">Đóng lại</a>
        
    <asp:Panel ID="pnCoIid" runat="server" CssClass="lightPopupBox">
        <iframe frameborder="0" width="100%" src="<%= UrlExtension.WebisteUrl %>cms/admin/Moduls/Hotel/Item/Popup/PopupThemLoaiPhong.aspx?iid=<%=iid %>"></iframe>
    </asp:Panel>
    <asp:Panel ID="pnKhongCoIid" runat="server" CssClass="lightPopupBox">
        <div class="emptyresult">Hiện tại loại phòng chỉ có thể thêm sau khi đã tạo khách sạn.<br/>Vui lòng hoàn thành việc tạo khách sạn sau đó chọn cập nhật khách sạn để thêm loại phòng.<br/>Xin cảm ơn!</div>
    </asp:Panel>    
</div>
<script type="text/javascript">
    function ThemLoaiPhong() {
        $(".fadePopup#fadePopupLoaiPhong").show();        
        $(".lightPopup#lightPopupLoaiPhong iframe").attr("src", "<%= UrlExtension.WebisteUrl %>cms/admin/Moduls/Hotel/Item/Popup/PopupThemLoaiPhong.aspx?iid=<%=iid %>");
        $(".lightPopup#lightPopupLoaiPhong").show();
    }

    function ClosePopupLoaiPhong() {
        $(".fadePopup").hide();
        $(".lightPopup").hide();

        LayDanhSachLoaiPhong(<%=iid %>);
    }

    function EditRoomType(isid) {
        $(".fadePopup#fadePopupLoaiPhong").show();
        $(".lightPopup#lightPopupLoaiPhong iframe").attr("src", "<%= UrlExtension.WebisteUrl %>cms/admin/Moduls/Hotel/Item/Popup/PopupThemLoaiPhong.aspx?iid=<%=iid %>&isid=" + isid);
        $(".lightPopup#lightPopupLoaiPhong").show();
    }
</script>

<div class="danhSachLoaiPhong">
    
</div>
<script type="text/javascript">
    function LayDanhSachLoaiPhong(iid) {
        loading(true);
        jQuery.ajax({
            url: weburl + "cms/admin/Moduls/Hotel/Item/Popup/PopupThemLoaiPhongAjax.aspx",
            type: "POST",
            //dataType: "json",
            data: {
                "action": "LayDanhSachLoaiPhong",
                "iid": iid                
            },
            success: function (res) {
                loading(false);

                $(".danhSachLoaiPhong").html(res);
            },
            error: function (error) { //Lỗi xảy ra
                loading(false);
            }
        });
    }

    LayDanhSachLoaiPhong(<%=iid %>);
</script>

<script type="text/javascript">
    function DeleteRoomType(isid) {
        jConfirm("Sẽ xóa loại phòng này?", "Xác nhận", function(r) {
            if (r) {
                loading(true);
                jQuery.ajax({
                    url: weburl + "cms/admin/Moduls/Hotel/Item/Popup/PopupThemLoaiPhongAjax.aspx",
                    type: "POST",
                    //dataType: "json",
                    data: {
                        "action": "DeleteRoomType",
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