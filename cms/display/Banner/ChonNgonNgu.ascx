<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ChonNgonNgu.ascx.cs" Inherits="cms_display_Banner_ChonNgonNgu" %>
<%@ Import Namespace="TatThanhJsc.Extension" %>
<%@ Import Namespace="TatThanhJsc.LanguageModul" %>

<div class="blog change-language">
  <ul>
    <asp:Repeater ID="rptList" runat="server" OnItemCommand="rptList_ItemCommand">
      <ItemTemplate>
        <li>
          <asp:LinkButton ID="lbtSelectLanguage" CssClass="link action-change" runat="server" CommandName="select" CommandArgument='<%#Eval("iLanguageNationalId").ToString()%>' ToolTip="Click vào để chọn ngôn ngữ này" CausesValidation="false">                
            <%#ImagesExtension.GetImage(FolderPic.Language, Eval("nLanguageNationalFlag").ToString(), Eval(TatThanhJsc.Columns.LanguageNationalColumns.nLanguageNationalName).ToString(), SetCurrentLanguage(Eval(TatThanhJsc.Columns.LanguageNationalColumns.iLanguageNationalId).ToString()), false, false, "")%>
          </asp:LinkButton>
        </li>
      </ItemTemplate>
    </asp:Repeater>
  </ul>
</div>