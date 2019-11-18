<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PopupAddFilterPropertiesToCategory.aspx.cs" Inherits="cms_admin_ModulMain_Product_PopUp_Category_PopupAddFilterPropertiesToCategory" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Thêm thuộc tính lọc vào danh mục</title>
    <link href="PopupAddFilterPropertiesToCategory/_cs.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="PopupAddFilterPropertiesToCategory" runat="server">
    <div class='KhungPopup'>
        <div class="tenDanhMuc">Thông tin thuộc tính lọc của danh mục: <span class="fwb"><asp:Literal ID="ltrCategoryName" runat="server"></asp:Literal></span></div> 
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:Literal ID="ltrListTemp" runat="server"></asp:Literal>
                <div class='KhungBen'>
                    <div class="DaGan">Các thuộc tính lọc đã gán vào danh mục</div>
                    <div class='pt5'><asp:ListBox ID="lstbAdded" runat="server" Width="355px" Height="320px" SelectionMode="Multiple"></asp:ListBox></div>
                </div>
                <div class='KhungGiua'>
                    <asp:Button ID="btAdd" runat="server" CssClass="tac" Width="50px" Text="<<" 
                        onclick="btAdd_Click" />                      
                    <asp:Button ID="btRemove" runat="server" CssClass="tac" Width="50px" Text=">>" 
                        onclick="btRemove_Click" />                    
                </div>
                <div class='KhungBen'>
                    <div class="ChuaGan">Các thuộc tính lọc chưa gán vào danh mục</div>
                    <div class="pt5"><asp:ListBox ID="lstbNotAdded" runat="server" Width="365px" Height="320px" SelectionMode="Multiple"></asp:ListBox></div>
                    <div class="pt5">Chú ý: chỉ chọn tên thuộc tính cha hợp lệ( đánh dấu bởi dấu + ).</div>
                </div>
                <div class='cb pt5'>
                    <asp:CheckBox ID="cbApplyToSubCategory" runat="server" Checked="true" Text="Áp dụng cho tất cả các danh mục con của danh mục này." ToolTip="Tích chọn để áp dụng các thuộc tính lọc cho tất cả danh mục con của danh mục này"/>                    
                </div>
                <div class='cb chuY pt5'>Chú ý: có thể chọn nhiều mục cùng lúc bằng cách giữ phím <span class='c000 fwb'> Shift</span> hoặc <span class='c000 fwb'>Ctrl</span> khi chọn!</div>            
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    </form>
</body>
</html>
