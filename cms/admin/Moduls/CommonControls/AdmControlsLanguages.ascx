<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AdmControlsLanguages.ascx.cs" Inherits="cms_admin_Moduls_CommonControls_AdmControlsLanguages" %>
<%@ Import Namespace="TatThanhJsc.Extension" %>
<%@ Import Namespace="TatThanhJsc.LanguageModul" %>
<div class="pdFlatLang">    
    <asp:Repeater ID="rptList" runat="server" onitemcommand="rptList_ItemCommand">
        <ItemTemplate>
            <div class="FormatFlatLang">                
                <asp:LinkButton ID="lbtSelectLanguage" runat="server" CommandName="select" CommandArgument='<%#Eval("iLanguageNationalId").ToString()%>' ToolTip="Click vào để chọn ngôn ngữ này" CausesValidation="false">                
                    <%#ImagesExtension.GetImage(FolderPic.Language, Eval("nLanguageNationalFlag").ToString(), Eval(TatThanhJsc.Columns.LanguageNationalColumns.nLanguageNationalName).ToString(), "imgFlag" + SetCurrentLanguage(Eval(TatThanhJsc.Columns.LanguageNationalColumns.iLanguageNationalId).ToString()), false, false, "")%>
                </asp:LinkButton>
            </div>                
        </ItemTemplate>
    </asp:Repeater>
    <div class="cbh0"><!----></div>
</div>