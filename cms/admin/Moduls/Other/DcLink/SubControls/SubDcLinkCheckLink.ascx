<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SubDcLinkCheckLink.ascx.cs" Inherits="cms_admin_Moduls_Other_DcLink_SubControls_SubDcLinkCheckLink" %>
<script type="text/javascript">
    jQuery(".tbTitle").change(function () {
        var title = jQuery(this).val();
        jQuery(".tbTitle_seo").val(title);
        jQuery(".tbLink_seo").val(title);
        jQuery(".tbKeyword_seo").val(title);

        CheckDuplicateLink();
    });

    jQuery(".tbDesc").change(function () {     
        jQuery(".tbDesc_Seo").val(jQuery(this).val());
    });

    jQuery(".tbLink_seo").change(function () {
        CheckDuplicateLink();
    });

    jQuery(".tbTitle").blur(function () {
        CheckDuplicateLink();
    });
    jQuery(".tbLink_seo").blur(function () {
        CheckDuplicateLink();
    });

    function CheckDuplicateLink() {
        var link = jQuery(".tbLink_seo").val();

        //loading(true);
        jQuery.ajax({
            url: weburl + "cms/admin/Moduls/Other/DcLink/SubControls/SubDcLinkCheckLinkAspx.aspx?link=" + link,
            type: "POST",       
            success: function (res) {
                //loading(false);

                if (res != "0")
                    jAlert("Lưu ý: link bài viết bị trùng với " + res + " link đã có. <a style='font-size:13px;color:#ff0000;font-weight:bold' href='admin.aspx?uc=other&uco=dclink&link=" + link + "' target='_blank'>Click vào đây để xem các link trùng</a>.", "Thông báo");
            },
            error: function (error) { //Lỗi xảy ra
                //loading(false);                
            }
        });
    }
</script>