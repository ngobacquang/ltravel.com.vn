<%@ Control Language="C#" AutoEventWireup="true" CodeFile="BaiVietChoPheDuyet.ascx.cs" Inherits="cms_admin_Moduls_DuyetTin_Item_BaiVietChoPheDuyet" %>

<%@ Register TagPrefix="cc1" Namespace="CssJscriptOptimizer.Controls" Assembly="CssJscriptOptimizer" %>
<%@ Import namespace="TatThanhJsc.Extension" %>
<cc1:StyleSheetCombiner ID="sheetCombiner" runat="server">
  <link href="~/cms/admin/Moduls/New/Item/ControlItem/_cs.css" rel="stylesheet" type="text/css" />
</cc1:StyleSheetCombiner>
<asp:HiddenField ID="hd_time" runat="server" />

<div id="admitem">
  <div class="BgTabTool">
    <div class="right">
      <div class="ColPagging">
        <div class="AdminPagging">
          <asp:Literal ID="LtPaggingTop" runat="server"></asp:Literal></div>
      </div>
      <div class="ColShowItem flex-center">
        <div class="TextShow">Hiển thị</div>
        <div class="BoxShow">
          <asp:DropDownList ID="DdlListShowItemTop" runat="server" Width="50px" Height="19px" CssClass="TextInBox" AutoPostBack="True"
            OnSelectedIndexChanged="DdlListShowItemTop_SelectedIndexChanged">
            <asp:ListItem Value="10">10</asp:ListItem>
            <asp:ListItem Value="20">20</asp:ListItem>
            <asp:ListItem Value="30">30</asp:ListItem>
            <asp:ListItem Value="50">50</asp:ListItem>
            <asp:ListItem Value="100">100</asp:ListItem>
          </asp:DropDownList>
        </div>
        <div class="cb">
          <!---->
        </div>
      </div>
    </div>
  </div>

  <div class="BgTabTitle box-post" align="center">
    <div class="cot1 pt5" align="center">
      <input id="checkAll" type="checkbox" onchange="CheckAllCheckBox('CbItem',this)" /></div>
    <div class="split">|</div>
    <div class="cot2" align="left">
      <asp:LinkButton ID="lbtName" runat="server" OnClick="lbtName_Click" CssClass="arrowSort" ToolTip="Click để sắp xếp danh sách theo trường này">Tiêu đề</asp:LinkButton>
    </div>
    <div class="split">|</div>
    <div class="cot3">
      <asp:LinkButton ID="lbtDate" runat="server" OnClick="lbtDate_Click" CssClass="arrowSort" ToolTip="Click để sắp xếp danh sách theo trường này">Ngày tạo</asp:LinkButton>
    </div>
    <div class="split">|</div>
    <div class="cot3"><%=Developer.DuyetTinKeyword.NguoiDang %></div>
    <div class="split">|</div>
    <div class="cot5">
      <%=Developer.DuyetTinKeyword.PheDuyet %>
    </div>
    <div class="split">|</div>
    <div class="fr pr5 cot7" align="right">Công cụ</div>
    <div class="cb">
      <!---->
    </div>
  </div>

  <div align="center" class="content">
    <asp:Repeater ID="rp_mn_users" runat="server" OnItemCommand="rp_mn_users_ItemCommand">
      <ItemTemplate>
        <div class="Item" id="Item-<%#Eval("IID").ToString()%>">
          <div class="bgItem box-post">
            <div class="cot1 box-cb">
              <input id="CbItem_<%#Eval("IID").ToString() %>" type="checkbox" /></div>
            <div class="split">|</div>
            <div class="cot2" align="left">
              <div class="fl">
                <%#TatThanhJsc.Extension.ImagesExtension.GetImage(GetPicByApp(Eval("VIAPP").ToString()), Eval("VIIMAGE").ToString(), "", "SizeImage", true, true, Eval("VICONTENT").ToString())%>
              </div>
              <div>
                <%#Eval("VITITLE").ToString() %>
              </div>
            </div>
            <div class="split">|</div>
            <div class="cot3"><%#TatThanhJsc.Extension.TimeExtension.FormatTime(Eval("DCREATEDATE"),"dd/MM/yyyy - HH:mm")%></div>
            <div class="split">|</div>
            <div class="cot3"><%#LayInfoNguoiDang(Eval("VIURL").ToString()) %></div>
            <div class="split">|</div>
            <div class="cot5" align="center">
              <a id="nc<%#Eval("IID").ToString()%>" title="<%#Eval("VIAPP").ToString() == "ADV" ? Developer.DuyetTinKeyword.PheDuyetQuangCao : Developer.DuyetTinKeyword.PheDuyetBaiViet %>" href="javascript:UpdateEnableItem<%#Eval("VIAPP").ToString() == "ADV" ? "Adv" : "New" %>('PheDuyet<%#Eval("VIAPP").ToString() == "ADV" ? "QuangCao" : "BaiViet" %>', <%#Eval("IID").ToString()%>, '<%=status %>', '<%=userId %>', '<%#Eval("VIAPP") %>')" class="EnableIcon1">&nbsp;</a>
              &nbsp; 
              <a title="<%#Eval("VIAPP").ToString() == "ADV" ? Developer.DuyetTinKeyword.HuyQuangCao : Developer.DuyetTinKeyword.HuyBaiViet %>" href="javascript:CancelItem<%#Eval("VIAPP").ToString() == "ADV" ? "Adv" : "" %>(<%#Eval("IID")%>, '<%#Eval("VIURL") %>', '<%#Eval("VIAPP") %>')" class="EnableIcon0">&nbsp;</a>
            </div>
            <div class="split">|</div>
            <div class="fr tool pr5 cot7 box-cc">

            </div>
            <div class="cbh0">
              <!---->
            </div>
          </div>
        </div>
      </ItemTemplate>
      <SeparatorTemplate>
        <div class="vien">
          <!---->
        </div>
      </SeparatorTemplate>
    </asp:Repeater>
  </div>
  <div class="cb h25">
    <!---->
  </div>
</div>

<div id="FooterRightControl">
  <div class="pdFooterR">
    <div class="ColPagging">
      <div class="AdminPagging">
        <asp:Literal ID="LtPagging" runat="server"></asp:Literal></div>
    </div>
    <div class="ColShowItem">
      <div class="TextShow">Hiển thị</div>
      <div class="BoxShow">
        <asp:DropDownList ID="DdlListShowItem" runat="server" Width="50px"
          Height="19px" CssClass="TextInBox" AutoPostBack="True"
          OnSelectedIndexChanged="DdlListShowItem_SelectedIndexChanged">
          <asp:ListItem Value="10">10</asp:ListItem>
          <asp:ListItem Value="20">20</asp:ListItem>
          <asp:ListItem Value="30">30</asp:ListItem>
          <asp:ListItem Value="50">50</asp:ListItem>
          <asp:ListItem Value="100">100</asp:ListItem>
        </asp:DropDownList>
      </div>
      <div class="cb">
        <!---->
      </div>
    </div>
    <div class="cbh0">
      <!---->
    </div>
  </div>
</div>