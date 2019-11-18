<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewDetail.aspx.cs" Inherits="cms_admin_Contact_SubControls_ViewDetail" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <title>
    <asp:Literal ID="ltrTitle" runat="server"></asp:Literal>
  </title>
  <link href="ViewDetail/cs.css" rel="stylesheet" type="text/css" />
</head>
<body>
  <form id="form1" runat="server">
    <div>
      <div class="title">Chi tiết đơn đặt dịch vụ</div>
      <div><b>Tiêu đề:</b>
        Đơn đăng ký dịch vụ <b><asp:Literal ID="ltrTieuDe" runat="server"></asp:Literal></b></div>
      <div><b>Họ tên:</b>
        <asp:Literal ID="ltrHoten" runat="server"></asp:Literal></div>
      <div><b>Điện thoại:</b>
        <asp:Literal ID="ltrDienthoai" runat="server"></asp:Literal></div>
      <div><b>Email:</b>
        <asp:Literal ID="ltrEmail" runat="server"></asp:Literal></div>
      <div><b>Quốc tịch:</b>
        <asp:Literal ID="ltrNationality" runat="server"></asp:Literal></div>
      <div><b>Gửi lúc:</b>
        <asp:Literal ID="ltrGuiLuc" runat="server"></asp:Literal></div>
      <div><b>Nội dung:</b>
        <br />
        <asp:Literal ID="ltrNoiDung" runat="server"></asp:Literal></div>
    </div>
  </form>
</body>
</html>
