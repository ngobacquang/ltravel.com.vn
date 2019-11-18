<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Category.ascx.cs" Inherits="cms_display_Hotel_Controls_Category" %>

<div class="section tag-service tagDanhSach">
  <div class="container">
    <div class="list">
      <h2>
        <a href="#" class="title list-title txtCenter fSize-34 nb-color-m1">
          <asp:Literal ID="ltrCateName" runat="server" /></a>
      </h2>
      <p class="list-text hed txtCenter">
        <asp:Literal ID="ltrCateDesc" runat="server" /></p>
      <div class="list-body">
        <asp:Literal ID="ltrList" runat="server" />
      </div>
    </div>
  </div>
</div>
<asp:Literal ID="ltrPaging" runat="server" />
<br>
<div class="blogText">
	<div class="container">
    <asp:Literal ID="ltrText" runat="server" />
		<br><br>
	</div>
</div>