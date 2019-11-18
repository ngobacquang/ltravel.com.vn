<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PopupThemCabin.ascx.cs" Inherits="cms_admin_Moduls_Cruises_Item_Popup_PopupThemCabin" %>
<%@ Import Namespace="TatThanhJsc.Extension" %>
<div class="fadePopup" id="fadePopupCabin" onclick=" ClosePopupCabin() "></div>
<div class="lightPopup" id="lightPopupCabin">
    <a class="btClose" href="javascript:ClosePopupCabin()">Đóng lại</a>
        
    <asp:Panel ID="pnCoIid" runat="server" CssClass="lightPopupBox">
        <iframe frameborder="0" width="100%" src="<%= UrlExtension.WebisteUrl %>cms/admin/Moduls/Cruises/Item/Popup/PopupThemCabin.aspx?iid=<%=iid %>"></iframe>
    </asp:Panel>
    <asp:Panel ID="pnKhongCoIid" runat="server" CssClass="lightPopupBox">
        <div class="emptyresult">Hiện tại cabin chỉ có thể thêm sau khi đã tạo cruises.<br/>Vui lòng hoàn thành việc tạo cruises sau đó chọn cập nhật cruises để thêm cabin.<br/>Xin cảm ơn!</div>
    </asp:Panel>    
</div>
<script type="text/javascript">
    function ThemCabin() {
        $(".fadePopup#fadePopupCabin").show();        
        $(".lightPopup#lightPopupCabin iframe").attr("src", "<%= UrlExtension.WebisteUrl %>cms/admin/Moduls/Cruises/Item/Popup/PopupThemCabin.aspx?iid=<%=iid %>");
        $(".lightPopup#lightPopupCabin").show();
    }

    function ClosePopupCabin() {
        $(".fadePopup").hide();
        $(".lightPopup").hide();

        LayDanhSachCabin(<%=iid %>);
    }

    function EditRoomType(isid) {
        $(".fadePopup#fadePopupCabin").show();
        $(".lightPopup#lightPopupCabin iframe").attr("src", "<%= UrlExtension.WebisteUrl %>cms/admin/Moduls/Cruises/Item/Popup/PopupThemCabin.aspx?iid=<%=iid %>&isid=" + isid);
        $(".lightPopup#lightPopupCabin").show();
    }
</script>

<div class="danhSachCabin">
    
</div>
<script type="text/javascript">
    function LayDanhSachCabin(iid) {
        loading(true);
        jQuery.ajax({
            url: weburl + "cms/admin/Moduls/Cruises/Item/Popup/PopupThemCabinAjax.aspx",
            type: "POST",
            //dataType: "json",
            data: {
                "action": "LayDanhSachCabin",
                "iid": iid                
            },
            success: function (res) {
                loading(false);

                $(".danhSachCabin").html(res);
            },
            error: function (error) { //Lỗi xảy ra
                loading(false);
            }
        });
    }

    LayDanhSachCabin(<%=iid %>);
</script>

<script type="text/javascript">
    function DeleteRoomType(isid) {
        jConfirm("Sẽ xóa cabin này?", "Xác nhận", function(r) {
            if (r) {
                loading(true);
                jQuery.ajax({
                    url: weburl + "cms/admin/Moduls/Cruises/Item/Popup/PopupThemCabinAjax.aspx",
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