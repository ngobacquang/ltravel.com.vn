<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AdmControlsHeaderTopMenu.ascx.cs" Inherits="cms_admin_Controls_Header_AdmControlsHeaderTopMenu" %>
<%@ Register Src="AdmControlsLanguages01.ascx" TagName="AdmControlsLanguages01" TagPrefix="uc1" %>
<div id="AdmControlsHeaderTopMenu">
  <div class="BgCenterControls">
    <div class="MesAccount">
      <div class="HelloUserName">
        <span>Xin chào 
                    <asp:LinkButton ID="lnk_about_username" runat="server" OnClick="lnk_about_username_Click" CssClass="UserName">
                      <asp:Literal ID="lt_username" runat="server"></asp:Literal>
                    </asp:LinkButton>
        </span>
      </div>
      <div class='linkLogout'>
        &nbsp;
                [<asp:LinkButton ID="lnk_logout" runat="server" OnClick="lnk_logout_Click" CssClass="LbOut" CausesValidation="false"> Thoát </asp:LinkButton>]
      </div>
      <%--<div class="cbh0"><!----></div>--%>
    </div>
    <div class="SpaceCol">|</div>
    <div class='fl'>
      <asp:LinkButton ID="LbAccount" runat="server" CssClass="LnkManagerInfoAccount" OnClick="LbAccount_Click" CausesValidation="false">Tài khoản</asp:LinkButton>
    </div>
    <div class="SpaceCol">|</div>
    <div class='fl'>
      <asp:LinkButton ID="LbLbSystem" runat="server" CssClass="LnkManagerInfoAccount" OnClick="LbSystem_Click" CausesValidation="false">Hệ thống</asp:LinkButton>
    </div>
    <%--        <div class="SpaceCol">|</div>
        <div class='fl'>
            <asp:LinkButton ID="LbAboutTatThanhCms" runat="server" CssClass="LnkManagerInfoAccount" CausesValidation="false">Giới thiệu</asp:LinkButton>
        </div>--%>

    <asp:Panel ID="pnWebsiteModul" runat="server" CssClass="fl">
      <div class="SpaceCol">|</div>
      <div class='fl'>
        <a class="LnkManagerInfoAccount" href="<%=TatThanhJsc.WebsiteModul.Link.LnkMnWebsite() %>">Danh sách website</a>
      </div>
    </asp:Panel>

    <asp:Panel ID="pnLanguage" runat="server" CssClass="fl">
      <div class="SpaceCol">|</div>
      <div class='fl'>
        <asp:LinkButton ID="lbLanguage" runat="server" CssClass="LnkManagerInfoAccount" OnClick="lbLanguage_Click" CausesValidation="false">Ngôn ngữ</asp:LinkButton>
      </div>
      <div class='fl'>
        <uc1:AdmControlsLanguages01 ID="AdmControlsLanguages011" runat="server" />
      </div>
    </asp:Panel>

    <div class="cbh0">
      <!---->
    </div>
    <div class="BgRightControls">&nbsp;</div>
    <div class="BgLeftControls">&nbsp;</div>
  </div>
  <div class="cbh0">
    <!---->
  </div>
</div>
