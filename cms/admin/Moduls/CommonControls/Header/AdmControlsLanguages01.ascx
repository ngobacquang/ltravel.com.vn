<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AdmControlsLanguages01.ascx.cs" Inherits="cms_admin_Moduls_CommonControls_AdmControlsLanguages01" %>
<%@ Import Namespace="TatThanhJsc.Extension" %>
<%@ Import Namespace="TatThanhJsc.LanguageModul" %>
<script type="text/javascript">
    function ShowListLanguage() {
        var list = $(".imgFlag");        
        for (var i = 0; i < list.length; i++) {
            $(list[i]).css("top", (i + 1) * 25);
        }
        $(".pdFlatLang").css({ 'height': (list.length + 1) * 25, 'background': '#fff' });        
    }
    function HideListLanguage() {
        $(".imgFlag").css("top", 3);
        $(".pdFlatLang").css({ 'height': 25,'background': 'none' });        
    }
</script>
<style>
  #AdmHeader #AdmControlsHeaderTopMenu .pdFlatLang { top: -3px; width: 36px }
  #AdmHeader #AdmControlsHeaderTopMenu .pdFlatLang .imgFlag, #AdmHeader #AdmControlsHeaderTopMenu .pdFlatLang .imgFlagCurrent { width: 20px; height: auto }
</style>
<div class="pdFlatLang" onmouseover="ShowListLanguage()" onmouseout="HideListLanguage()">    
    <asp:Repeater ID="rptList" runat="server" onitemcommand="rptList_ItemCommand">
        <ItemTemplate>            
            <asp:LinkButton ID="lbtSelectLanguage" runat="server" CommandName="select" CommandArgument='<%#Eval("iLanguageNationalId").ToString()%>' ToolTip="Click vào để chọn ngôn ngữ này" CausesValidation="false">                
                <%#ImagesExtension.GetImage(FolderPic.Language, Eval("nLanguageNationalFlag").ToString(), Eval(TatThanhJsc.Columns.LanguageNationalColumns.nLanguageNationalName).ToString(), "imgFlag" + SetCurrentLanguage(Eval(TatThanhJsc.Columns.LanguageNationalColumns.iLanguageNationalId).ToString()), false, false, "")%>
            </asp:LinkButton>                        
        </ItemTemplate>
    </asp:Repeater>
    <div class="cbh8"><!----></div>    
</div>