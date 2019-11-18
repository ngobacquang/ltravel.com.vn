<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LanguageItemsImage.aspx.cs" Inherits="cms_admin_Moduls_Language_Popup_LanguageItemsImage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        Ảnh của từ khoá
    </div>
    <asp:HiddenField ID="hdOldImage" runat="server" />
    <asp:HiddenField ID="hdUpdate" runat="server" />
    <div>
    <script type="text/javascript">
        function ChangeImage(id, src) {
            window.opener.document.getElementById(id).src = src;
        }
    </script>
        <asp:Literal ID="ltrImage" runat="server"></asp:Literal>
    </div>
    <div>
        <asp:FileUpload ID="flimg" runat="server" />
    </div>
    <div>
        <asp:Button ID="btOK" runat="server" Text="Cập nhật" onclick="btOK_Click" />
    </div>
    </form>
</body>
</html>
