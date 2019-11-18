<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SubSearchHomepage.ascx.cs" Inherits="cms_display_Search_subControls_SubSearchHomepage" %>

<div class="action-filter list">
  <div class="title">
    <h1><a href="#" class="title fSize-32 nb-color-m1 opacity-0"><%=LanguageItemExtension.GetnLanguageItemTitleByName("Welcome to LTravel") %></a></h1>
  </div>
  <div class="form_chose">
    <div class="form-group city_chose">
      <asp:DropDownList ID="ddlDiemDen" ClientIDMode="Static" CssClass="control" runat="server"></asp:DropDownList>
    </div>
    <div class="form-group date_chose">
      <asp:DropDownList ID="ddlThoiGian" ClientIDMode="Static" CssClass="control" runat="server"></asp:DropDownList>
    </div>
    <div class="form-group action-fid">
      <a href="javascript:void(0)" onclick="PostSearchOnMenu()" class="link link-submit "><%=LanguageItemExtension.GetnLanguageItemTitleByName("Search") %></a>
    </div>
  </div>
</div>

<script>
  function PostSearchOnMenu() {
    window.location = "/?go=search&diemden=" + $("#ddlDiemDen").find("option:selected").val() + "&thoigian=" + $("#ddlThoiGian").find("option:selected").val();
  }
</script>